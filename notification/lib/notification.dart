import 'dart:async';
import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hgs_database_api/database_api.dart';
import 'package:hgs_framework/framework.dart';
import 'package:hgs_work/scheduled_timer.dart';

import 'action.dart';
import 'args.dart';
import 'local.dart';
import 'node.dart';

export 'action.dart';
export 'args.dart';
export 'callback.dart';
export 'node.dart';
export 'payload.dart';
export 'type.dart';

/// 通知助手
/// 需要数据库持久化提醒数据，数据库未初始化提醒只在当前运行时间内生效
class NotificationHelper with AppInitPlugin, AppRebuildPlugin {
  NotificationHelper._({int? maxCount}) : _maxCount = maxCount ?? 64;

  factory NotificationHelper({int? maxCount}) => SingletonCache.putIfAbsent(NotificationHelper._(maxCount: maxCount));

  /// 是否持久化数据
  late bool _useDb;

  /// 设备支持的最大提醒数量
  /// ios为64
  int _maxCount;

  /// 通知监听器
  final Map<String, void Function(NotificationAction action)> _listener = {};

  @override
  Future<bool> init(AppConfig config) async {
    _log("初始化通知助手");
    _useDb = DatabaseHelper().isInit;
    if (!_useDb) _log("数据库未初始化，提醒数据不会持久化");
    // 初始化本地通知插件
    await LocalNotificationHelper.init();
    // 查询数据库数据
    await _find(tx: null);
    // 检查通知
    checkAutoNotification();
    // 检查是否是由通知启动应用
    appLogic.listenOnReady("notification", () {
      if (LocalNotificationHelper.launchDetails?.didNotificationLaunchApp != true) return _log("非通知启动应用");
      String? payload = LocalNotificationHelper.launchDetails?.payload;
      _log("通过通知启动应用，使用通知负载触发回调，通知负载$payload");
      LocalNotificationHelper.onSelectNotification(payload);
    });
    return true;
  }

  /// 日志
  void _log(String msg) => log("[通知助手]:$msg");

  /// 错误日志
  void _logError(String msg) => log("[通知助手错误]:$msg");

  /// 添加提醒监听
  void addListener(String key, void Function(NotificationAction action) callback) => _listener[key] = callback;

  /// 启动检查是否通知，用于AppInit
  Future<void> checkAutoNotification() async {
    _log("启动检查定时任务");
    // 定时执行器
    late ScheduledTimer timer;
    timer = ScheduledTimer.fromId(
      id: "auto_send_notification",
      onExecute: () async {
        _log("定时任务执行，执行时间${DateTime.now()}");
        // 发送通知
        DateTime? dateTime = await notify();
        // 时间不为空，说明是notification已经设置过下次执行时间了
        if (null != dateTime) return _log("定时任务执行完成，下次任务执行时间$dateTime");
        List<PendingNotificationRequest> pendingList = await LocalNotificationHelper.checkPendingNotificationRequests();
        // 下次执行时间
        DateTime next;
        if (pendingList.isEmpty) {
          next = DateTime.now().add(const Duration(hours: 1));
        } else {
          PendingNotificationRequest last = pendingList.last;
          int id = last.id;
          Set<String>? encodeSet = idCache[id];
          if (null == encodeSet || encodeSet.isEmpty) {
            next = DateTime.now().add(const Duration(hours: 1));
          } else {
            DateTime? dateTime;
            for (String encode in encodeSet) {
              NotificationNode? node = nodeCache[encode];
              if (null == node) continue;
              if (node.dateTime.isBefore(DateTime.now())) continue;
              if (null == dateTime || node.dateTime.isBefore(dateTime)) {
                dateTime == node.dateTime;
              }
            }
            next = dateTime ?? DateTime.now().add(const Duration(hours: 1));
          }
        }
        // 更新计时器
        timer.schedule(next);
        _log("定时任务执行完成，下次任务执行时间$next");
      },
      onMissedSchedule: () {
        _log("错过定时任务执行时间，立即执行");
        timer.execute();
      },
    );
    if (timer.scheduledTime == null) {
      _log("定时任务执行时间为空，尝试从数据库中加载");
      await timer.load();
    }
    if (timer.scheduledTime != null) {
      _log("定时任务执行时间不为空,执行定时任务");
      timer.start();
    }
    _log("启动检查定时任务完成");
  }

  /// 刷新缓存数据
  @override
  Future<bool> rebuild(AppConfig config, {Transaction? tx}) async {
    await LocalNotificationHelper.cancelAllNotifications();
    idCache.clear();
    dbCache.clear();
    oldDbCache.clear();
    dateTimeCache.clear();
    oldDateTimeCache.clear();
    nodeCache.clear();
    await _find(tx: tx);
    notify(tx: tx);
    return true;
  }

  /// node缓存，防止多次decode
  final Map<String, NotificationNode> nodeCache = {};

  /// 通知id和通知负载的映射 缓存 value是[nodeCache]的key
  final Map<int, Set<String>> idCache = {};

  /// 提醒 内存缓存
  final Set<String> dbCache = {};

  /// 过时的提醒 内存缓存
  final Set<String> oldDbCache = {};

  /// 通知时间和通知id的映射 缓存，由于同一时间可能多个提醒，value设置为Set类型
  final Map<DateTime, Set<String>> dateTimeCache = {};

  /// 过时的提醒缓存 缓存
  final Map<DateTime, Set<String>> oldDateTimeCache = {};

  /// 过期的通知数据的key
  final String oldNotificationCache = "notification_cache_old";

  /// 所有存储的通知数据的key
  final String notificationCache = "notification_cache";

  /// 查询数据库数据并处理
  /// 将数据库的数据读到[oldDbCache]和[dbCache]变量中，如果变量有值则跳过
  Future<void> _find({Transaction? tx}) async {
    if (oldDbCache.isEmpty) {
      _log("通知历史 内存缓存 不存在，查询数据库 并 处理数据 到 内存缓存");
      if (_useDb) {
        for (dynamic value in DatabaseHelper().kv.get(oldNotificationCache) ?? []) {
          if (null == value) continue;
          oldDbCache.add(value.toString());
        }
      }
      // 遍历数据处理
      for (String oneDbCache in oldDbCache) {
        NotificationNode? oneDbCacheNode = NotificationNode.decode(oneDbCache);
        if (null == oneDbCacheNode) {
          _logError("通知$oneDbCache解码失败，跳过");
          continue;
        }
        int oneDbId = oneDbCacheNode.id;
        DateTime oneDbDateTime = oneDbCacheNode.dateTime;
        nodeCache[oneDbCache] = oneDbCacheNode;
        idCache.putIfAbsent(oneDbId, () => {}).add(oneDbCache);
        oldDateTimeCache.putIfAbsent(oneDbDateTime, () => {}).add(oneDbCache);
      }
      _log("通知历史处理完成");
    }
    if (dbCache.isEmpty) {
      _log("通知 内存缓存 不存在，查询数据库 并 处理数据 到 内存缓存");
      // 此刻
      DateTime now = DateTime.now();
      // 存储的数据
      List cloneDbCache;
      if (_useDb) {
        cloneDbCache = DatabaseHelper().kv.get(notificationCache) ?? [];
      } else {
        cloneDbCache = [];
      }
      bool hasChange = false;
      for (int i = 0; i < cloneDbCache.length; i++) {
        String? oneDbCache = cloneDbCache[i] as String?;
        if (null == oneDbCache) continue;
        NotificationNode? oneDbCacheNode = NotificationNode.decode(oneDbCache);
        if (null == oneDbCacheNode) {
          _logError("通知$oneDbCache解码失败，跳过");
          continue;
        }
        int oneDbId = oneDbCacheNode.id;
        DateTime oneDbDateTime = oneDbCacheNode.dateTime;
        nodeCache[oneDbCache] = oneDbCacheNode;
        idCache.putIfAbsent(oneDbId, () => {}).add(oneDbCache);
        if (oneDbDateTime.isBefore(now)) {
          hasChange = true;
          _log("通知{id:$oneDbId}的时间$oneDbDateTime早于此刻$now，转入通知历史。通知内容$oneDbCache");
          // 过时的提醒加入过时的缓存
          oldDateTimeCache.putIfAbsent(oneDbDateTime, () => {}).add(oneDbCache);
          oldDbCache.add(oneDbCache);
        } else {
          dateTimeCache.putIfAbsent(oneDbDateTime, () => {}).add(oneDbCache);
          dbCache.add(oneDbCache);
        }
      }
      if (hasChange) await flushCache(tx: tx);
      _log("通知缓存处理完成");
    }
    for (var listener in _listener.values) {
      listener(NotificationAction.find);
    }
  }

  /// 添加提醒缓存节点
  /// 所有提醒方法均需要调用这个方法添加提醒 然后调用[notify]检查并发送
  Future<void> _add(NotificationNode cacheNode, {Transaction? tx}) async {
    String cacheNodeStr = cacheNode.encode();
    _log("[添加缓存]添加通知到通知缓存，通知数据$cacheNodeStr");
    // 缓存节点
    int id = cacheNode.id;
    DateTime dateTime = cacheNode.dateTime;
    _log("[添加缓存]检查缓存");
    await _find(tx: tx);
    if (nodeCache.containsKey(cacheNodeStr)) return _log("[添加缓存]通知已存在，添加完成");
    nodeCache[cacheNodeStr] = cacheNode;
    // id缓存
    idCache.putIfAbsent(id, () => {}).add(cacheNodeStr);
    // 此刻
    DateTime now = DateTime.now();
    if (dateTime.isBefore(now)) {
      _log("[添加缓存]通知的通知时间{$dateTime}早于此刻{$now}，不通知，放入通知历史");
      // 更新缓存
      oldDbCache.add(cacheNodeStr);
      // 时间缓存
      oldDateTimeCache.putIfAbsent(dateTime, () => {}).add(cacheNodeStr);
      _log("[添加缓存]通知放入通知历史完成");
    } else {
      _log("[添加缓存]通知的通知时间{$dateTime}晚于此刻{$now}，放入通知缓存");
      // 更新缓存
      dbCache.add(cacheNodeStr);
      // 时间缓存
      dateTimeCache.putIfAbsent(dateTime, () => {}).add(cacheNodeStr);
      _log("[添加缓存]通知放入通知缓存完成");
    }
    await flushCache(tx: tx);
    for (var listener in _listener.values) {
      listener(NotificationAction.add);
    }
  }

  /// 检查并发送通知
  /// 用于实际上发送通知
  Future<DateTime?> notify({Transaction? tx}) async {
    _log("[发送通知]检查缓存");
    await _find(tx: tx);
    // 这里取消所有提醒的原因是，有可能先加晚点的提醒，后加早点的提醒，不取消的话就会导致早点的提醒发不出去
    // 也可以一一比对，但是太复杂，容易出错
    _log("[发送通知]取消所有提醒");
    await LocalNotificationHelper.cancelAllNotifications();
    // 等待发送的id
    Set<String> noticed = {};
    int count = _maxCount;
    _log("[发送通知]设备最大通知数量限制:$_maxCount，可用数量:$count");
    // 最大数量小于等于0 或者 没有缓存 不处理
    if (count <= 0 || dateTimeCache.isEmpty) {
      _log("[发送通知]没有剩余空间，或缓存为空，不发送。发送通知完成");
      return null;
    }
    _log("[发送通知]按照通知时间排序");
    // 时间排序
    List<DateTime> dateTimeKeyList = dateTimeCache.keys.toList();
    dateTimeKeyList.sort((a, b) => a.compareTo(b));
    // 时间遍历
    for (DateTime dateTime in dateTimeKeyList) {
      _log("[发送通知]处理通知时间为$dateTime的通知");
      if (count <= 0) {
        _log("[发送通知]剩余数量为$count，结束处理");
        break;
      }
      DateTime now = DateTime.now();
      // 获取这个时间的提醒id列表 为空跳过
      Set<String> encodeSet = dateTimeCache[dateTime] ?? {};
      if (encodeSet.isEmpty) {
        _log("[发送通知]通知时间为$dateTime的通知为空，处理下一个时间");
        dateTimeCache.remove(dateTime);
        continue;
      }
      // 早于此刻 放入历史缓存
      if (dateTime.isBefore(now)) {
        _log("[发送通知]通知时间$dateTime早于此刻$now，移入通知历史");
        for (String encode in encodeSet) {
          dbCache.remove(encode);
          oldDbCache.add(encode);
        }
        dateTimeCache.remove(dateTime);
        oldDateTimeCache.putIfAbsent(dateTime, () => {}).addAll(encodeSet);
        _log("[发送通知]通知时间$dateTime的通知移入通知历史完成，处理下一个时间");
        continue;
      }
      // 不早于此刻遍历提醒
      for (String encode in encodeSet) {
        _log("[发送通知]处理$encode通知");
        if (count <= 0) {
          _log("[发送通知]剩余数量为$count，结束处理");
          break;
        }
        // 已在提醒列表中 跳过
        if (noticed.contains(encode)) {
          _log("[发送通知]通知已存在于通知列表中，处理下一个通知");
          continue;
        }
        NotificationNode? cacheNode = nodeCache[encode];
        // 有问题的id 跳过
        if (null == cacheNode) {
          _logError("[发送通知]缓存中未找到$encode的通知，处理下一个通知");
          continue;
        }
        NotificationCacheNodeType type = cacheNode.type;
        // 根据不同提醒类型发送提醒
        switch (type) {
          case NotificationCacheNodeType.normal:
            _log("[发送通知]通知类型为$type,发送定时通知，通知时间${cacheNode.dateTime}，当前时间${DateTime.now()}");
            await LocalNotificationHelper.scheduleNotification(
              id: cacheNode.id,
              dateTime: cacheNode.dateTime,
              payload: cacheNode.payload,
              title: cacheNode.title,
              body: cacheNode.body,
            );
            break;
          case NotificationCacheNodeType.repeat:
            _log("[发送通知]通知类型为$type,发送重复通知");
            await LocalNotificationHelper.repeatNotification(
              id: cacheNode.id,
              payload: cacheNode.payload,
              title: cacheNode.title,
              body: cacheNode.body,
              repeatInterval: cacheNode.repeatInterval!,
            );
            break;
          case NotificationCacheNodeType.scheduleRepeat:
            _log("[发送通知]通知类型为$type,发送指定时间重复通知");
            await LocalNotificationHelper.scheduleNotification(
              id: cacheNode.id,
              dateTime: cacheNode.dateTime,
              payload: cacheNode.payload,
              title: cacheNode.title,
              body: cacheNode.body,
              matchDateTimeComponents: cacheNode.matchDateTimeComponents,
            );
            break;
        }
        noticed.add(encode);
        count--;
        _log("[发送通知]剩余可通知数量$count");
      }
    }
    _log("[发送通知]通知处理完成，刷新数据库缓存数据");
    // 刷新缓存
    await flushCache(tx: tx);
    List<PendingNotificationRequest> pendingList = await LocalNotificationHelper.checkPendingNotificationRequests();
    _log("[发送通知]检查待发送通知队列，通知数量${pendingList.length}");
    for (PendingNotificationRequest pending in pendingList) {
      _log("[发送通知]通知队列:${{"id": pending.id, "title": pending.title, "body": pending.body, "payload": pending.payload.toString()}}");
    }
    if (pendingList.isEmpty) {
      _log("[发送通知]通知队列为空，发送通知完成");
      return null;
    }
    PendingNotificationRequest last = pendingList.last;
    int id = last.id;
    _log("[发送通知]通知队列不为空，最后一个通知id为$id");
    Set<String>? encodeSet = idCache[id];
    if (null == encodeSet) {
      _log("[发送通知]缓存中未找到id为$id的通知，发送通知完成");
      return null;
    }
    DateTime? dateTime;
    for (String encode in encodeSet) {
      NotificationNode? cacheNode = nodeCache[encode];
      if (cacheNode == null) continue;
      DateTime nodeTime = cacheNode.dateTime;
      if (nodeTime.isBefore(DateTime.now())) continue;
      if (dateTime == null || nodeTime.isBefore(dateTime)) {
        dateTime = nodeTime;
      }
    }
    // 如果找不到下次执行的时间 1分钟后再次执行
    dateTime ??= DateTime.now().add(const Duration(minutes: 10));
    _log("[发送通知]更新或新增定时任务，预计定时任务时间:${dateTime.add(const Duration(microseconds: 200))}");
    _autoNotify(executeTime: dateTime.add(const Duration(microseconds: 200)));
    _log("[发送通知]发送通知完成");
    for (var listener in _listener.values) {
      listener(NotificationAction.notify);
    }
    return dateTime.add(const Duration(microseconds: 200));
  }

  /// 自动发送缓存的提醒
  Future<void> _autoNotify({DateTime? executeTime}) async {
    _log("[自动发送通知]更新或创建前台定时任务");
    // 没有传时间就立即执行
    DateTime scheduledTime = executeTime ?? DateTime.now().add(const Duration(seconds: 1));
    // 定时执行器
    late ScheduledTimer timer;
    timer = ScheduledTimer.fromId(
      id: "auto_send_notification",
      onExecute: () async {
        _log("[自动发送通知]定时任务执行，执行时间${DateTime.now()}");
        // 发送通知
        DateTime? dateTime = await notify();
        // 时间不为空，说明是notification已经设置过下次执行时间了
        if (null != dateTime) {
          _log("[自动发送通知]定时任务执行完成，下次任务执行时间$dateTime");
          return;
        }
        List<PendingNotificationRequest> pendingList = await LocalNotificationHelper.checkPendingNotificationRequests();
        // 下次执行时间
        DateTime next;
        if (pendingList.isEmpty) {
          next = DateTime.now().add(const Duration(minutes: 10));
        } else {
          PendingNotificationRequest last = pendingList.last;
          int id = last.id;
          Set<String>? encodeSet = idCache[id];
          if (null == encodeSet || encodeSet.isEmpty) {
            next = DateTime.now().add(const Duration(minutes: 10));
          } else {
            DateTime? dateTime;
            for (String encode in encodeSet) {
              NotificationNode? cacheNode = nodeCache[encode];
              if (cacheNode == null) continue;
              DateTime nodeTime = cacheNode.dateTime;
              if (nodeTime.isBefore(DateTime.now())) continue;
              if (dateTime == null || nodeTime.isBefore(dateTime)) {
                dateTime = nodeTime;
              }
            }
            next = dateTime ?? DateTime.now().add(const Duration(minutes: 10));
          }
        }
        // 更新计时器
        timer.schedule(next);
        _log("[自动发送通知]定时任务执行完成，下次任务执行时间$next");
      },
      onMissedSchedule: () {
        _log("[自动发送通知]错过定时任务执行时间，立即执行");
        timer.execute();
      },
    );
    if (timer.scheduledTime == null) {
      _log("[自动发送通知]定时任务上次执行时间为空，尝试从数据库中加载");
      await timer.load();
    }
    DateTime? oldScheduledTime = timer.scheduledTime;
    if (oldScheduledTime == null || oldScheduledTime.isBefore(DateTime.now())) {
      await timer.schedule(scheduledTime);
      _log("[自动发送通知]定时任务上次执行时间:$oldScheduledTime,定时任务下次执行时间:$scheduledTime");
    } else {
      if (oldScheduledTime.isAfter(scheduledTime)) {
        await timer.schedule(scheduledTime);
        _log("[自动发送通知]更新定时任务时间,旧的时间$oldScheduledTime,新的时间:$scheduledTime");
      } else {
        _log("[自动发送通知]旧的时间$oldScheduledTime早于新的时间:$scheduledTime，不更新定时任务时间");
      }
    }
    _log("[自动发送通知]更新或创建前台定时任务完成");
  }

  /// 显示简单通知，立即通知，不占用缓存
  Future<void> showNotification(NotificationArgs args, {Transaction? tx}) async {
    _log("立即通知:${{"id": args.id, "时间": DateTime.now(), "标题": args.title, "内容": args.body}}");
    await LocalNotificationHelper.showNotification(id: args.id, payload: args.payload, title: args.title, body: args.body);
    _log("立即通知完成{id:${args.id}}");
  }

  /// 延时通知
  /// 最好>200ms
  Future<void> delayNotification(DelayNotificationArgs args, {Transaction? tx}) async {
    DateTime dateTime = DateTime.now().add(args.duration);
    _log("延时通知:${{"id": args.id, "时间": dateTime, "标题": args.title, "内容": args.body}}");
    NotificationNode cacheNode = NotificationNode.normal(
      id: args.id,
      dateTime: dateTime,
      payload: args.payload,
      title: args.title,
      body: args.body,
    );
    await _add(cacheNode, tx: tx);
    await notify(tx: tx);
    _log("延时通知完成{id:${args.id}}");
  }

  /// 批量延时通知
  Future<void> batchDelayNotification(List<DelayNotificationArgs> argsList, {Transaction? tx}) async {
    _log("批量延时通知，数量${argsList.length}");
    for (DelayNotificationArgs args in argsList) {
      DateTime dateTime = DateTime.now().add(args.duration);
      _log("延时通知:${{"id": args.id, "时间": dateTime, "标题": args.title, "内容": args.body}}");
      NotificationNode cacheNode = NotificationNode.normal(
        id: args.id,
        dateTime: dateTime,
        payload: args.payload,
        title: args.title,
        body: args.body,
      );
      await _add(cacheNode, tx: tx);
    }
    await notify(tx: tx);
    _log("批量延时通知完成，数量${argsList.length}");
  }

  /// 重复通知
  /// 重复通知记录的时间是调用此方法的时间
  /// 重复通知如果下载覆盖数据需要重新发送通知
  Future<void> repeatNotification(RepeatNotificationArgs args, {Transaction? tx}) async {
    DateTime dateTime = DateTime.now().add(const Duration(milliseconds: 200));
    _log("重复通知:${{"id": args.id, "发起时间": dateTime, "重复周期": args.repeatInterval, "标题": args.title, "内容": args.body}}");
    NotificationNode cacheNode = NotificationNode.repeat(
      id: args.id,
      repeatInterval: args.repeatInterval,
      payload: args.payload,
      title: args.title,
      body: args.body,
      dateTime: dateTime,
    );
    await _add(cacheNode, tx: tx);
    await notify(tx: tx);
    _log("重复通知完成{id:${args.id}}");
  }

  /// 批量重复通知
  Future<void> batchRepeatNotification(List<RepeatNotificationArgs> argsList, {Transaction? tx}) async {
    _log("批量重复通知，数量${argsList.length}");
    for (RepeatNotificationArgs args in argsList) {
      DateTime dateTime = DateTime.now().add(const Duration(milliseconds: 200));
      _log("重复通知:${{"id": args.id, "发起时间": dateTime, "重复周期": args.repeatInterval, "标题": args.title, "内容": args.body}}");
      NotificationNode cacheNode = NotificationNode.repeat(
        id: args.id,
        repeatInterval: args.repeatInterval,
        payload: args.payload,
        title: args.title,
        body: args.body,
        dateTime: dateTime,
      );
      await _add(cacheNode, tx: tx);
    }
    await notify(tx: tx);
    _log("批量重复通知完成，数量${argsList.length}");
  }

  /// 定时通知 精确到分钟 超过当前时间忽略
  Future<void> scheduleNotification(ScheduleNotificationArgs args, {Transaction? tx}) async {
    _log("定时通知:${{"id": args.id, "时间": args.dateTime, "标题": args.title, "内容": args.body}}");
    NotificationNode cacheNode = NotificationNode.normal(
      id: args.id,
      dateTime: args.dateTime,
      payload: args.payload,
      title: args.title,
      body: args.body,
    );
    await _add(cacheNode, tx: tx);
    await notify(tx: tx);
    _log("定时通知完成{id:${args.id}}");
  }

  /// 批量定时通知 精确到分钟 超过当前时间忽略
  Future<void> batchScheduleNotification(List<ScheduleNotificationArgs> argsList, {Transaction? tx}) async {
    _log("批量定时通知，数量${argsList.length}");
    for (ScheduleNotificationArgs args in argsList) {
      _log("定时通知:${{"id": args.id, "时间": args.dateTime, "标题": args.title, "内容": args.body}}");
      NotificationNode cacheNode = NotificationNode.normal(
        id: args.id,
        dateTime: args.dateTime,
        payload: args.payload,
        title: args.title,
        body: args.body,
      );
      await _add(cacheNode, tx: tx);
    }
    await notify(tx: tx);
    _log("批量定时通知完成，数量${argsList.length}");
  }

  /// 指定时间重复通知
  /// 下载覆盖数据需要重新发送通知，因为记录的数据是调用此方法的时间
  Future<void> scheduleRepeatNotification(ScheduleRepeatNotificationArgs args, {Transaction? tx}) async {
    _log("定时重复通知:${{"id": args.id, "时间": args.dateTime, "重复周期": args.matchDateTimeComponents, "标题": args.title, "内容": args.body}}");
    NotificationNode cacheNode = NotificationNode.scheduleRepeat(
      id: args.id,
      dateTime: args.dateTime,
      payload: args.payload,
      title: args.title,
      body: args.body,
      matchDateTimeComponents: args.matchDateTimeComponents,
    );
    await _add(cacheNode, tx: tx);
    await notify(tx: tx);
    _log("定时通知完成{id:${args.id}}");
  }

  /// 批量定时重复通知 精确到分钟 超过当前时间忽略
  Future<void> batchScheduleRepeatNotification(List<ScheduleRepeatNotificationArgs> argsList, {Transaction? tx}) async {
    _log("批量定时重复通知，数量${argsList.length}");
    for (ScheduleRepeatNotificationArgs args in argsList) {
      _log("定时重复通知:${{"id": args.id, "时间": args.dateTime, "重复周期": args.matchDateTimeComponents, "标题": args.title, "内容": args.body}}");
      NotificationNode cacheNode = NotificationNode.scheduleRepeat(
        id: args.id,
        dateTime: args.dateTime,
        payload: args.payload,
        title: args.title,
        body: args.body,
        matchDateTimeComponents: args.matchDateTimeComponents,
      );
      await _add(cacheNode, tx: tx);
    }
    await notify(tx: tx);
    _log("批量定时重复通知完成，数量${argsList.length}");
  }

  /// 刷新缓存到数据库
  Future<void> flushCache({Transaction? tx}) async {
    if (!_useDb) return;
    DatabaseHelper().kv.put(notificationCache, dbCache.toList());
    DatabaseHelper().kv.put(oldNotificationCache, oldDbCache.toList());
    await DatabaseHelper().kv.save(tx: tx);
  }

  /// 恢复指定通知
  Future<void> recoverNotification(int id, {Transaction? tx}) async {
    _log("[恢复通知]检查缓存");
    await _find(tx: tx);
    Set<String>? encodeSet = idCache[id];
    if (null == encodeSet || encodeSet.isEmpty) return _log("[恢复通知]恢复通知完成");
    for (String encode in encodeSet) {
      NotificationNode? cacheNode = nodeCache[encode];
      if (null == cacheNode) continue;
      if (dbCache.contains(encode) || !oldDbCache.contains(encode)) continue;
      DateTime dateTime = cacheNode.dateTime;
      if (dateTime.isBefore(DateTime.now())) continue;
      nodeCache.remove(encode);
      oldDbCache.remove(encode);
      oldDateTimeCache[dateTime]?.remove(encode);
      await _add(cacheNode, tx: tx);
    }
    await notify(tx: tx);
    for (var listener in _listener.values) {
      listener(NotificationAction.recover);
    }
    _log("[恢复通知]恢复通知完成");
  }

  /// 取消指定通知 将通知移入历史通知
  Future<void> cancelNotification(int id, {Transaction? tx}) async {
    _log("[取消通知]取消通知");
    await LocalNotificationHelper.cancelNotification(id);
    _log("[取消通知]检查缓存");
    await _find(tx: tx);
    Set<String>? encodeSet = idCache[id];
    if (null == encodeSet || encodeSet.isEmpty) return _log("[取消通知]取消通知完成");
    for (String encode in encodeSet) {
      NotificationNode? cacheNode = nodeCache[encode];
      if (null == cacheNode) continue;
      DateTime dateTime = cacheNode.dateTime;
      dbCache.remove(encode);
      dateTimeCache.putIfAbsent(dateTime, () => {}).remove(encode);
      if (oldDbCache.contains(encode)) continue;
      oldDbCache.add(encode);
      oldDateTimeCache.putIfAbsent(dateTime, () => {}).add(encode);
    }
    await flushCache(tx: tx);
    for (var listener in _listener.values) {
      listener(NotificationAction.cancel);
    }
    _log("[取消通知]取消通知完成");
  }

  /// 取消所有通知 将通知移入历史通知
  Future<void> cancelAllNotifications({Transaction? tx}) async {
    _log("[取消所有通知]取消所有通知");
    await LocalNotificationHelper.cancelAllNotifications();
    _log("[取消所有通知]检查缓存");
    await _find(tx: tx);
    oldDbCache.addAll(dbCache);
    dbCache.clear();
    dateTimeCache.forEach((key, value) {
      oldDateTimeCache.putIfAbsent(key, () => {}).addAll(value);
    });
    dateTimeCache.clear();
    await flushCache(tx: tx);
    for (var listener in _listener.values) {
      listener(NotificationAction.cancel);
    }
    _log("[取消所有通知]取消所有通知完成");
  }

  /// 删除指定通知
  Future<void> removeNotification(int id, {Transaction? tx}) async {
    _log("[删除通知]删除本地通知");
    await LocalNotificationHelper.cancelNotification(id);
    _log("[删除通知]检查缓存");
    await _find(tx: tx);
    Set<String>? encodeSet = idCache[id];
    if (null == encodeSet) return _log("[删除通知]根据id未找到通知，删除完成");
    _log("[删除通知]清除缓存");
    for (String encode in encodeSet) {
      NotificationNode? cacheNode = nodeCache[encode];
      if (null == cacheNode) continue;
      DateTime dateTime = cacheNode.dateTime;
      dbCache.remove(encode);
      oldDbCache.remove(encode);
      dateTimeCache[dateTime]?.remove(encode);
      oldDateTimeCache[dateTime]?.remove(encode);
      nodeCache.remove(encode);
    }
    _log("[删除通知]清除缓存完成，更新数据库存储");
    await flushCache(tx: tx);
    idCache.remove(id);
    for (var listener in _listener.values) {
      listener(NotificationAction.remove);
    }
    _log("[删除通知]更新数据库存储完成，删除通知完成");
  }

  /// 删除所有通知
  Future<void> removeAllNotifications({Transaction? tx}) async {
    _log("[删除所有通知]删除本地所有通知");
    await LocalNotificationHelper.cancelAllNotifications();
    _log("[删除所有通知]检查缓存");
    await _find(tx: tx);
    _log("[删除所有通知]清除缓存");
    idCache.clear();
    dbCache.clear();
    oldDbCache.clear();
    dateTimeCache.clear();
    oldDateTimeCache.clear();
    nodeCache.clear();
    _log("[删除所有通知]清除缓存完成，更新数据库存储");
    await flushCache(tx: tx);
    for (var listener in _listener.values) {
      listener(NotificationAction.remove);
    }
    _log("[删除所有通知]更新数据库存储完成，删除所有完成");
  }
}
