import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hgs_notification/notification.dart';

/// 通知方法参数
class NotificationArgs {
  /// 通知ID
  final int id;

  /// 通知负载
  final NotificationPayload? payload;

  /// 通知标题
  final String? title;

  /// 通知内容
  final String? body;

  NotificationArgs({required this.id, this.payload, this.title, this.body});
}

/// 普通通知方法参数
class ScheduleNotificationArgs extends NotificationArgs {
  /// 计划通知时间
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
  /// 重复间隔
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
  /// 延迟
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
  /// 通知时间
  final DateTime dateTime;

  /// 重复规则
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
