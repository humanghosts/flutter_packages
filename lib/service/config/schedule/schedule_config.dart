import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hg_logger/ability/export.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/service/services.dart';

/// 时间设置服务
class ScheduleConfigService extends SimpleModelService<ScheduleConfig> {
  ScheduleConfigService._();

  static ScheduleConfigService? _instance;

  static ScheduleConfigService get instance => _instance ??= ScheduleConfigService._();

  /// 日志
  static _log(String msg) => LogHelper.debug("[日程配置服务]:$msg");

  static const String dayStartNoticeKey = "day_start_notice";
  static const String dayEndNoticeKey = "day_end_notice";

  /// 发送提醒
  Future<void> sendNotice(ScheduleConfig config) async {
    await sendDayStartNotice(config);
    await sendDayEndNotice(config);
  }

  ///  发送每日开始提醒
  Future<void> sendDayStartNotice(ScheduleConfig config) async {
    await _cancelNotice(dayStartNoticeKey);
    if (!config.isSendDayStartNotice.value) return;
    await _sendNotice(
      key: dayStartNoticeKey,
      title: "一日之计",
      body: "查看今天的事件",
      noticeTime: config.sendDayStartNoticeTime.value,
      callbackType: NotificationType.dayStartNotice,
    );
  }

  ///  发送每日结束提醒
  Future<void> sendDayEndNotice(ScheduleConfig config) async {
    await _cancelNotice(dayEndNoticeKey);
    if (!config.isSendDayEndNotice.value) return;
    await _sendNotice(
      key: dayEndNoticeKey,
      title: "今日总结",
      body: "回顾今天的事件",
      noticeTime: config.sendDayEndNoticeTime.value,
      callbackType: NotificationType.dayEndNotice,
    );
  }

  /// 发送提醒
  Future<void> _sendNotice({
    required String key,
    required String title,
    required String body,
    required DateTime noticeTime,
    required NotificationType callbackType,
    String? payload,
  }) async {
    // 发送定时通知
    await NotificationHelper.scheduleRepeatNotification(ScheduleRepeatNotificationArgs(
      id: key.hashCode,
      title: title,
      body: body,
      dateTime: noticeTime,
      payload: NotificationPayload(type: callbackType, payload: payload),
      matchDateTimeComponents: DateTimeComponents.time,
    ));
  }

  /// 取消发送提醒
  Future<void> _cancelNotice(String key) async {
    await NotificationHelper.removeNotification(key.hashCode);
    _log("取消通知成功，通知key$key");
  }
}
