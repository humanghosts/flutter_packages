import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scheduled_timer/scheduled_timer.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

enum NotificationCacheNodeType {
  normal,
  repeat,
  scheduleRepeat,
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

/// 通知助手
class NotificationHelper {
  NotificationHelper._();

  /// 日志
  static _log(String msg) => debugPrint("[通知助手]:$msg");

  /// 通知id和通知负载的映射
  static final Map<int, NotificationCacheNode> idCache = {};

  /// 数据库的缓存
  static final Set<String> dbCache = {};

  /// 过时的提醒缓存
  static final Set<String> oldDbCache = {};

  /// 通知时间和通知id的映射，由于同一时间可能多个提醒，value设置为Set类型
  static final Map<DateTime, Set<int>> dateTimeIdCache = {};

  /// 过时的提醒缓存
  static final Map<DateTime, Set<int>> oldDateTimeIdCache = {};

  /// 初始化
  static Future<bool?> init() async {
    _log("初始化通知助手");
    _log("初始化本地通知");
    await LocalNotificationHelper.init();
    _log("注册应用启动回调，检测是否通过通知启动应用");
    MainLogic.instance.registerReadyCallback("notification", () {
      if (LocalNotificationHelper.notificationAppLaunchDetails?.didNotificationLaunchApp == true) {
        String? payload = LocalNotificationHelper.notificationAppLaunchDetails?.payload;
        _log("通过通知启动应用，使用通知负载触发回调，通知负载$payload");
        LocalNotificationHelper.onSelectNotification(payload);
      } else {
        _log("非通知启动应用");
      }
    });
    _log("通知助手初始化完成");
    return true;
  }

  /// 添加缓存节点
  static Future<void> _addCacheNode(NotificationCacheNode cacheNode) async {
    _log("添加通知到通知缓存，通知数据${cacheNode.encode()}");
    // 缓存节点
    int id = cacheNode.id;
    DateTime dateTime = cacheNode.dateTime;
    _log("检查缓存");
    await findDbCache();
    if (idCache.containsKey(id)) return _log("通知{id:$id}已存在，添加完成");
    _log("添加到idCache");
    // id缓存
    idCache[id] = cacheNode;
    // 此刻
    DateTime now = DateTime.now();
    if (dateTime.isBefore(now)) {
      _log("通知{id:$id}的通知时间{$dateTime}早于此刻{$now}，不通知，放入通知历史");
      // 更新缓存
      oldDbCache.add(cacheNode.encode());
      // 时间缓存
      oldDateTimeIdCache.putIfAbsent(dateTime, () => {}).add(id);
      await SharedPreferencesHelper.prefs.setStringList(SharedPreferencesKeys.oldNotificationCache, oldDbCache.toList());
      _log("通知{id:$id}放入通知历史完成");
    } else {
      _log("通知{id:$id}的通知时间{$dateTime}晚于此刻{$now}，放入通知缓存");
      // 更新缓存
      dbCache.add(cacheNode.encode());
      // 时间缓存
      dateTimeIdCache.putIfAbsent(dateTime, () => {}).add(id);
      await SharedPreferencesHelper.prefs.setStringList(SharedPreferencesKeys.notificationCache, dbCache.toList());
      _log("通知{id:$id}放入通知缓存完成");
    }
  }

  /// 查询数据库数据
  static Future<void> findDbCache() async {
    _log("检查缓存是否存在");
    if (oldDbCache.isEmpty) {
      _log("通知历史内存缓存不存在，查询数据库并处理数据到内存缓存");
      oldDbCache.addAll(SharedPreferencesHelper.prefs.getStringList(SharedPreferencesKeys.oldNotificationCache) ?? []);
      for (String oneDbCache in oldDbCache) {
        NotificationCacheNode? oneDbCacheNode = NotificationCacheNode.decode(oneDbCache);
        if (null == oneDbCacheNode) {
          _log("通知$oneDbCache解码失败，跳过");
          continue;
        }
        int oneDbId = oneDbCacheNode.id;
        DateTime oneDbDateTime = oneDbCacheNode.dateTime;
        idCache[oneDbId] = oneDbCacheNode;
        oldDateTimeIdCache.putIfAbsent(oneDbDateTime, () => {}).add(oneDbId);
      }
      _log("通知历史处理完成");
    }
    if (dbCache.isEmpty) {
      _log("通知内存缓存不存在，查询数据库并处理数据到内存缓存");
      // 此刻
      DateTime now = DateTime.now();
      // 存储的数据
      List<String> cloneDbCache = SharedPreferencesHelper.prefs.getStringList(SharedPreferencesKeys.notificationCache) ?? [];
      for (int i = 0; i < cloneDbCache.length; i++) {
        String oneDbCache = cloneDbCache[i];
        NotificationCacheNode? oneDbCacheNode = NotificationCacheNode.decode(oneDbCache);
        if (null == oneDbCacheNode) {
          _log("通知$oneDbCache解码失败，跳过");
          continue;
        }
        int oneDbId = oneDbCacheNode.id;
        DateTime oneDbDateTime = oneDbCacheNode.dateTime;
        idCache[oneDbId] = oneDbCacheNode;
        if (oneDbDateTime.isBefore(now)) {
          _log("通知{id:$oneDbId}的时间$oneDbDateTime早于此刻$now，转入通知历史。通知内容$oneDbCache");
          // 过时的提醒加入过时的缓存
          oldDateTimeIdCache.putIfAbsent(oneDbDateTime, () => {}).add(oneDbId);
          oldDbCache.add(oneDbCache);
        } else {
          dateTimeIdCache.putIfAbsent(oneDbDateTime, () => {}).add(oneDbId);
          dbCache.add(oneDbCache);
        }
      }
      // 刷新缓存
      await SharedPreferencesHelper.prefs.setStringList(SharedPreferencesKeys.notificationCache, dbCache.toList());
      await SharedPreferencesHelper.prefs.setStringList(SharedPreferencesKeys.oldNotificationCache, oldDbCache.toList());
      _log("通知缓存处理完成");
    }
    _log("检查缓存是否存在完成");
  }

  /// 检查并发送通知
  static Future<DateTime?> notification() async {
    _log("发送通知");
    _log("检查缓存");
    await findDbCache();
    int maxCount = AppConfig.notificationConfig.maxNotificationCount;
    // 这里取消所有提醒的原因是，有可能先加晚点的提醒，后加早点的提醒，不取消的话就会导致早点的提醒发不出去
    // 也可以一一比对，但是太复杂，容易出错
    _log("取消所有提醒");
    await LocalNotificationHelper.cancelAllNotifications();
    // 等待发送的id
    Set<int> noticed = {};
    int count = maxCount;
    _log("设备最大通知数量限制:$maxCount，可用数量:$count");
    // 超过最大数量 或者 没有缓存 不处理
    if (count <= 0 || dateTimeIdCache.isEmpty) return _log("没有剩余空间，或缓存为空，不发送。发送通知完成");
    // 时间排序
    List<DateTime> dateTimeKeyList = dateTimeIdCache.keys.toList();
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
      Set<int> idSet = dateTimeIdCache[dateTime] ?? {};
      if (idSet.isEmpty) {
        _log("通知时间为$dateTime的通知为空，处理下一个时间");
        continue;
      }
      // 早于此刻 放入历史缓存
      if (dateTime.isBefore(now)) {
        _log("通知时间$dateTime早于此刻$now，移入通知历史");
        for (int id in idSet) {
          NotificationCacheNode? cacheNode = idCache[id];
          if (null == cacheNode) continue;
          String cacheNodeStr = cacheNode.encode();
          dbCache.remove(cacheNodeStr);
          oldDbCache.add(cacheNodeStr);
        }
        dateTimeIdCache.remove(dateTime);
        oldDateTimeIdCache.putIfAbsent(dateTime, () => {}).addAll(idSet);
        _log("通知时间$dateTime的通知$idSet移入通知历史移入通知历史完成，处理下一个时间");
        continue;
      }
      // 不早于此刻遍历提醒
      for (int id in idSet) {
        _log("处理id为$id通知");
        if (count <= 0) {
          _log("剩余数量为$count，结束处理{id:$id}");
          break;
        }
        // 已在提醒列表中 跳过
        if (noticed.contains(id)) {
          _log("通知{id:$id}已存在于通知列表中，处理下一个通知");
          continue;
        }
        NotificationCacheNode? cacheNode = idCache[id];
        // 有问题的id 跳过
        if (null == cacheNode) {
          _log("缓存中未找到id为$id的通知，处理下一个通知");
          continue;
        }
        NotificationCacheNodeType type = cacheNode.type;
        // 根据不同提醒类型发送提醒
        switch (type) {
          case NotificationCacheNodeType.normal:
            _log("通知类型为$type,发送定时通知，通知时间$dateTime，当前时间${DateTime.now()}");
            LocalNotificationHelper.showNotification(id: id);
            await LocalNotificationHelper.scheduleNotification(
              id: id,
              dateTime: dateTime,
              payload: cacheNode.payload,
              title: cacheNode.title,
              body: cacheNode.body,
            );
            break;
          case NotificationCacheNodeType.repeat:
            _log("通知类型为$type,发送重复通知");
            await LocalNotificationHelper.repeatNotification(
              id: id,
              payload: cacheNode.payload,
              title: cacheNode.title,
              body: cacheNode.body,
              repeatInterval: cacheNode.repeatInterval!,
            );
            break;
          case NotificationCacheNodeType.scheduleRepeat:
            _log("通知类型为$type,发送指定时间重复通知");
            await LocalNotificationHelper.scheduleNotification(
              id: id,
              dateTime: dateTime,
              payload: cacheNode.payload,
              title: cacheNode.title,
              body: cacheNode.body,
              matchDateTimeComponents: cacheNode.matchDateTimeComponents,
            );
            break;
        }
        noticed.add(id);
        count--;
        _log("剩余可通知数量$count");
      }
    }
    _log("通知处理完成，刷新数据库缓存数据");
    // 刷新缓存
    await SharedPreferencesHelper.prefs.setStringList(SharedPreferencesKeys.notificationCache, dbCache.toList());
    await SharedPreferencesHelper.prefs.setStringList(SharedPreferencesKeys.oldNotificationCache, oldDbCache.toList());
    List<PendingNotificationRequest> pendingList = await LocalNotificationHelper.checkPendingNotificationRequests();
    _log("检查待发送通知队列，通知数量${pendingList.length}");
    if (pendingList.isEmpty) return _log("通知队列为空，发送通知完成");
    PendingNotificationRequest last = pendingList.last;
    int id = last.id;
    _log("通知队列不为空，最后一个通知id为$id");
    NotificationCacheNode? cacheNode = idCache[id];
    if (null == cacheNode) return _log("缓存中未找到id为$id的通知，发送通知完成");
    _log("通知内容${cacheNode.encode()}");
    _log("更新或新增定时任务，预计定时任务时间:${cacheNode.dateTime.add(const Duration(microseconds: 200))}");
    autoNotification(executeTime: cacheNode.dateTime.add(const Duration(microseconds: 200)));
    _log("发送通知完成");
    return cacheNode.dateTime.add(const Duration(microseconds: 200));
  }

  /// 自动发送缓存的提醒
  static Future<void> autoNotification({DateTime? executeTime}) async {
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
        DateTime? dateTime = await notification();
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
          NotificationCacheNode? cacheNode = idCache[id];
          if (null == cacheNode) {
            next = DateTime.now().add(const Duration(hours: 1));
          } else {
            next = cacheNode.dateTime;
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

  static Future<void> checkAutoNotification() async {
    _log("启动检查定时任务");
    // 定时执行器
    late ScheduledTimer timer;
    timer = ScheduledTimer(
      id: "auto_send_notification",
      onExecute: () async {
        _log("定时任务执行，执行时间${DateTime.now()}");
        // 发送通知
        DateTime? dateTime = await notification();
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
          NotificationCacheNode? cacheNode = idCache[id];
          if (null == cacheNode) {
            next = DateTime.now().add(const Duration(hours: 1));
          } else {
            next = cacheNode.dateTime;
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

  /// 显示简单通知，立即通知，不占用缓存
  static Future<void> showNotification(NotificationArgs args) async {
    _log("立即通知:${{"id": args.id, "时间": DateTime.now(), "标题": args.title, "内容": args.body}}");
    await LocalNotificationHelper.showNotification(id: args.id, payload: args.payload, title: args.title, body: args.body);
    _log("立即通知完成{id:${args.id}}");
  }

  /// 延时通知
  /// 最好>200ms
  static Future<void> delayNotification(DelayNotificationArgs args) async {
    DateTime dateTime = DateTime.now().add(args.duration);
    _log("延时通知:${{"id": args.id, "时间": dateTime, "标题": args.title, "内容": args.body}}");
    NotificationCacheNode cacheNode = NotificationCacheNode.normal(
      id: args.id,
      dateTime: dateTime,
      payload: args.payload,
      title: args.title,
      body: args.body,
    );
    await _addCacheNode(cacheNode);
    await notification();
    _log("延时通知完成{id:${args.id}}");
  }

  /// 批量延时通知
  static Future<void> batchDelayNotification(List<DelayNotificationArgs> argsList) async {
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
      await _addCacheNode(cacheNode);
    }
    await notification();
    _log("批量延时通知完成，数量${argsList.length}");
  }

  /// 重复通知
  /// 重复通知记录的时间是调用此方法的时间
  /// 重复通知如果下载覆盖数据需要重新发送通知
  static Future<void> repeatNotification(RepeatNotificationArgs args) async {
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
    await _addCacheNode(cacheNode);
    await notification();
    _log("重复通知完成{id:${args.id}}");
  }

  /// 批量重复通知
  static Future<void> batchRepeatNotification(List<RepeatNotificationArgs> argsList) async {
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
      await _addCacheNode(cacheNode);
    }
    await notification();
    _log("批量重复通知完成，数量${argsList.length}");
  }

  /// 定时通知 精确到分钟 超过当前时间忽略
  static Future<void> scheduleNotification(ScheduleNotificationArgs args) async {
    _log("定时通知:${{"id": args.id, "时间": args.dateTime, "标题": args.title, "内容": args.body}}");
    NotificationCacheNode cacheNode = NotificationCacheNode.normal(
      id: args.id,
      dateTime: args.dateTime,
      payload: args.payload,
      title: args.title,
      body: args.body,
    );
    await _addCacheNode(cacheNode);
    await notification();
    _log("定时通知完成{id:${args.id}}");
  }

  /// 批量定时通知 精确到分钟 超过当前时间忽略
  static Future<void> batchScheduleNotification(List<ScheduleNotificationArgs> argsList) async {
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
      await _addCacheNode(cacheNode);
    }
    await notification();
    _log("批量定时通知完成，数量${argsList.length}");
  }

  /// 指定时间重复通知
  /// 下载覆盖数据需要重新发送通知，因为记录的数据是调用此方法的时间
  static Future<void> scheduleRepeatNotification(ScheduleRepeatNotificationArgs args) async {
    _log("定时重复通知:${{"id": args.id, "时间": args.dateTime, "重复周期": args.matchDateTimeComponents, "标题": args.title, "内容": args.body}}");
    NotificationCacheNode cacheNode = NotificationCacheNode.scheduleRepeat(
      id: args.id,
      dateTime: args.dateTime,
      payload: args.payload,
      title: args.title,
      body: args.body,
      matchDateTimeComponents: args.matchDateTimeComponents,
    );
    await _addCacheNode(cacheNode);
    await notification();
    _log("定时通知完成{id:${args.id}}");
  }

  /// 批量定时重复通知 精确到分钟 超过当前时间忽略
  static Future<void> batchScheduleRepeatNotification(List<ScheduleRepeatNotificationArgs> argsList) async {
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
      await _addCacheNode(cacheNode);
    }
    await notification();
    _log("批量定时重复通知完成，数量${argsList.length}");
  }

  /// 取消指定通知 将通知移入历史通知
  static Future<void> cancelNotification(int id) async {
    _log("取消通知{id:$id}");
    await LocalNotificationHelper.cancelNotification(id);
    NotificationCacheNode? cacheNode = idCache[id];
    if (null == cacheNode) return _log("取消通知{id:$id}完成");
    String cacheNodeStr = cacheNode.encode();
    DateTime dateTime = cacheNode.dateTime;
    dbCache.remove(cacheNodeStr);
    dateTimeIdCache.putIfAbsent(dateTime, () => {}).remove(id);
    if (oldDbCache.contains(cacheNodeStr)) return _log("取消通知{id:$id}完成");
    oldDbCache.add(cacheNodeStr);
    oldDateTimeIdCache.putIfAbsent(dateTime, () => {}).add(id);
    _log("取消通知{id:$id}完成");
  }

  /// 取消所有通知 将通知移入历史通知
  static Future<void> cancelAllNotifications() async {
    _log("取消所有通知");
    await LocalNotificationHelper.cancelAllNotifications();
    oldDbCache.addAll(dbCache);
    dbCache.clear();
    dateTimeIdCache.forEach((key, value) {
      oldDateTimeIdCache.putIfAbsent(key, () => {}).addAll(value);
    });
    dateTimeIdCache.clear();
    _log("取消所有通知完成");
  }

  /// 删除指定通知
  static Future<void> removeNotification(int id) async {
    _log("删除通知{id:$id}");
    _log("删除本地通知{id:$id}");
    await LocalNotificationHelper.cancelNotification(id);
    _log("检查缓存");
    await findDbCache();
    NotificationCacheNode? cacheNode = idCache[id];
    if (null == cacheNode) return _log("根据id未找到通知，删除完成");
    _log("清除缓存");
    idCache.remove(id);
    String encode = cacheNode.encode();
    dbCache.remove(encode);
    oldDbCache.remove(encode);
    DateTime dateTime = cacheNode.dateTime;
    dateTimeIdCache[dateTime]?.remove(id);
    oldDateTimeIdCache[dateTime]?.remove(id);
    _log("清除缓存完成，更新数据库存储");
    await SharedPreferencesHelper.prefs.setStringList(SharedPreferencesKeys.notificationCache, dbCache.toList());
    await SharedPreferencesHelper.prefs.setStringList(SharedPreferencesKeys.oldNotificationCache, oldDbCache.toList());
    _log("更新数据库存储完成，删除通知{id:$id}完成");
  }

  /// 删除所有通知
  static Future<void> removeAllNotifications() async {
    _log("删除所有通知");
    _log("删除本地所有通知");
    await LocalNotificationHelper.cancelAllNotifications();
    _log("检查缓存");
    await findDbCache();
    _log("清除缓存");
    idCache.clear();
    dbCache.clear();
    oldDbCache.clear();
    dateTimeIdCache.clear();
    oldDateTimeIdCache.clear();
    _log("清除缓存完成，更新数据库存储");
    await SharedPreferencesHelper.prefs.setStringList(SharedPreferencesKeys.notificationCache, dbCache.toList());
    await SharedPreferencesHelper.prefs.setStringList(SharedPreferencesKeys.oldNotificationCache, oldDbCache.toList());
    _log("更新数据库存储完成，删除所有完成");
  }
}

/// 本地通知发送
class LocalNotificationHelper {
  LocalNotificationHelper._();

  /// 通知插件
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// 通知启动应用
  static NotificationAppLaunchDetails? notificationAppLaunchDetails;

  /// 初始化通知组件
  static Future<bool?> init() async {
    // 时区初始化
    if (!kIsWeb && !Platform.isLinux) {
      tz.initializeTimeZones();
      final String? timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(timeZoneName!));
    }

    // 是否通过通知启动应用 来判断应该进入哪个页面
    notificationAppLaunchDetails = !kIsWeb && Platform.isLinux ? null : await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    //  app_icon是应用图标文件
    AndroidInitializationSettings android = const AndroidInitializationSettings('app_icon');
    // ios配置
    IOSInitializationSettings ios = IOSInitializationSettings(
      // ios10 之前的系统点击通知回调的方法
      onDidReceiveLocalNotification: ((id, title, body, payload) => onSelectNotification(payload)),
    );
    // macOS配置
    MacOSInitializationSettings macOS = const MacOSInitializationSettings();
    // 插件配置
    InitializationSettings settings = InitializationSettings(android: android, iOS: ios, macOS: macOS);
    bool? isInit = await flutterLocalNotificationsPlugin.initialize(settings, onSelectNotification: onSelectNotification);
    return isInit;
  }

  /// 通知点击回调
  static void onSelectNotification(String? payload) => NotificationCallback.callback(payload);

  /// 显示简单通知
  static Future<void> showNotification({
    required int id,
    NotificationPayload? payload,
    String? title,
    String? body,
    NotificationDetails? details,
  }) async {
    bool hasPermission = await checkNotificationPermission();
    if (!hasPermission) {
      bool isOpen = Get.isSnackbarOpen;
      if (!isOpen) RouteHelper.inAppNotification(title: "没有通知权限,添加提醒失败", message: "如果已设置权限，请重新保存");
      return;
    }
    // 发送通知
    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      details ?? buildNotificationDetail(),
      payload: payload?.encode(),
    );
  }

  /// 延时通知
  static Future<void> delayNotification({
    required int id,
    NotificationPayload? payload,
    required Duration duration,
    String? title,
    String? body,
    NotificationDetails? details,
  }) async {
    bool hasPermission = await checkNotificationPermission();
    if (!hasPermission) {
      bool isOpen = Get.isSnackbarOpen;
      if (!isOpen) RouteHelper.inAppNotification(title: "没有通知权限,添加提醒失败", message: "如果已设置权限，请重新保存");
      return;
    }
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      // 请注意，要在本机级别（即 Android/iOS）获得适当的时间表示，
      // 插件需要以 yyyy-mm-dd hh:mm:ss 格式通过平台通道传递时间。因此,精度最好到秒。
      tz.TZDateTime.now(tz.local).add(duration),
      details ?? buildNotificationDetail(),
      // androidAllowWhileIdle参数确定即使设备处于低功耗空闲模式时，是否仍应在准确时间显示通知。
      androidAllowWhileIdle: true,
      // uiLocalNotificationDateInterpretation适用于 10 之前的 iOS 版本，因为 API 对时区的支持有限。
      // 使用此参数，它用于确定是否应将预定日期解释为绝对时间或挂钟时间。
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      payload: payload?.encode(),
    );
  }

  ///  重复通知
  static Future<void> repeatNotification({
    required int id,
    NotificationPayload? payload,
    required RepeatInterval repeatInterval,
    String? title,
    String? body,
    NotificationDetails? details,
  }) async {
    bool hasPermission = await checkNotificationPermission();
    if (!hasPermission) {
      bool isOpen = Get.isSnackbarOpen;
      if (!isOpen) RouteHelper.inAppNotification(title: "没有通知权限,添加提醒失败", message: "如果已设置权限，请重新保存");
      return;
    }
    await flutterLocalNotificationsPlugin.periodicallyShow(
      id,
      title,
      body,
      repeatInterval,
      details ?? buildNotificationDetail(),
      androidAllowWhileIdle: true,
      payload: payload?.encode(),
    );
  }

  /// 定时通知 精确到分钟 超过当前时间忽略
  /// [matchDateTimeComponents]是重复标识
  static Future<bool> scheduleNotification({
    required int id,
    NotificationPayload? payload,
    required DateTime dateTime,
    String? title,
    String? body,
    NotificationDetails? details,
    DateTimeComponents? matchDateTimeComponents,
  }) async {
    tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(tz.local, dateTime.year, dateTime.month, dateTime.day, dateTime.hour, dateTime.minute);
    if (now.isAfter(scheduledDate)) return false;
    bool hasPermission = await checkNotificationPermission();
    if (!hasPermission) {
      bool isOpen = Get.isSnackbarOpen;
      if (!isOpen) RouteHelper.inAppNotification(title: "没有通知权限,添加提醒失败", message: "如果已设置权限，请重新保存");
      return false;
    }
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      details ?? buildNotificationDetail(),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      payload: payload?.encode(),
      matchDateTimeComponents: matchDateTimeComponents,
    );
    return true;
  }

  /// 检查待发送通知列表
  static Future<List<PendingNotificationRequest>> checkPendingNotificationRequests() async {
    return await flutterLocalNotificationsPlugin.pendingNotificationRequests();
  }

  /// 取消指定通知
  static Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  /// 取消所有通知
  static Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  /// 构建通知配置
  static NotificationDetails buildNotificationDetail({
    AndroidNotificationDetails? android,
    IOSNotificationDetails? ios,
    MacOSNotificationDetails? macOS,
    LinuxNotificationDetails? linux,
  }) {
    //  安卓的通知设置
    AndroidNotificationDetails? androidDetails;
    // IOS的通知设置 可以修改音效等 暂时所有通知都用1
    IOSNotificationDetails iosDetails = ios ?? const IOSNotificationDetails(threadIdentifier: "1");
    // Mac的通知设置
    MacOSNotificationDetails macOSDetails = macOS ?? const MacOSNotificationDetails();
    LinuxNotificationDetails linuxDetails = linux ?? const LinuxNotificationDetails();
    return NotificationDetails(android: android ?? androidDetails, iOS: iosDetails, macOS: macOSDetails, linux: linuxDetails);
  }

  /// 检查是否有通知权限
  static Future<bool> checkNotificationPermission() async {
    Permission notification = Permission.notification;
    PermissionStatus status = await notification.status;
    // 权限拒绝 一般是第一次
    if (status == PermissionStatus.denied) {
      return requestNotificationPermission();
    }
    // 权限永久拒绝 设置里面没开
    else if (status == PermissionStatus.permanentlyDenied) {
      //  询问用户是否打开设置
      bool? isOpen = await showCupertinoDialog<bool>(
        context: Get.context!,
        builder: (context) {
          return CupertinoAlertDialog(
            title: const Text("没有通知权限"),
            content: const Text("是否打开系统设置"),
            actions: <Widget>[
              CupertinoDialogAction(child: const Text("打开"), onPressed: () => RouteHelper.back(result: true)),
              CupertinoDialogAction(child: const Text("取消"), onPressed: () => RouteHelper.back(result: false)),
            ],
          );
        },
      );
      if (isOpen == true) {
        isOpen = await openAppSettings();
        if (isOpen == false) {
          RouteHelper.toast(msg: "打开系统设置失败,请手动打开");
        }
      }
      return false;
    } else {
      return true;
    }
  }

  /// 请求通知权限
  static Future<bool> requestNotificationPermission() async {
    Permission notification = Permission.notification;
    notification.shouldShowRequestRationale;
    PermissionStatus status = await notification.request();
    switch (status) {
      case PermissionStatus.denied:
        return false;
      case PermissionStatus.granted:
        return true;
      case PermissionStatus.restricted:
        return true;
      case PermissionStatus.limited:
        return true;
      case PermissionStatus.permanentlyDenied:
        return false;
    }
  }
}
