import 'package:hg_entity/hg_entity.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_orm/hg_orm.dart';

/// 过滤值类型
class EventFilterValueType {
  /// 名称
  final String name;

  /// 值
  final String value;

  const EventFilterValueType._(this.name, this.value);

  String toMap() {
    return value;
  }

  static EventFilterValueType? fromMap(String? value) {
    return map[value];
  }

  static const _stringValue = "string";
  static const _datetimeValue = "filter_datetime";
  static const _modelListValue = "model_list";

  static const EventFilterValueType string = EventFilterValueType._("字符串", _stringValue);
  static const EventFilterValueType datetime = EventFilterValueType._("时间", _datetimeValue);
  static const EventFilterValueType modelList = EventFilterValueType._("实体列表", _modelListValue);

  static const Map<String, EventFilterValueType> map = {
    _stringValue: string,
    _datetimeValue: datetime,
    _modelListValue: modelList,
  };

  static const List<EventFilterValueType> list = [
    string,
    datetime,
    modelList,
  ];
}

/// 事件可用于 过滤/排序 字段的枚举
/// 主要用于标签和状态的过滤器
class EventFilterField {
  /// 名称
  final String title;

  /// 值，关联event或timing的字段名称
  final String value;

  /// 限定可用操作符
  final List<SingleFilterOp> opList;

  /// 限定值类型
  final EventFilterValueType valueType;

  /// 排序
  final int Function(Event a, Event b) handleSort;

  /// 条件处理
  final void Function(
    GroupFilterValue groupFilterValue,
    SingleFilterValue singleFilterValue, {
    Type? eventType,
  }) handleFilter;

  /// 构造
  const EventFilterField._(
    this.title,
    this.value,
    this.opList,
    this.valueType,
    this.handleSort,
    this.handleFilter,
  );

  /// 作为map存储
  String toMap() => value;

  /// 从map读取
  static EventFilterField? fromMap(int? value) => map[value];

  /// 名称值
  static const _nameValue = Event.nameKey;

  /// 开始时间值
  static const _startTimingValue = Timing.startKey;

  /// 结束时间值
  static const _endTimingValue = Timing.endKey;

  /// 标签值
  static const _tagValue = Event.tagListKey;

  /// 状态值
  static const _statusValue = Event.statusKey;

  /// 优先级值
  static const _priorityValue = Event.priorityKey;

  /// 名称
  static final EventFilterField name = EventFilterField._(
    "名称",
    _nameValue,
    [
      SingleFilterOp.equals,
      SingleFilterOp.notEquals,
      SingleFilterOp.matches,
      SingleFilterOp.isNull,
      SingleFilterOp.notNull,
    ],
    EventFilterValueType.string,
    // 排序方法
    (a, b) {
      String aName = a.toString();
      String bName = b.toString();
      return aName.compareTo(bName);
    },
    // 过滤方法
    _handleOtherFilter,
  );

  /// 开始时间
  static EventFilterField startTiming = EventFilterField._(
    "开始时间",
    _startTimingValue,
    [
      SingleFilterOp.equals,
      SingleFilterOp.lessThan,
      SingleFilterOp.lessThanOrEquals,
      SingleFilterOp.greaterThan,
      SingleFilterOp.greaterThanOrEquals,
      SingleFilterOp.isNull,
      SingleFilterOp.notNull,
      SingleFilterOp.between,
    ],
    EventFilterValueType.datetime,
    //  排序方法
    (a, b) {
      List<Timing> aTimingList = [];
      List<Timing> bTimingList = [];
      // 用于排序
      List<Timing> allTimingList = [];
      // 派生事件和源事件取值不同
      if (a is DeriveEvent) {
        Timing? timing = a.timing.value;
        if (null != timing) {
          aTimingList.add(timing);
          allTimingList.add(timing);
        }
      } else {
        aTimingList.addAll((a as OriginEvent).timingList.value);
        allTimingList.addAll((a).timingList.value);
      }
      if (b is DeriveEvent) {
        Timing? timing = b.timing.value;
        if (null != timing) {
          bTimingList.add(timing);
          allTimingList.add(timing);
        }
      } else {
        bTimingList.addAll((b as OriginEvent).timingList.value);
        allTimingList.addAll((b).timingList.value);
      }
      // 判断是否有一方没有时间
      if (allTimingList.isEmpty) return 0;
      if (aTimingList.isEmpty) return -1;
      if (bTimingList.isEmpty) return 1;
      // 时间排序
      allTimingList.sort((aTiming, bTiming) => aTiming.compareByStart(bTiming));
      // 遍历排序后的时间，判断是否相同
      for (Timing timing in allTimingList) {
        bool isAContains = aTimingList.contains(timing);
        bool isBContains = bTimingList.contains(timing);
        if (isAContains == isBContains) continue;
        return isAContains ? -1 : 1;
      }
      return 0;
    },
    _handleTimingFilter,
  );

  /// 结束时间
  static EventFilterField endTiming = EventFilterField._(
    "结束时间",
    _endTimingValue,
    [
      SingleFilterOp.equals,
      SingleFilterOp.lessThan,
      SingleFilterOp.greaterThan,
      SingleFilterOp.isNull,
      SingleFilterOp.notNull,
      SingleFilterOp.between,
    ],
    EventFilterValueType.datetime,
    // 排序方法
    (a, b) {
      List<Timing> aTimingList = [];
      List<Timing> bTimingList = [];
      // 用于排序
      List<Timing> allTimingList = [];
      // 派生事件和源事件取值不同
      if (a is DeriveEvent) {
        Timing? timing = a.timing.value;
        if (null != timing) {
          aTimingList.add(timing);
          allTimingList.add(timing);
        }
      } else {
        aTimingList.addAll((a as OriginEvent).timingList.value);
        allTimingList.addAll((a).timingList.value);
      }
      if (b is DeriveEvent) {
        Timing? timing = b.timing.value;
        if (null != timing) {
          bTimingList.add(timing);
          allTimingList.add(timing);
        }
      } else {
        bTimingList.addAll((b as OriginEvent).timingList.value);
        allTimingList.addAll((b).timingList.value);
      }
      // 判断是否有一方没有时间
      if (allTimingList.isEmpty) return 0;
      if (aTimingList.isEmpty) return -1;
      if (bTimingList.isEmpty) return 1;
      // 时间排序
      allTimingList.sort((aTiming, bTiming) => aTiming.compareByEnd(bTiming));
      // 遍历排序后的时间，判断是否相同
      for (Timing timing in allTimingList) {
        bool isAContains = aTimingList.contains(timing);
        bool isBContains = bTimingList.contains(timing);
        if (isAContains == isBContains) continue;
        return isAContains ? -1 : 1;
      }
      return 0;
    },
    // 过滤方法
    _handleTimingFilter,
  );

  /// 标签
  /// 排序按照标签名称排序
  static EventFilterField tag = EventFilterField._(
    "标签",
    _tagValue,
    [SingleFilterOp.containsOne, SingleFilterOp.containsAll],
    EventFilterValueType.modelList,
    (a, b) {
      List<Tag> tagList = [];
      tagList.addAll(a.tagList.value);
      tagList.addAll(b.tagList.value);
      // 都没有tag 返回相等
      if (tagList.isEmpty) return 0;
      // 标签按名称排序 有的在前
      tagList.sort((tagA, tagB) => tagA.toString().compareTo(tagB.toString()));
      for (Tag tag in tagList) {
        bool isAContains = a.tagList.value.indexWhere((element) => element.id.value == tag.id.value) >= 0;
        bool isBContains = b.tagList.value.indexWhere((element) => element.id.value == tag.id.value) >= 0;
        if (isAContains == isBContains) continue;
        return isAContains ? -1 : 1;
      }
      return 0;
    },
    _handleDataModelFilter,
  );

  /// 状态
  /// 排序按照状态名称排序
  static EventFilterField status = EventFilterField._(
    "状态",
    _statusValue,
    [SingleFilterOp.inList, SingleFilterOp.notInList],
    EventFilterValueType.modelList,
    (a, b) {
      String nullName = Status().toString();
      String aStatus = a.status.value?.name.value ?? nullName;
      String bStatus = a.status.value?.name.value ?? nullName;
      return aStatus.compareTo(bStatus);
    },
    _handleDataModelFilter,
  );

  /// 优先级
  /// 排序按照优先级权重排序
  static EventFilterField priority = EventFilterField._(
    "优先级",
    _priorityValue,
    [SingleFilterOp.inList, SingleFilterOp.notInList],
    EventFilterValueType.modelList,
    (a, b) {
      int aPriority = a.priority.value?.weight.value ?? 0;
      int bPriority = a.priority.value?.weight.value ?? 0;
      return aPriority - bPriority;
    },
    _handleDataModelFilter,
  );

  /// 集合
  static Map<String, EventFilterField> map = {
    _nameValue: name,
    _startTimingValue: startTiming,
    _endTimingValue: endTiming,
    _tagValue: tag,
    _statusValue: status,
    _priorityValue: priority,
  };

  /// 集合
  static List<EventFilterField> list = [name, startTiming, endTiming, tag, status, priority];

  /// 处理开始事件或者结束时间条件
  /// 区间条件处理为左闭右开区间，例如[01-01 00:00,01-02 00:00]，表示0101当天的时间，这里比较容易处理
  static void _handleTimingFilter(
    GroupFilterValue group,
    SingleFilterValue single, {
    Type? eventType,
  }) {
    if (single.isNull) return;
    int index = group.filters.indexOf(single);
    // 值处理
    SingleFilterOp op = single.filter!.op;
    SingleFilter filter = single.filter!;
    // 区间处理
    if (op == SingleFilterOp.between) {
      // 开始
      FilterDateTime? start = single.filter!.get(0);
      // 结束
      FilterDateTime? end = single.filter!.get(1);
      // 真实的开始时间
      FilterDateTimeReturn? realStart = start?.toDateTime(op, true);
      // 真实的结束时间
      FilterDateTimeReturn? realEnd = end?.toDateTime(op, false);
      // 清空原来的值
      filter.clear();
      if (null == realStart) {
        // 全为空 处理为为空
        if (null == realEnd) {
          filter.op = SingleFilterOp.isNull;
        }
        // 结束时间非空，处理为小于结束时间
        else {
          filter.op = SingleFilterOp.lessThan;
          filter.append(realEnd.end ?? realEnd.start);
        }
      } else {
        // 开始时间非空，处理为大于等于开始时间
        if (null == realEnd) {
          filter.op = SingleFilterOp.greaterThanOrEquals;
          filter.append(realStart.start);
        }
        // 都非空按照between处理(orm的between是左闭右开)
        else {
          filter.append(realStart.start);
          filter.append(realEnd.end ?? realEnd.start);
        }
      }
    }
    // 剩下的操作符,除了 非空和为空处理
    else if (op != SingleFilterOp.isNull && op != SingleFilterOp.notNull) {
      FilterDateTime? value = filter.get(0);
      FilterDateTimeReturn? realValue = value?.toDateTime(op, true);
      filter.clear();
      // 没有值处理为为空
      if (null == realValue) {
        filter.op = SingleFilterOp.isNull;
      } else {
        filter.op = realValue.op;
        filter.append(realValue.start);
        // 有end说明真实时间是区间 op是between
        if (null != realValue.end) {
          filter.append(realValue.end!);
        }
      }
    }
    // 非空和为空处理
    else {
      // 不需要处理
    }
    // timing_list处理 用于源事件 orm包已支持带.查询
    SingleFilterValue timingListValue = single.clone();
    timingListValue.filter!.field = "${OriginEvent.timingListKey}.${timingListValue.filter!.field}";
    // timing处理 用于派生事件 orm包已支持带.查询
    SingleFilterValue timingValue = single.clone();
    timingValue.filter!.field = "${DeriveEvent.timingKey}.${timingValue.filter!.field}";
    // 移除原来的条件
    group.filters.removeAt(index);
    // 放入新加的 或条件
    if (eventType == DeriveEvent) {
      group.filters.add(timingValue);
    } else if (eventType == OriginEvent) {
      group.filters.add(timingListValue);
    } else {
      // 不带类型处理有风险
      // 如果处理isNull的话会导致完全查不出来
      GroupFilterValue newFilter = GroupFilterValue();
      newFilter.op = GroupFilterOp.or;
      GroupFilterValue timingList = GroupFilterValue(filters: [
        SingleFilterValue(filter: SingleFilter.notNull(field: "${OriginEvent.timingListKey}.${timingListValue.filter!.field}")),
        timingListValue,
      ]);
      GroupFilterValue timing = GroupFilterValue(filters: [
        SingleFilterValue(filter: SingleFilter.notNull(field: "${DeriveEvent.timingKey}.${timingValue.filter!.field}")),
        timingValue,
      ]);
      newFilter.filters.addAll([timingList, timing]);
      group.filters.add(newFilter);
    }
  }

  /// 处理数据模型类型的过滤条件
  /// 需要保证原始值是model类型的，否则会类型转换错误
  static void _handleDataModelFilter(
    GroupFilterValue group,
    SingleFilterValue single, {
    Type? eventType,
  }) {
    if (single.isNull) return;
    // 获取过滤条件
    SingleFilter filter = single.filter!;
    List<Object> valueList = [...filter.value];
    // 清空原来的值
    filter.clear();
    ValueConvertors convertors = ValueConvertors.instance;
    // 遍历处理值
    for (Object oneValue in valueList) {
      if (oneValue is List) {
        filter.append(oneValue.map((e) => convertors.attributeConvertors.dataModel.getValue(e)).toList());
      } else {
        filter.append(convertors.attributeConvertors.dataModel.getValue(oneValue as DataModel));
      }
    }
  }

  /// 处理其它类型的过滤条件
  static void _handleOtherFilter(
    GroupFilterValue group,
    SingleFilterValue single, {
    Type? eventType,
  }) {}
}
