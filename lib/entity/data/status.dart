import 'package:flutter/material.dart';
import 'package:hg_entity/hg_entity.dart';
import 'package:hg_orm/hg_orm.dart';

import '../entities.dart';

/// 事件状态
class Status extends EventAttribute {
  static const String modelTitle = "状态";

  late final CustomAttribute<GroupFilterValue> filter;
  static const String filterKey = "filter";

  Status() {
    name.comment = "请输入状态名称";
    content.comment = "请输入状态描述";
    filter = attributes.custom(
      name: filterKey,
      title: "匹配条件",
      comment: "日程中修改事件状态时，事件会根据此条件给出推荐状态",
    );
  }

  static List<Status> get initData {
    // 开始时间小于等于此刻
    SingleFilter startLessThanOrEqualsNow = SingleFilter.lessThanOrEquals(
      field: EventFilterField.startTiming.value,
      value: FilterDateTime(type: FilterDateTimeTypeEnum.now),
    );
    // 开始时间大于此刻
    SingleFilter startGreaterThanNow = SingleFilter.greaterThan(
      field: EventFilterField.startTiming.value,
      value: FilterDateTime(type: FilterDateTimeTypeEnum.now),
    );
    // 结束时间大于等于此刻
    SingleFilter endGreaterOrEqualsThanNow = SingleFilter.greaterThanOrEquals(
      field: EventFilterField.endTiming.value,
      value: FilterDateTime(type: FilterDateTimeTypeEnum.now),
    );

    // 结束时间小于此刻
    SingleFilter endLessThanNow = SingleFilter.lessThan(
      field: EventFilterField.endTiming.value,
      value: FilterDateTime(type: FilterDateTimeTypeEnum.now),
    );

    Status done = Status()
      ..id.value = "done"
      ..name.value = "已完成"
      ..content.value = "事件已完成，这次一定。"
      ..icon.value = IconValue.fontIcon(iconData: Icons.done, iconColor: Colors.green);
    Status undone = Status()
      ..id.value = "undone"
      ..name.value = "未完成"
      ..content.value = "事件未完成，下次一定。"
      ..icon.value = IconValue.fontIcon(iconData: Icons.close, iconColor: Colors.red);
    // 非结束状态
    SingleFilter notEnd = SingleFilter.notInList(field: EventFilterField.status.value, value: [done, undone]);
    done.filter.value = GroupFilterValue(filters: [SingleFilterValue(filter: endLessThanNow), SingleFilterValue(filter: notEnd)]);
    undone.filter.value = GroupFilterValue(filters: [SingleFilterValue(filter: endLessThanNow), SingleFilterValue(filter: notEnd)]);
    Status todo = Status()
      ..id.value = "todo"
      ..name.value = "未开始"
      ..content.value = "事件尚未开始，请坐和放宽。"
      ..icon.value = IconValue.fontIcon(iconData: Icons.checklist_outlined, iconColor: Colors.cyan)
      // 开始时间大于此刻，并且状态不是事件结束状态
      ..filter.value = GroupFilterValue(filters: [SingleFilterValue(filter: startGreaterThanNow), SingleFilterValue(filter: notEnd)]);
    Status doing = Status()
      ..id.value = "doing"
      ..name.value = "进行中"
      ..content.value = "事件正在进行中，继续加油。"
      ..icon.value = IconValue.fontIcon(iconData: Icons.timelapse_outlined, iconColor: Colors.blue)
      // 开始时间小于等于此刻，结束时间大于等于此刻，并且状态不属于结束状态
      ..filter.value = GroupFilterValue(filters: [
        SingleFilterValue(filter: startLessThanOrEqualsNow),
        SingleFilterValue(filter: endGreaterOrEqualsThanNow),
        SingleFilterValue(filter: notEnd),
      ]);
    Status untreated = Status()
      ..id.value = "untreated"
      ..name.value = "未处理"
      ..content.value = "事件未处理，处于已完成和未完成叠加的不确定状态中。"
      ..icon.value = IconValue.fontIcon(iconData: Icons.filter_none_outlined, iconColor: Colors.orange)
      // 结束时间小于此刻，并且状态不属于结束状态
      ..filter.value = GroupFilterValue(filters: [SingleFilterValue(filter: endLessThanNow), SingleFilterValue(filter: notEnd)]);
    return [todo, doing, done, undone, untreated];
  }
}

/// 于TagFilter完全一致
extension StatusFilter on Status {
  /// 转换为Filter
  GroupFilter? getFilter({Type? eventType}) {
    if (filter.isNull) return null;
    // 拷贝一份操作
    GroupFilterValue groupFilterValue = filter.value.clone();
    // 处理条件
    _handGroupFilter(groupFilterValue, eventType: eventType);
    return groupFilterValue.asFilter();
  }

  /// 处理条件组
  void _handGroupFilter(GroupFilterValue groupFilterValue, {Type? eventType}) {
    List<FilterValue> filters = groupFilterValue.filters;
    // 拷贝列表，方便对原列表添加删除
    List<FilterValue> filtersClone = [...filters];
    for (FilterValue filterValue in filtersClone) {
      if (filterValue.isNull) continue;
      // 条件组向下处理
      if (filterValue is GroupFilterValue) {
        _handGroupFilter(filterValue, eventType: eventType);
        continue;
      }
      // 单个条件处理
      if (filterValue is SingleFilterValue) {
        String field = filterValue.filter!.field;
        EventFilterField? filterField = EventFilterField.map[field];
        if (null == filterField) continue;
        filterField.handleFilter(groupFilterValue, filterValue, eventType: eventType);
      }
    }
  }
}
