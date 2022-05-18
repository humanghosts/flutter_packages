import 'package:flutter/material.dart';
import 'package:hg_entity/hg_entity.dart';
import 'package:hg_orm/hg_orm.dart';

import '../entities.dart';

/// 标签实体
class Tag extends EventAttribute {
  /// 实体名称
  static const String modelTitle = "标签";

  /// 标签的过滤条件
  late final CustomAttribute<GroupFilterValue> filter;
  static const String filterKey = "filter";

  /// 标签的排序条件
  late final CustomListAttribute<SortValue> sort;
  static const String sortKey = "sort";

  /// 标签和条件的关系
  late final Attribute<bool> isAndFilter;
  static const String opKey = "is_and_filter";

  Tag() {
    name.comment = "请输入标签名称";
    content.comment = "请输入标签描述";
    filter = attributes.custom(name: filterKey, title: "过滤条件", comment: "用于过滤事件");
    sort = attributes.customList(name: sortKey, title: "排序条件", comment: "用于过滤后的事件排序");
    isAndFilter = attributes.boolean(
      name: opKey,
      title: "标签与过滤条件是否为并且关系",
      dvalue: false,
      comment: "通过标签查询事件时，如果为并且关系，查询到的事件必须包含该标签并满足过滤条件，否则只需满足其中一个即可",
    );
  }

  /// 预制的数据
  static List<Tag> get initData {
    // 默认的结束状态
    List<String> endStatusIdList = ["done", "undone"];
    List<Status> statusList = Status.initData.where((e) => endStatusIdList.contains(e.id.value)).toList();
    // 开始时间在当日
    SingleFilter todayFilter = SingleFilter.equals(
      field: EventFilterField.startTiming.value,
      value: FilterDateTime(type: FilterDateTimeTypeEnum.day),
    );
    // 结束时间小于当日
    SingleFilter overdueFilter = SingleFilter.lessThan(
      field: EventFilterField.endTiming.value,
      value: FilterDateTime(type: FilterDateTimeTypeEnum.day),
    );
    // 开始时间在次日
    SingleFilter tomorrowFilter = SingleFilter.equals(
      field: EventFilterField.startTiming.value,
      value: FilterDateTime(type: FilterDateTimeTypeEnum.nextDay),
    );
    // 非结束状态
    SingleFilter notEnd = SingleFilter.notInList(field: EventFilterField.status.value, value: statusList);
    // 结束状态
    SingleFilter end = SingleFilter.inList(field: EventFilterField.status.value, value: statusList);
    // 按照开始时间排序
    Sort startTimingSort = Sort(field: EventFilterField.startTiming.value);
    return [
      Tag()
        ..id.value = "today"
        ..name.value = "今天"
        ..content.value = "今天要做的事情。"
        ..icon.value = IconValue.fontIcon(iconData: Icons.today_outlined, iconColor: Colors.blueAccent)
        ..filter.value = GroupFilterValue(filters: [SingleFilterValue(filter: todayFilter), SingleFilterValue(filter: notEnd)])
        ..sort.value = [SortValue(sort: startTimingSort)],
      Tag()
        ..id.value = "tomorrow"
        ..name.value = "明天"
        ..content.value = "明天要做的事情。"
        ..icon.value = IconValue.fontIcon(iconData: Icons.hourglass_top_outlined, iconColor: Colors.orange)
        ..filter.value = GroupFilterValue(filters: [SingleFilterValue(filter: tomorrowFilter), SingleFilterValue(filter: notEnd)])
        ..sort.value = [SortValue(sort: startTimingSort)],
      Tag()
        ..id.value = "overdue"
        ..name.value = "逾期"
        ..content.value = "过去的事情"
        ..icon.value = IconValue.fontIcon(iconData: Icons.hourglass_bottom_outlined, iconColor: Colors.red)
        ..filter.value = GroupFilterValue(filters: [SingleFilterValue(filter: overdueFilter), SingleFilterValue(filter: notEnd)])
        ..sort.value = [SortValue(sort: startTimingSort)],
      Tag()
        ..id.value = "work"
        ..name.value = "工作"
        ..content.value = "眼前的枸杞。"
        ..icon.value = IconValue.fontIcon(iconData: Icons.work, iconColor: Colors.brown)
        ..filter.value = GroupFilterValue(filters: [SingleFilterValue(filter: notEnd)])
        ..isAndFilter.value = true
        ..sort.value = [SortValue(sort: startTimingSort)],
      Tag()
        ..id.value = "study"
        ..name.value = "学习"
        ..content.value = "即将的诗和远方。"
        ..icon.value = IconValue.fontIcon(iconData: Icons.school_outlined)
        ..filter.value = GroupFilterValue(filters: [SingleFilterValue(filter: notEnd)])
        ..isAndFilter.value = true
        ..sort.value = [SortValue(sort: startTimingSort)],
      Tag()
        ..id.value = "fitness"
        ..name.value = "健身"
        ..content.value = "留得青山在，不怕没煤挖。"
        ..icon.value = IconValue.fontIcon(iconData: Icons.fitness_center_outlined, iconColor: Colors.green)
        ..filter.value = GroupFilterValue(filters: [SingleFilterValue(filter: notEnd)])
        ..isAndFilter.value = true
        ..sort.value = [SortValue(sort: startTimingSort)],
      Tag()
        ..id.value = "all"
        ..name.value = "全部"
        ..content.value = "查找全部事件"
        ..icon.value = IconValue.fontIcon(iconData: Icons.list_outlined)
        ..filter.value = GroupFilterValue(
          op: GroupFilterOp.or,
          filters: [
            SingleFilterValue(filter: SingleFilter.isNull(field: EventFilterField.name.value)),
            SingleFilterValue(filter: SingleFilter.notNull(field: EventFilterField.name.value)),
          ],
        )
        ..sort.value = [SortValue(sort: startTimingSort)],
      Tag()
        ..id.value = "notOver"
        ..name.value = "未结束"
        ..content.value = "查找全部未结束的事件"
        ..icon.value = IconValue.fontIcon(iconData: Icons.schedule_outlined)
        ..filter.value = GroupFilterValue(
          filters: [
            GroupFilterValue(
              op: GroupFilterOp.or,
              filters: [
                SingleFilterValue(filter: SingleFilter.isNull(field: EventFilterField.name.value)),
                SingleFilterValue(filter: SingleFilter.notNull(field: EventFilterField.name.value)),
              ],
            ),
            SingleFilterValue(filter: notEnd),
          ],
        )
        ..sort.value = [SortValue(sort: startTimingSort)],
      Tag()
        ..id.value = "over"
        ..name.value = "已结束"
        ..content.value = "查找全部已结束事件"
        ..icon.value = IconValue.fontIcon(iconData: Icons.archive)
        ..filter.value = GroupFilterValue(filters: [
          GroupFilterValue(
            op: GroupFilterOp.or,
            filters: [
              SingleFilterValue(filter: SingleFilter.isNull(field: EventFilterField.name.value)),
              SingleFilterValue(filter: SingleFilter.notNull(field: EventFilterField.name.value)),
            ],
          ),
          SingleFilterValue(filter: end),
        ])
        ..sort.value = [SortValue(sort: startTimingSort)],
    ];
  }
}

extension TagCompare on Tag {
  /// 通过标签的排序规则 对事件进行排序
  /// 没有排序规则，按照事件的时间戳，倒序排序
  int eventCompare(Event a, Event b) {
    // 没有排序规则，按照时间戳倒序
    if (sort.isNull) {
      DateTime timestampA = a.timestamp.value;
      DateTime timestampB = b.timestamp.value;
      return timestampA.isBefore(timestampB) ? 1 : -1;
    }
    int sortCompare = 0;
    // 遍历排序规则
    for (SortValue sortValue in sort.value) {
      // 排序规则为空，忽视
      if (sortValue.isNull) continue;
      Sort sort = sortValue.sort!;
      // 按照排序规则，正序排序先
      sortCompare = _eventCompareBySortAsc(sort, a, b);
      // 按照排序规则，修正排序
      SortOp op = sort.op;
      // 是否正序
      bool isAsc = op == SortOp.asc;
      // 倒序需要取反
      if (!isAsc) sortCompare = -sortCompare;
      // 不相等，返回结果
      if (0 != sortCompare) return sortCompare;
    }
    // 返回结果
    return sortCompare;
  }

  /// 按照排序规则，对事件正序排序
  int _eventCompareBySortAsc(Sort sort, Event a, Event b) {
    String field = sort.field;
    EventFilterField? filterField = EventFilterField.map[field];
    if (null == filterField) return 0;
    return filterField.handleSort(a, b);
  }
}

/// tag在过滤方面的扩展
extension TagFilter on Tag {
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
