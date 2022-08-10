import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hg_framework/ability/export.dart';
import 'package:hg_framework/app/export.dart';
import 'package:hg_orm/hg_orm.dart';
import 'package:scheduled_timer/scheduled_timer.dart';

import 'notification_local.dart';

/// 提醒类型
enum NotificationCacheNodeType {
  normal,
  repeat,
  scheduleRepeat,
}

extension NotificationCacheNodeTypeEx on NotificationCacheNodeType {
  String get title {
    switch (this) {
      case NotificationCacheNodeType.normal:
        return "一般通知";
      case NotificationCacheNodeType.repeat:
        return "重复通知";
      case NotificationCacheNodeType.scheduleRepeat:
        return "定时通知";
    }
  }
}

/// 通知方法参数
class NotificationArgs {
  final int id;

  final NotificationPayload? payload;

  final String? title;

  final String? body;

  NotificationArgs({
    required this.id,
    this.payload,
    this.title,
    this.body,
  });
}

/// 普通通知方法参数
class ScheduleNotificationArgs extends NotificationArgs {
  final DateTime dateTime;

  ScheduleNotificationArgs({
    required int id,
    NotificationPayload? payload,
    String? title,
    String? body,
    required this.dateTime,
  }) : super(id: id, payload: payload, title: title, body: body);
}

/// 重复通知方法参数
class RepeatNotificationArgs extends NotificationArgs {
  final RepeatInterval repeatInterval;

  RepeatNotificationArgs({
    required int id,
    NotificationPayload? payload,
    String? title,
    String? body,
    required this.repeatInterval,
  }) : super(id: id, payload: payload, title: title, body: body);
}

/// 延迟通知方法参数
class DelayNotificationArgs extends NotificationArgs {
  final Duration duration;

  DelayNotificationArgs({
    required int id,
    NotificationPayload? payload,
    String? title,
    String? body,
    required this.duration,
  }) : super(id: id, payload: payload, title: title, body: body);
}

/// 指定时间重复通知方法参数
class ScheduleRepeatNotificationArgs extends NotificationArgs {
  final DateTime dateTime;
  final DateTimeComponents matchDateTimeComponents;

  ScheduleRepeatNotificationArgs({
    required int id,
    NotificationPayload? payload,
    String? title,
    String? body,
    required this.dateTime,
    required this.matchDateTimeComponents,
  }) : super(id: id, payload: payload, title: title, body: body);
}

/// 通知缓存节点
class NotificationCacheNode {
  /// 节点类型
  NotificationCacheNodeType type;
  static const String _typeKey = "type";

  /// 需要保证唯一性 通知ID
  int id;
  static const String _idKey = "id";

  /// 通知负载
  NotificationPayload? payload;
  static const String _payloadKey = "payload";

  /// 通知标题
  String? title;
  static const String _titleKey = "title";

  /// 通知内容
  String? body;
  static const String _bodyKey = "body";

  /// 通知时间
  DateTime dateTime;
  static const String _dateTimeKey = "dateTime";

  /// 重复规则 当type为[NotificationCacheNodeType.repeat]时生效
  RepeatInterval? repeatInterval;
  static const String _repeatIntervalKey = "repeatInterval";

  /// 指定时间重复规则 当type为[NotificationCacheNodeType.scheduleRepeat]时生效
  DateTimeComponents? matchDateTimeComponents;
  static const String _matchDateTimeComponentsKey = "matchDateTimeComponents";

  NotificationCacheNode.normal({
    required this.id,
    this.payload,
    this.title,
    this.body,
    required this.dateTime,
  }) : type = NotificationCacheNodeType.normal;

  /// 重复提醒的缓存节点
  NotificationCacheNode.repeat({
    required this.id,
    this.payload,
    this.title,
    this.body,
    required this.dateTime,
    required this.repeatInterval,
  }) : type = NotificationCacheNodeType.repeat;

  /// 指定时间重复缓存节点
  NotificationCacheNode.scheduleRepeat({
    required this.id,
    this.payload,
    this.title,
    this.body,
    required this.dateTime,
    required this.matchDateTimeComponents,
  }) : type = NotificationCacheNodeType.scheduleRepeat;

  /// 解码
  static NotificationCacheNode? decode(String? encode) {
    if (null == encode) return null;
    Map<String, dynamic> encodeMap = json.decode(encode);
    // id
    int? id = encodeMap[_idKey];
    if (null == id) return null;
    String? typeStr = encodeMap[_typeKey];
    // 类型
    NotificationCacheNodeType type = null == typeStr ? NotificationCacheNodeType.normal : _getCacheNodeTypeByString(typeStr);
    // 标题
    String? title = encodeMap[_titleKey];
    // 内容
    String? body = encodeMap[_bodyKey];
    // 负载
    String? payloadEncode = encodeMap[_payloadKey];
    NotificationPayload? payload = NotificationPayload.decode(payloadEncode);
    // 时间
    dynamic dateTimeStr = encodeMap[_dateTimeKey];
    DateTime dateTime;
    if (dateTimeStr == null) {
      dateTime = DateTime.now();
    } else if (dateTimeStr is int) {
      dateTime = DateTime.fromMillisecondsSinceEpoch(dateTimeStr);
    } else {
      dateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(dateTimeStr));
    }

    switch (type) {
      case NotificationCacheNodeType.normal:
        return NotificationCacheNode.normal(id: id, dateTime: dateTime, payload: payload, title: title, body: body);
      case NotificationCacheNodeType.repeat:
        // 重复周期
        String? repeatIntervalStr = encodeMap[_repeatIntervalKey];
        RepeatInterval? repeatInterval = repeatIntervalStr == null ? null : _getRepeatIntervalByString(repeatIntervalStr);
        return NotificationCacheNode.repeat(id: id, payload: payload, title: title, body: body, repeatInterval: repeatInterval, dateTime: dateTime);
      case NotificationCacheNodeType.scheduleRepeat:
        // 指定时间重复周期
        String? dateTimeComponentsStr = encodeMap[_matchDateTimeComponentsKey];
        DateTimeComponents? dateTimeComponents = dateTimeComponentsStr == null ? null : _getDateTimeComponentsByString(dateTimeComponentsStr);
        return NotificationCacheNode.scheduleRepeat(
          id: id,
          dateTime: dateTime,
          payload: payload,
          title: title,
          body: body,
          matchDateTimeComponents: dateTimeComponents,
        );
    }
  }

  /// 编码
  String encode() {
    return json.encode({
      _typeKey: type.toString(),
      _idKey: id,
      _titleKey: title,
      _bodyKey: body,
      _payloadKey: payload?.encode(),
      _dateTimeKey: dateTime.millisecondsSinceEpoch,
      _repeatIntervalKey: repeatInterval?.toString(),
      _matchDateTimeComponentsKey: matchDateTimeComponents?.toString(),
    });
  }

  /// 获取缓存类型
  static NotificationCacheNodeType _getCacheNodeTypeByString(String typeStr) {
    if (typeStr == NotificationCacheNodeType.normal.toString()) return NotificationCacheNodeType.normal;
    if (typeStr == NotificationCacheNodeType.repeat.toString()) return NotificationCacheNodeType.repeat;
    if (typeStr == NotificationCacheNodeType.scheduleRepeat.toString()) return NotificationCacheNodeType.scheduleRepeat;
    return NotificationCacheNodeType.normal;
  }

  /// 获取重复周期
  static RepeatInterval _getRepeatIntervalByString(String repeatIntervalStr) {
    if (repeatIntervalStr == RepeatInterval.everyMinute.toString()) return RepeatInterval.everyMinute;
    if (repeatIntervalStr == RepeatInterval.hourly.toString()) return RepeatInterval.hourly;
    if (repeatIntervalStr == RepeatInterval.daily.toString()) return RepeatInterval.daily;
    if (repeatIntervalStr == RepeatInterval.weekly.toString()) return RepeatInterval.weekly;
    return RepeatInterval.everyMinute;
  }

  /// 获取指定时间重复周期
  static DateTimeComponents _getDateTimeComponentsByString(String dateTimeComponentsStr) {
    if (dateTimeComponentsStr == DateTimeComponents.time.toString()) return DateTimeComponents.time;
    if (dateTimeComponentsStr == DateTimeComponents.dayOfWeekAndTime.toString()) return DateTimeComponents.dayOfWeekAndTime;
    if (dateTimeComponentsStr == DateTimeComponents.dayOfMonthAndTime.toString()) return DateTimeComponents.dayOfMonthAndTime;
    if (dateTimeComponentsStr == DateTimeComponents.dateAndTime.toString()) return DateTimeComponents.dateAndTime;
    return DateTimeComponents.time;
  }
}

enum NotificationAction {
  find,
  add,
  notify,
  cancel,
  remove,
  recover,
}

/// 通知助手
class NotificationHelper {
  NotificationHelper._();

  /// 日志
  static _log(String msg) => LogHelper.info("[通知助手]:$msg");

  /// 监听器
  static final Map<String, void Function(NotificationAction action)> _listener = {};

  static void addListener(String key, void Function(NotificationAction action) callback) {
    _listener[key] = callback;
  }

  /// 初始化 用于应用启动时调用
  static Future<bool?> init() async {
    _log("初始化通知助手");
    _log("初始化本地通知");
    await LocalNotificationHelper.init();
    _log("查询数据库数据");
    await _findInDatabase(tx: null);
    _log("检查前台任务");
    NotificationHelper.checkAutoNotification();
    _log("注册应用启动回调，检测是否通过通知启动应用");
    AppLogic.instance.listenOnReady("notification", () {
      if (LocalNotificationHelper.launchDetails?.didNotificationLaunchApp == true) {
        String? payload = LocalNotificationHelper.launchDetails?.payload;
        _log("通过通知启动应用，使用通知负载触发回调，通知负载$payload");
        LocalNotificationHelper.onSelectNotification(payload);
      } else {
        _log("非通知启动应用");
      }
    });
    _log("通知助手初始化完成");
    return true;
  }

  /// 启动检查是否通知，用于AppInit
  static Future<void> checkAutoNotification() async {
    _log("启动检查定时任务");
    // 定时执行器
    late ScheduledTimer timer;
    timer = ScheduledTimer.fromId(
      id: "auto_send_notification",
      onExecute: () async {
        _log("定时任务执行，执行时间${DateTime.now()}");
        // 发送通知
        DateTime? dateTime = await _notification();
        // 时间不为空，说明是notification已经设置过下次执行时间了
        if (null != dateTime) {
          _log("定时任务执行完成，下次任务执行时间$dateTime");
          return;
        }
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
              NotificationCacheNode? node = nodeCache[encode];
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
  static Future<void> refresh({Transaction? tx}) async {
    await LocalNotificationHelper.cancelAllNotifications();
    idCache.clear();
    dbCache.clear();
    oldDbCache.clear();
    dateTimeCache.clear();
    oldDateTimeCache.clear();
    nodeCache.clear();
    await _findInDatabase(tx: tx);
    _notification(tx: tx);
  }

  /// node缓存，防止多次decode
  static final Map<String, NotificationCacheNode> nodeCache = {};

  /// 通知id和通知负载的映射 缓存
  static final Map<int, Set<String>> idCache = {};

  /// 数据库的 内存缓存
  static final Set<String> dbCache = {};

  /// 过时的提醒 内存缓存
  static final Set<String> oldDbCache = {};

  /// 通知时间和通知id的映射 缓存，由于同一时间可能多个提醒，value设置为Set类型
  static final Map<DateTime, Set<String>> dateTimeCache = {};

  /// 过时的提醒缓存  缓存
  static final Map<DateTime, Set<String>> oldDateTimeCache = {};

  /// 过期的通知数据的key
  static const String oldNotificationCache = "notification_cache_old";

  /// 所有存储的通知数据的key
  static const String notificationCache = "notification_cache";

  /// 查询数据库数据并处理
  /// 将数据库的数据读到[oldDbCache]和[dbCache]变量中，如果变量有值则跳过
  static Future<void> _findInDatabase({Transaction? tx}) async {
    _log("调用findInDatabase");
    if (oldDbCache.isEmpty) {
      _log("通知历史 内存缓存 不存在，查询数据库 并 处理数据 到 内存缓存");
      for (dynamic value in DatabaseHelper.kv.get(oldNotificationCache) ?? []) {
        if (null == value) continue;
        oldDbCache.add(value.toString());
      }
      // 遍历数据处理
      for (String oneDbCache in oldDbCache) {
        NotificationCacheNode? oneDbCacheNode = NotificationCacheNode.decode(oneDbCache);
        if (null == oneDbCacheNode) {
          _log("通知$oneDbCache解码失败，跳过");
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
      List cloneDbCache = DatabaseHelper.kv.get(notificationCache) ?? [];
      bool hasChange = false;
      for (int i = 0; i < cloneDbCache.length; i++) {
        String? oneDbCache = cloneDbCache[i] as String?;
        if (null == oneDbCache) continue;
        NotificationCacheNode? oneDbCacheNode = NotificationCacheNode.decode(oneDbCache);
        if (null == oneDbCacheNode) {
          _log("通知$oneDbCache解码失败，跳过");
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
    _log("findInDatabase调用完成");
  }

  /// 添加提醒缓存节点
  /// 所有提醒方法均需要调用这个方法添加提醒 然后调用[_notification]检查并发送
  static Future<void> _addNotificationToCache(NotificationCacheNode cacheNode, {Transaction? tx}) async {
    String cacheNodeStr = cacheNode.encode();
    _log("添加通知到通知缓存，通知数据$cacheNodeStr");
    // 缓存节点
    int id = cacheNode.id;
    DateTime dateTime = cacheNode.dateTime;
    _log("检查缓存");
    await _findInDatabase(tx: tx);
    if (nodeCache.containsKey(cacheNodeStr)) return _log("通知已存在，添加完成");
    nodeCache[cacheNodeStr] = cacheNode;
    // id缓存
    idCache.putIfAbsent(id, () => {}).add(cacheNodeStr);
    // 此刻
    DateTime now = DateTime.now();
    if (dateTime.isBefore(now)) {
      _log("通知的通知时间{$dateTime}早于此刻{$now}，不通知，放入通知历史");
      // 更新缓存
      oldDbCache.add(cacheNodeStr);
      // 时间缓存
      oldDateTimeCache.putIfAbsent(dateTime, () => {}).add(cacheNodeStr);
      _log("通知放入通知历史完成");
    } else {
      _log("通知的通知时间{$dateTime}晚于此刻{$now}，放入通知缓存");
      // 更新缓存
      dbCache.add(cacheNodeStr);
      // 时间缓存
      dateTimeCache.putIfAbsent(dateTime, () => {}).add(cacheNodeStr);
      _log("通知放入通知缓存完成");
    }
    await flushCache(tx: tx);
    for (var listener in _listener.values) {
      listener(NotificationAction.add);
    }
  }

  /// 检查并发送通知
  /// 用于实际上发送通知
  static Future<DateTime?> _notification({Transaction? tx}) async {
    _log("发送通知");
    _log("检查缓存");
    await _findInDatabase(tx: tx);
    int maxCount = AppLogic.appConfig.notificationConfig.maxNotificationCount;
    // 这里取消所有提醒的原因是，有可能先加晚点的提醒，后加早点的提醒，不取消的话就会导致早点的提醒发不出去
    // 也可以一一比对，但是太复杂，容易出错
    _log("取消所有提醒");
    await LocalNotificationHelper.cancelAllNotifications();
    // 等待发送的id
    Set<String> noticed = {};
    int count = maxCount;
    _log("设备最大通知数量限制:$maxCount，可用数量:$count");
    // 超过最大数量 或者 没有缓存 不处理
    if (count <= 0 || dateTimeCache.isEmpty) return _log("没有剩余空间，或缓存为空，不发送。发送通知完成");
    // 时间排序
    List<DateTime> dateTimeKeyList = dateTimeCache.keys.toList();
    dateTimeKeyList.sort((a, b) => a.compareTo(b));
    DateTime now = DateTime.now();
    // 时间遍历
    for (DateTime dateTime in dateTimeKeyList) {
      _log("处理通知时间为$dateTime的通知。");
      if (count <= 0) {
        _log("剩余数量为$count，结束处理");
        break;
      }
      // 获取这个时间的提醒id列表 为空跳过
      Set<String> encodeSet = dateTimeCache[dateTime] ?? {};
      if (encodeSet.isEmpty) {
        _log("通知时间为$dateTime的通知为空，处理下一个时间");
        continue;
      }
      // 早于此刻 放入历史缓存
      if (dateTime.isBefore(now)) {
        _log("通知时间$dateTime早于此刻$now，移入通知历史");
        for (String encode in encodeSet) {
          dbCache.remove(encode);
          oldDbCache.add(encode);
        }
        dateTimeCache.remove(dateTime);
        oldDateTimeCache.putIfAbsent(dateTime, () => {}).addAll(encodeSet);
        _log("通知时间$dateTime的通知移入通知历史完成，处理下一个时间");
        continue;
      }
      // 不早于此刻遍历提醒
      for (String encode in encodeSet) {
        _log("处理$encode通知");
        if (count <= 0) {
          _log("剩余数量为$count，结束处理");
          break;
        }
        // 已在提醒列表中 跳过
        if (noticed.contains(encode)) {
          _log("通知已存在于通知列表中，处理下一个通知");
          continue;
        }
        NotificationCacheNode? cacheNode = nodeCache[encode];
        // 有问题的id 跳过
        if (null == cacheNode) {
          _log("缓存中未找到$encode的通知，处理下一个通知");
          continue;
        }
        NotificationCacheNodeType type = cacheNode.type;
        // 根据不同提醒类型发送提醒
        switch (type) {
          case NotificationCacheNodeType.normal:
            _log("通知类型为$type,发送定时通知，通知时间$dateTime，当前时间${DateTime.now()}");
            await LocalNotificationHelper.scheduleNotification(
              id: cacheNode.id,
              dateTime: dateTime,
              payload: cacheNode.payload,
              title: cacheNode.title,
              body: cacheNode.body,
            );
            break;
          case NotificationCacheNodeType.repeat:
            _log("通知类型为$type,发送重复通知");
            await LocalNotificationHelper.repeatNotification(
              id: cacheNode.id,
              payload: cacheNode.payload,
              title: cacheNode.title,
              body: cacheNode.body,
              repeatInterval: cacheNode.repeatInterval!,
            );
            break;
          case NotificationCacheNodeType.scheduleRepeat:
            _log("通知类型为$type,发送指定时间重复通知");
            await LocalNotificationHelper.scheduleNotification(
              id: cacheNode.id,
              dateTime: dateTime,
              payload: cacheNode.payload,
              title: cacheNode.title,
              body: cacheNode.body,
              matchDateTimeComponents: cacheNode.matchDateTimeComponents,
            );
            break;
        }
        noticed.add(encode);
        count--;
        _log("剩余可通知数量$count");
      }
    }
    _log("通知处理完成，刷新数据库缓存数据");
    // 刷新缓存
    await flushCache(tx: tx);
    List<PendingNotificationRequest> pendingList = await LocalNotificationHelper.checkPendingNotificationRequests();
    _log("检查待发送通知队列，通知数量${pendingList.length}");
    if (pendingList.isEmpty) return _log("通知队列为空，发送通知完成");
    PendingNotificationRequest last = pendingList.last;
    int id = last.id;
    _log("通知队列不为空，最后一个通知id为$id");
    Set<String>? encodeSet = idCache[id];
    if (null == encodeSet) return _log("缓存中未找到id为$id的通知，发送通知完成");
    DateTime? dateTime;
    for (String encode in encodeSet) {
      NotificationCacheNode? cacheNode = nodeCache[encode];
      if (cacheNode == null) continue;
      DateTime nodeTime = cacheNode.dateTime;
      if (nodeTime.isBefore(DateTime.now())) continue;
      if (dateTime == null || nodeTime.isBefore(dateTime)) {
        dateTime = nodeTime;
      }
    }
    // 如果找不到下次执行的时间 1分钟后再次执行
    dateTime ??= DateTime.now().add(const Duration(minutes: 10));
    _log("更新或新增定时任务，预计定时任务时间:${dateTime.add(const Duration(microseconds: 200))}");
    _autoNotification(executeTime: dateTime.add(const Duration(microseconds: 200)));
    _log("发送通知完成");
    for (var listener in _listener.values) {
      listener(NotificationAction.notify);
    }
    return dateTime.add(const Duration(microseconds: 200));
  }

  /// 自动发送缓存的提醒
  static Future<void> _autoNotification({DateTime? executeTime}) async {
    _log("更新或创建前台定时任务");
    // 没有传时间就立即执行
    DateTime scheduledTime = executeTime ?? DateTime.now().add(const Duration(seconds: 1));
    // 定时执行器
    late ScheduledTimer timer;
    timer = ScheduledTimer.fromId(
      id: "auto_send_notification",
      onExecute: () async {
        _log("定时任务执行，执行时间${DateTime.now()}");
        // 发送通知
        DateTime? dateTime = await _notification();
        // 时间不为空，说明是notification已经设置过下次执行时间了
        if (null != dateTime) {
          _log("定时任务执行完成，下次任务执行时间$dateTime");
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
              NotificationCacheNode? cacheNode = nodeCache[encode];
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
        _log("定时任务执行完成，下次任务执行时间$next");
      },
      onMissedSchedule: () {
        _log("错过定时任务执行时间，立即执行");
        timer.execute();
      },
    );
    if (timer.scheduledTime == null) {
      _log("定时任务上次执行时间为空，尝试从数据库中加载");
      await timer.load();
    }
    DateTime? oldScheduledTime = timer.scheduledTime;
    if (oldScheduledTime == null || oldScheduledTime.isBefore(DateTime.now())) {
      await timer.schedule(scheduledTime);
      _log("定时任务上次执行时间:$oldScheduledTime,定时任务下次执行时间:$scheduledTime");
    } else {
      if (oldScheduledTime.isAfter(scheduledTime)) {
        await timer.schedule(scheduledTime);
        _log("更新定时任务时间,旧的时间$oldScheduledTime,新的时间:$scheduledTime");
      } else {
        _log("旧的时间$oldScheduledTime早于新的时间:$scheduledTime，不更新定时任务时间");
      }
    }
    _log("更新或创建前台定时任务完成");
  }

  /// 显示简单通知，立即通知，不占用缓存
  static Future<void> showNotification(NotificationArgs args, {Transaction? tx}) async {
    _log("立即通知:${{"id": args.id, "时间": DateTime.now(), "标题": args.title, "内容": args.body}}");
    await LocalNotificationHelper.showNotification(id: args.id, payload: args.payload, title: args.title, body: args.body);
    _log("立即通知完成{id:${args.id}}");
  }

  /// 延时通知
  /// 最好>200ms
  static Future<void> delayNotification(DelayNotificationArgs args, {Transaction? tx}) async {
    DateTime dateTime = DateTime.now().add(args.duration);
    _log("延时通知:${{"id": args.id, "时间": dateTime, "标题": args.title, "内容": args.body}}");
    NotificationCacheNode cacheNode = NotificationCacheNode.normal(
      id: args.id,
      dateTime: dateTime,
      payload: args.payload,
      title: args.title,
      body: args.body,
    );
    await _addNotificationToCache(cacheNode, tx: tx);
    await _notification(tx: tx);
    _log("延时通知完成{id:${args.id}}");
  }

  /// 批量延时通知
  static Future<void> batchDelayNotification(List<DelayNotificationArgs> argsList, {Transaction? tx}) async {
    _log("批量延时通知，数量${argsList.length}");
    for (DelayNotificationArgs args in argsList) {
      DateTime dateTime = DateTime.now().add(args.duration);
      _log("延时通知:${{"id": args.id, "时间": dateTime, "标题": args.title, "内容": args.body}}");
      NotificationCacheNode cacheNode = NotificationCacheNode.normal(
        id: args.id,
        dateTime: dateTime,
        payload: args.payload,
        title: args.title,
        body: args.body,
      );
      await _addNotificationToCache(cacheNode, tx: tx);
    }
    await _notification(tx: tx);
    _log("批量延时通知完成，数量${argsList.length}");
  }

  /// 重复通知
  /// 重复通知记录的时间是调用此方法的时间
  /// 重复通知如果下载覆盖数据需要重新发送通知
  static Future<void> repeatNotification(RepeatNotificationArgs args, {Transaction? tx}) async {
    DateTime dateTime = DateTime.now().add(const Duration(milliseconds: 200));
    _log("重复通知:${{"id": args.id, "发起时间": dateTime, "重复周期": args.repeatInterval, "标题": args.title, "内容": args.body}}");
    NotificationCacheNode cacheNode = NotificationCacheNode.repeat(
      id: args.id,
      repeatInterval: args.repeatInterval,
      payload: args.payload,
      title: args.title,
      body: args.body,
      dateTime: dateTime,
    );
    await _addNotificationToCache(cacheNode, tx: tx);
    await _notification(tx: tx);
    _log("重复通知完成{id:${args.id}}");
  }

  /// 批量重复通知
  static Future<void> batchRepeatNotification(List<RepeatNotificationArgs> argsList, {Transaction? tx}) async {
    _log("批量重复通知，数量${argsList.length}");
    for (RepeatNotificationArgs args in argsList) {
      DateTime dateTime = DateTime.now().add(const Duration(milliseconds: 200));
      _log("重复通知:${{"id": args.id, "发起时间": dateTime, "重复周期": args.repeatInterval, "标题": args.title, "内容": args.body}}");
      NotificationCacheNode cacheNode = NotificationCacheNode.repeat(
        id: args.id,
        repeatInterval: args.repeatInterval,
        payload: args.payload,
        title: args.title,
        body: args.body,
        dateTime: dateTime,
      );
      await _addNotificationToCache(cacheNode, tx: tx);
    }
    await _notification(tx: tx);
    _log("批量重复通知完成，数量${argsList.length}");
  }

  /// 定时通知 精确到分钟 超过当前时间忽略
  static Future<void> scheduleNotification(ScheduleNotificationArgs args, {Transaction? tx}) async {
    _log("定时通知:${{"id": args.id, "时间": args.dateTime, "标题": args.title, "内容": args.body}}");
    NotificationCacheNode cacheNode = NotificationCacheNode.normal(
      id: args.id,
      dateTime: args.dateTime,
      payload: args.payload,
      title: args.title,
      body: args.body,
    );
    await _addNotificationToCache(cacheNode, tx: tx);
    await _notification(tx: tx);
    _log("定时通知完成{id:${args.id}}");
  }

  /// 批量定时通知 精确到分钟 超过当前时间忽略
  static Future<void> batchScheduleNotification(List<ScheduleNotificationArgs> argsList, {Transaction? tx}) async {
    _log("批量定时通知，数量${argsList.length}");
    for (ScheduleNotificationArgs args in argsList) {
      _log("定时通知:${{"id": args.id, "时间": args.dateTime, "标题": args.title, "内容": args.body}}");
      NotificationCacheNode cacheNode = NotificationCacheNode.normal(
        id: args.id,
        dateTime: args.dateTime,
        payload: args.payload,
        title: args.title,
        body: args.body,
      );
      await _addNotificationToCache(cacheNode, tx: tx);
    }
    await _notification(tx: tx);
    _log("批量定时通知完成，数量${argsList.length}");
  }

  /// 指定时间重复通知
  /// 下载覆盖数据需要重新发送通知，因为记录的数据是调用此方法的时间
  static Future<void> scheduleRepeatNotification(ScheduleRepeatNotificationArgs args, {Transaction? tx}) async {
    _log("定时重复通知:${{"id": args.id, "时间": args.dateTime, "重复周期": args.matchDateTimeComponents, "标题": args.title, "内容": args.body}}");
    NotificationCacheNode cacheNode = NotificationCacheNode.scheduleRepeat(
      id: args.id,
      dateTime: args.dateTime,
      payload: args.payload,
      title: args.title,
      body: args.body,
      matchDateTimeComponents: args.matchDateTimeComponents,
    );
    await _addNotificationToCache(cacheNode, tx: tx);
    await _notification(tx: tx);
    _log("定时通知完成{id:${args.id}}");
  }

  /// 批量定时重复通知 精确到分钟 超过当前时间忽略
  static Future<void> batchScheduleRepeatNotification(List<ScheduleRepeatNotificationArgs> argsList, {Transaction? tx}) async {
    _log("批量定时重复通知，数量${argsList.length}");
    for (ScheduleRepeatNotificationArgs args in argsList) {
      _log("定时重复通知:${{"id": args.id, "时间": args.dateTime, "重复周期": args.matchDateTimeComponents, "标题": args.title, "内容": args.body}}");
      NotificationCacheNode cacheNode = NotificationCacheNode.scheduleRepeat(
        id: args.id,
        dateTime: args.dateTime,
        payload: args.payload,
        title: args.title,
        body: args.body,
        matchDateTimeComponents: args.matchDateTimeComponents,
      );
      await _addNotificationToCache(cacheNode, tx: tx);
    }
    await _notification(tx: tx);
    _log("批量定时重复通知完成，数量${argsList.length}");
  }

  /// 刷新缓存到数据库
  static Future<void> flushCache({Transaction? tx}) async {
    DatabaseHelper.kv.put(notificationCache, dbCache.toList());
    DatabaseHelper.kv.put(oldNotificationCache, oldDbCache.toList());
    await DatabaseHelper.kv.save(tx: tx);
  }

  /// 恢复指定通知
  static Future<void> recoverNotification(int id, {Transaction? tx}) async {
    _log("恢复通知");
    _log("检查缓存");
    await _findInDatabase(tx: tx);
    Set<String>? encodeSet = idCache[id];
    if (null == encodeSet || encodeSet.isEmpty) return _log("恢复通知完成");
    for (String encode in encodeSet) {
      NotificationCacheNode? cacheNode = nodeCache[encode];
      if (null == cacheNode) continue;
      if (dbCache.contains(encode) || !oldDbCache.contains(encode)) continue;
      DateTime dateTime = cacheNode.dateTime;
      if (dateTime.isBefore(DateTime.now())) continue;
      nodeCache.remove(encode);
      oldDbCache.remove(encode);
      oldDateTimeCache[dateTime]?.remove(encode);
      await _addNotificationToCache(cacheNode, tx: tx);
    }
    await _notification(tx: tx);
    for (var listener in _listener.values) {
      listener(NotificationAction.recover);
    }
    _log("恢复通知完成");
  }

  /// 取消指定通知 将通知移入历史通知
  static Future<void> cancelNotification(int id, {Transaction? tx}) async {
    _log("取消通知");
    await LocalNotificationHelper.cancelNotification(id);
    _log("检查缓存");
    await _findInDatabase(tx: tx);
    Set<String>? encodeSet = idCache[id];
    if (null == encodeSet || encodeSet.isEmpty) return _log("取消通知完成");
    for (String encode in encodeSet) {
      NotificationCacheNode? cacheNode = nodeCache[encode];
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
    _log("取消通知完成");
  }

  /// 取消所有通知 将通知移入历史通知
  static Future<void> cancelAllNotifications({Transaction? tx}) async {
    _log("取消所有通知");
    await LocalNotificationHelper.cancelAllNotifications();
    _log("检查缓存");
    await _findInDatabase(tx: tx);
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
    _log("取消所有通知完成");
  }

  /// 删除指定通知
  static Future<void> removeNotification(int id, {Transaction? tx}) async {
    _log("删除通知");
    _log("删除本地通知");
    await LocalNotificationHelper.cancelNotification(id);
    _log("检查缓存");
    await _findInDatabase(tx: tx);
    Set<String>? encodeSet = idCache[id];
    if (null == encodeSet) return _log("根据id未找到通知，删除完成");
    _log("清除缓存");
    for (String encode in encodeSet) {
      NotificationCacheNode? cacheNode = nodeCache[encode];
      if (null == cacheNode) continue;
      DateTime dateTime = cacheNode.dateTime;
      dbCache.remove(encode);
      oldDbCache.remove(encode);
      dateTimeCache[dateTime]?.remove(encode);
      oldDateTimeCache[dateTime]?.remove(encode);
      nodeCache.remove(encode);
    }
    _log("清除缓存完成，更新数据库存储");
    await flushCache(tx: tx);
    idCache.remove(id);
    for (var listener in _listener.values) {
      listener(NotificationAction.remove);
    }
    _log("更新数据库存储完成，删除通知完成");
  }

  /// 删除所有通知
  static Future<void> removeAllNotifications({Transaction? tx}) async {
    _log("删除所有通知");
    _log("删除本地所有通知");
    await LocalNotificationHelper.cancelAllNotifications();
    _log("检查缓存");
    await _findInDatabase(tx: tx);
    _log("清除缓存");
    idCache.clear();
    dbCache.clear();
    oldDbCache.clear();
    dateTimeCache.clear();
    oldDateTimeCache.clear();
    nodeCache.clear();
    _log("清除缓存完成，更新数据库存储");
    await flushCache(tx: tx);
    for (var listener in _listener.values) {
      listener(NotificationAction.remove);
    }
    _log("更新数据库存储完成，删除所有完成");
  }
}

/// 通知点击回调
/// 由于要考虑点击通知冷启动应用的情况，所以通知标识需要做成枚举，回调要静态编码
class NotificationCallback {
  NotificationCallback._();

  /// 日志
  static void _log(String msg) => LogHelper.debug("[本地通知回调]:$msg");

  /// 通知回调方法
  static void callback(String? payload) async {
    _log("回调执行，原始负载:$payload");
    NotificationPayload? notificationPayload = NotificationPayload.decode(payload);
    if (null == notificationPayload) {
      _log("负载解码为空，不执行，发送新的通知");
      NotificationHelper._notification();
      return;
    }
    NotificationType type = notificationPayload.type;
    String? realPayload = notificationPayload.payload;
    _log("回调执行");
    type.callback(realPayload);
    _log("发送新通知");
    NotificationHelper._notification();
  }
}

/// 通知的负载
@immutable
class NotificationPayload {
  /// 通知类型，用户触发回调等操作
  final NotificationType type;
  static const String _typeKey = "type";

  /// 通知实质上携带的负载
  final String? payload;
  static const String _payloadKey = "payload";

  const NotificationPayload({required this.type, this.payload});

  /// 通知负载解码
  static NotificationPayload? decode(String? notificationPayload) {
    if (null == notificationPayload || notificationPayload.isEmpty) return null;
    Map<String, dynamic> payloadMap = json.decode(notificationPayload);
    NotificationType? callbackType = NotificationTypes.get(payloadMap[_typeKey]);
    if (null == callbackType) return null;
    return NotificationPayload(type: callbackType, payload: payloadMap[_payloadKey]);
  }

  /// 通知负载编码
  String? encode() {
    return json.encode({_typeKey: type.name, _payloadKey: payload});
  }
}

/// 通知类型
class NotificationTypes {
  NotificationTypes._();

  static final Map<String, NotificationType> _map = {};

  static void put(NotificationType type) {
    _map[type.name] = type;
  }

  static NotificationType? get(String name) => _map[name];
}

/// 通知类型
abstract class NotificationType {
  String get name;

  /// 回调方法
  Future<void> callback(String? payload);
}
