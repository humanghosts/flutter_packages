import 'package:get/get.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/main.dart';
import 'package:hg_logger/service/services.dart';
import 'package:hg_logger/view/export.dart';
import 'package:hg_logger/view/page/event/list/origin_list.dart';
import 'package:hg_orm/hg_orm.dart';

/// 通知类型，枚举类
class NotificationType {
  /// 名称
  final String name;

  /// 回调方法
  final Function(String? payload) callback;

  NotificationType._(this.name, this.callback);

  /// 事件通知回调名称
  static const String _eventName = "event";

  /// 每日开始提醒 回调
  static const String _dayStartNoticeName = "day_start_notice";

  /// 每日结束提醒 回调
  static const String _dayEndNoticeName = "day_end_notice";

  /// 事件通知的回调处理
  static NotificationType event = NotificationType._(_eventName, (payload) async {
    if (null == payload || payload.isEmpty) return;
    await showEventQuickActionById(payload);
    await _refreshEventPage();
  });

  /// 每日开始通知的回调处理
  static NotificationType dayStartNotice = NotificationType._(_dayStartNoticeName, (payload) async {
    // 跳转到今日页面
    MainLogic.instance.setActivePage(HomePages.schedule.value);
  });

  /// 每日结束通知的回调处理
  static NotificationType dayEndNotice = NotificationType._(_dayEndNoticeName, (payload) async {
    DeriveEventService deriveEventService = DeriveEventService.instance;
    // 当前时间
    FilterDateTime today = FilterDateTime(type: FilterDateTimeTypeEnum.custom, customDate: DateTime.now());
    // 用tag做过滤和排序
    Tag filterTag = Tag()
      ..sort.add(SortValue(sort: Sort(field: EventFilterField.startTiming.value)))
      ..filter.value = GroupFilterValue(
        filters: [
          // 1. 开始时间小于等于今天
          SingleFilterValue(filter: SingleFilter.lessThanOrEquals(field: EventFilterField.startTiming.value, value: today)),
          SingleFilterValue(filter: SingleFilter.notNull(field: EventFilterField.startTiming.value)),
          // 2. 结束事件大于等于今天或者为空
          GroupFilterValue(
            op: GroupFilterOp.or,
            filters: [
              SingleFilterValue(filter: SingleFilter.isNull(field: EventFilterField.endTiming.value)),
              SingleFilterValue(filter: SingleFilter.greaterThanOrEquals(field: EventFilterField.endTiming.value, value: today)),
            ],
          ),
        ],
      );
    // 查询今日事件
    List<DeriveEvent> eventList = await deriveEventService.findTreeByTag(filterTag);
    await showEventAutoAction(eventList);
    await _refreshEventPage();
  });

  /// 刷新一下页面数据
  static _refreshEventPage() async {
    bool isRegister = Get.isRegistered<OriginEventListLogic>(tag: HomePages.event.value);
    if (isRegister) {
      OriginEventListLogic logic = Get.put(OriginEventListLogic(), tag: HomePages.event.value);
      await logic.find();
    }
    isRegister = Get.isRegistered<ScheduleHomeLogic>(tag: HomePages.schedule.value);
    if (isRegister) {
      ScheduleHomeLogic logic = Get.put<ScheduleHomeLogic>(ScheduleHomeLogic(), tag: HomePages.schedule.value);
      await logic.findCurrentEventList();
    }
  }

  /// 获取回调类型
  static NotificationType? fromMap(String? name) => map[name];

  /// 回调类型集合
  static Map<String, NotificationType> map = {
    _eventName: event,
    _dayStartNoticeName: dayStartNotice,
    _dayEndNoticeName: dayEndNotice,
  };
}
