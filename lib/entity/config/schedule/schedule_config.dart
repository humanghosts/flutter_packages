import 'package:hg_entity/hg_entity.dart';
import 'package:hg_orm/hg_orm.dart';

/// 存储事件主页的事件相关设置
class ScheduleConfig extends SimpleModel {
  /// 应用角标条件
  late final CustomAttribute<GroupFilterValue> appBadgesFilter;

  /// 列表显示条件
  late final CustomAttribute<GroupFilterValue> listFilter;

  /// ---- 提醒设置 ----

  /// 是否发送每日开始提醒
  late final Attribute<bool> isSendDayStartNotice;

  /// 提醒时间
  late final Attribute<DateTime> sendDayStartNoticeTime;

  /// 是否发送每日结束提醒
  late final Attribute<bool> isSendDayEndNotice;

  /// 提醒时间
  late final Attribute<DateTime> sendDayEndNoticeTime;

  ScheduleConfig() {
    appBadgesFilter = attributes.custom(name: "app_badges_filter", title: "应用角标条件", dvalue: GroupFilterValue());
    listFilter = attributes.custom(name: "list_filter", title: "日程列表条件", dvalue: GroupFilterValue());
    // 提醒设置
    isSendDayStartNotice = attributes.boolean(name: "is_send_day_start_notice", title: "是否发送每日开始提醒", dvalue: false);
    sendDayStartNoticeTime = attributes.datetime(name: "send_day_start_notice_time", title: "提醒时间", dvalue: DateTime(0, 0, 0, 9));
    isSendDayEndNotice = attributes.boolean(name: "is_send_day_end_notice", title: "是否发送每日结束提醒", dvalue: false);
    sendDayEndNoticeTime = attributes.datetime(name: "send_day_end_notice_time", title: "提醒时间", dvalue: DateTime(0, 0, 0, 22));
  }

  /// 初始化值
  static ScheduleConfig get initData {
    ScheduleConfig config = ScheduleConfig();
    return config;
  }
}
