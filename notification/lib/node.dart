import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notification/notification.dart';

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

/// 单个通知
class NotificationNode {
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

  NotificationNode.normal({
    required this.id,
    this.payload,
    this.title,
    this.body,
    required this.dateTime,
  }) : type = NotificationCacheNodeType.normal;

  /// 重复提醒的缓存节点
  NotificationNode.repeat({
    required this.id,
    this.payload,
    this.title,
    this.body,
    required this.dateTime,
    required this.repeatInterval,
  }) : type = NotificationCacheNodeType.repeat;

  /// 指定时间重复缓存节点
  NotificationNode.scheduleRepeat({
    required this.id,
    this.payload,
    this.title,
    this.body,
    required this.dateTime,
    required this.matchDateTimeComponents,
  }) : type = NotificationCacheNodeType.scheduleRepeat;

  /// 解码
  static NotificationNode? decode(String? encode) {
    if (null == encode) return null;
    Map<String, dynamic> encodeMap = json.decode(encode);
    // id
    int? id = encodeMap[_idKey];
    if (null == id) return null;
    String? typeStr = encodeMap[_typeKey];
    // 类型
    NotificationCacheNodeType type = null == typeStr ? NotificationCacheNodeType.normal : _getNodeTypeByString(typeStr);
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
        return NotificationNode.normal(id: id, dateTime: dateTime, payload: payload, title: title, body: body);
      case NotificationCacheNodeType.repeat:
        // 重复周期
        String? repeatIntervalStr = encodeMap[_repeatIntervalKey];
        RepeatInterval? repeatInterval = repeatIntervalStr == null ? null : _getRepeatIntervalByString(repeatIntervalStr);
        return NotificationNode.repeat(id: id, payload: payload, title: title, body: body, repeatInterval: repeatInterval, dateTime: dateTime);
      case NotificationCacheNodeType.scheduleRepeat:
        // 指定时间重复周期
        String? dateTimeComponentsStr = encodeMap[_matchDateTimeComponentsKey];
        DateTimeComponents? dateTimeComponents = dateTimeComponentsStr == null ? null : _getDateTimeComponentsByString(dateTimeComponentsStr);
        return NotificationNode.scheduleRepeat(
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
  static NotificationCacheNodeType _getNodeTypeByString(String typeStr) {
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
