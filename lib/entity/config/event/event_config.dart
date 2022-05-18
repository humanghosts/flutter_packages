import 'package:hg_entity/hg_entity.dart';
import 'package:hg_logger/entity/entities.dart';

/// 存储事件主页的事件相关设置
class EventConfig extends SimpleModel {
  /// ---- 事件列表设置

  /// 标签行
  late final ListAttribute<Tag> tagList;

  /// 列表分组字段
  late final Attribute<String?> groupField;

  /// 首要按钮
  late final ListAttribute<Status> actions;

  /// 次要按钮
  late final ListAttribute<Status> secondaryActions;

  /// ---- 事件设置 ----

  /// 事件默认状态
  late final Attribute<Status?> defaultStatus;

  /// 事件默认优先级
  late final Attribute<Priority?> defaultPriority;

  /// 标识事件结束状态
  late final ListAttribute<Status> endStatus;

  /// 旧的标识事件结束状态 由于事件结束状态变更需要重置所有事件的提醒，这里单独记一下
  late final ListAttribute<Status> oldEndStatus;

  /// 当前派生事件的最大数量
  late final Attribute<int> maxDeriveNum;

  EventConfig() {
    // 事件列表设置
    tagList = attributes.dataModelList(name: "tag_list", title: "标签列表");
    groupField = attributes.stringNullable(name: "group_field", title: "列表分组字段", comment: "设置后，事件列表将会按照指定字段分组显示");
    actions = attributes.dataModelList(name: "actions", title: "首要动作", comment: "事件右滑可选择状态");
    secondaryActions = attributes.dataModelList(name: "secondary_actions", title: "次要动作", comment: "事件左滑可选择状态");
    // 事件设置
    defaultStatus = attributes.dataModelNullable(name: "default_status", title: "默认状态");
    defaultPriority = attributes.dataModelNullable(name: "default_priority", title: "默认优先级");
    maxDeriveNum = attributes.integer(
      name: "max_derive_num",
      title: "同时存在未结束日程的最大数量",
      comment: "此设置决定某事件的某个时间设置在日程中存在的未结束事件的最大数量。\n"
          "例如十点起床，无限循环，最大数量设置为30。日程中最多会同时存在30个十点起床，结束一个或删除一个会自动递补下一个。\n"
          "减少该数量不会删除已存在的日程，但是会停止递补直到数量符合设置。\n"
          "增加该数量也不会立即增加日程，等到下次结束或删除日程的时候会自动递补缺少的数量。\n",
      dvalue: 30,
    );
    endStatus = attributes.dataModelList(
      name: "end_status",
      title: "标识事件结束的状态",
      comment: "事件通过状态区分未结束和已结束，此设置决定哪些状态为结束状态。\n"
          "处于结束状态的事件不会发送提醒。\n"
          "文本颜色显示为禁用颜色。\n",
    );
    oldEndStatus = attributes.dataModelList(name: "old_end_status", title: "旧的标识事件结束的状态");
  }

  /// 初始化值
  static EventConfig get initData {
    EventConfig config = EventConfig();
    config.tagList.value = Tag.initData;
    List<String> notEndStatusIdList = ["todo", "done", "undone"];
    List<Status> statusList = Status.initData.where((e) => notEndStatusIdList.contains(e.id.value)).toList();
    for (Status status in statusList) {
      if (status.id.value == "todo") {
        config.defaultStatus.value = status;
      }
      if (status.id.value == "done") {
        config.actions.add(status);
        config.endStatus.add(status);
      }
      if (status.id.value == "undone") {
        config.secondaryActions.add(status);
        config.endStatus.add(status);
      }
    }
    return config;
  }
}
