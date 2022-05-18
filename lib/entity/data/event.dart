import 'package:hg_entity/hg_entity.dart';

import '../entities.dart';

/// 基础事件
class Event<T extends AdvancedDataTreeModel> extends AdvancedDataTreeModel<T> {
  late final Attribute<String?> name;
  static const String nameKey = "name";

  late final Attribute<Content> content;
  static const String contentKey = "content";

  late final Attribute<Status?> status;
  static const String statusKey = "status";

  late final ListAttribute<StatusHistoryRecord> statusHistory;
  static const String statusHistoryKey = "status_history";

  late final Attribute<Priority?> priority;
  static const String priorityKey = "priority";

  late final DataModelListAttribute<Tag> tagList;
  static const String tagListKey = "tag_list";

  Event() {
    name = attributes.stringNullable(name: nameKey, title: "名称", comment: "计划做什么呢?");
    content = attributes.custom(name: contentKey, title: "内容", comment: "详细描述下吧~");
    status = attributes.dataModelNullable(name: statusKey, title: "状态");
    statusHistory = attributes.simpleModelList(name: statusHistoryKey, title: "状态历史");
    priority = attributes.dataModelNullable(name: priorityKey, title: "优先级");
    tagList = attributes.dataModelList(name: tagListKey, title: "标签");
    parent.title = "父事件";
    children.title = "子事件";
  }

  @override
  String toString() {
    return name.value ?? "未命名";
  }
}

/// 源事件，多个时间列表，可重复
class OriginEvent extends Event<OriginEvent> {
  static const String modelTitle = "事件";

  late final ListAttribute<RepeatableTiming> timingList;
  static const String timingListKey = "timing_list";

  OriginEvent() {
    timingList = attributes.simpleModelList(name: timingListKey, title: "时间");
  }

  /// 生成派生事件
  DeriveEvent derive({SingleTiming? timing}) {
    DeriveEvent derive = DeriveEvent(origin: this);
    // 属性赋值,直接拷贝即可
    derive.timing.value = timing;
    derive.name.value = name.value;
    derive.content.value = content.value.clone();
    derive.status.value = status.value?.clone() as Status?;
    if (!derive.status.isNull) {
      derive.statusHistory.add(StatusHistoryRecord(sourceType: StatusRecordSourceType.auto, status: derive.status.value, reason: "事件派生"));
    }
    derive.priority.value = priority.value?.clone() as Priority?;
    derive.tagList.addAll(tagList.value);
    // 没有时间属性的子事件跟随派生
    for (OriginEvent child in children.value) {
      // 有timingList的就不处理
      if (!child.timingList.isNull) continue;
      // 子事件派生 时间给空值
      DeriveEvent childDerive = child.derive();
      // 父子绑定
      derive.children.add(childDerive);
    }
    return derive;
  }
}

/// 日程事件，最多一个时间，不可重复
class DeriveEvent extends Event<DeriveEvent> {
  static const String modelTitle = "日程事件";

  late final Attribute<OriginEvent?> origin;
  static const String originKey = "origin";

  late final Attribute<SingleTiming?> timing;
  static const String timingKey = "timing";

  DeriveEvent({OriginEvent? origin}) {
    this.origin = attributes.dataModelNullable(name: originKey, title: "源事件", value: origin);
    timing = attributes.simpleModelNullable(name: timingKey, title: "时间");
  }

  /// 是否是源事件
  void isOrigin(OriginEvent origin) => this.origin.value?.id.value == origin.id.value;

  /// 是否是源时间
  bool isOriginTiming(RepeatableTiming originTiming) {
    if (timing.isNull) return false;
    return timing.value!.isOrigin(originTiming);
  }

  /// 通过源事件更新
  void updateByOrigin(OriginEvent origin, RepeatableTiming? originTiming) {
    // 名称
    if (name.value != origin.name.value) name.value = origin.name.value;
    // 内容
    if (content.value.toString() != origin.content.value.toString()) content.value = origin.content.value.clone();
    // 优先级
    if (priority.value?.id.value != origin.priority.value?.id.value) priority.value = origin.priority.value?.clone() as Priority?;
    // 标签
    Set<String> originTagList = origin.tagList.value.map((e) => e.id.value).toSet();
    Set<String> deriveTagList = tagList.value.map((e) => e.id.value).toSet();
    if (originTagList.join(",") != deriveTagList.join(",")) {
      tagList.clear();
      tagList.addAll(origin.tagList.value);
    }
    // 更新提醒
    if (!timing.isNull && !timing.value!.isNull && originTiming != null && !originTiming.isNull) {
      timing.value!.startNotice.value = originTiming.startNotice.value;
      timing.value!.endNotice.value = originTiming.endNotice.value;
    }
    Map<String, DeriveEvent> originIdChildMap = {};
    for (DeriveEvent child in children.value) {
      OriginEvent? origin = child.origin.value;
      if (null == origin) continue;
      originIdChildMap[origin.id.value] = child;
    }
    // 不更新，只删除和添加 更新参见[OriginEventService.derive]
    for (OriginEvent child in origin.children.value) {
      String id = child.id.value;
      // 有timingList的就不处理
      if (!child.timingList.isNull) {
        if (originIdChildMap.containsKey(id)) children.remove(originIdChildMap[id]!);
        continue;
      }
      if (originIdChildMap.containsKey(id)) continue;
      // 子事件派生 时间给空值
      DeriveEvent childDerive = child.derive();
      // 父子绑定
      children.add(childDerive);
    }
  }

  @override
  DataTreeModel<DataModel> clone({Map<String, AttributeCloneHandler>? attributeHandler, Model? newModel, bool isRoot = true}) {
    Map<String, AttributeCloneHandler> allHandler = {
      origin.name: originCloneHandler,
    };
    if (attributeHandler != null) allHandler.addAll(attributeHandler);
    return super.clone(attributeHandler: allHandler, newModel: newModel, isRoot: isRoot);
  }

  /// 源事件拷贝处理器
  void originCloneHandler(Attribute attribute, Attribute newAttribute) {
    if (attribute.isNull) return;
    OriginEvent parentModel = attribute.value as OriginEvent;
    String parentId = parentModel.id.value;
    if (DataTreeModel.cloneCache.containsKey(parentId)) {
      newAttribute.value = DataTreeModel.cloneCache[parentId];
    } else {
      newAttribute.value = parentModel.clone(isRoot: false);
    }
  }
}
