import 'dart:async';

import '../api.dart';

/// 数据库查询的过滤条件
abstract class Filter {
  /// 拷贝
  Filter clone();
}

/// 过滤条件操作符的抽象
abstract class FilterOp {
  /// 操作服名称
  final String name;

  /// 操作服符号
  final String value;

  const FilterOp._(this.name, this.value);

  @override
  String toString() => name;
}

/// 单个过滤条件
/// 值为List类型，用于适配不同操作符的元素个数
/// 如between操作服，操作元素是两个，分别放在值的第0位和第1位，
/// inList虽然是列表类型的条件，但是整个List条件只会放在第0位
/// 无论是几个元素的操作符，都要求所有值的类型要一致，包括List中的每一个元素。
class SingleFilter extends Filter {
  /// 字段名称 不可为空
  String field;

  /// 操作符 不可为空
  SingleFilterOp op;

  /// 值，可多个，集合类型值占一个位置
  final List<Object> _value = [];

  /// 值类型，集合类型为泛型类型
  Type? _valueType;

  SingleFilter({required this.field, SingleFilterOp? op}) : op = op ?? SingleFilterOp.equals;

  /// 等于
  SingleFilter.equals({required this.field, required Object value}) : op = SingleFilterOp.equals {
    append(value);
  }

  /// 不等于
  SingleFilter.notEquals({required this.field, required Object value}) : op = SingleFilterOp.notEquals {
    append(value);
  }

  /// 为空
  SingleFilter.isNull({required this.field}) : op = SingleFilterOp.isNull;

  /// 非空
  SingleFilter.notNull({required this.field}) : op = SingleFilterOp.notNull;

  /// 小于
  SingleFilter.lessThan({required this.field, required Object value}) : op = SingleFilterOp.lessThan {
    append(value);
  }

  /// 小于等于
  SingleFilter.lessThanOrEquals({required this.field, required Object value}) : op = SingleFilterOp.lessThanOrEquals {
    append(value);
  }

  /// 大于
  SingleFilter.greaterThan({required this.field, required Object value}) : op = SingleFilterOp.greaterThan {
    append(value);
  }

  /// 大于等于
  SingleFilter.greaterThanOrEquals({required this.field, required Object value}) : op = SingleFilterOp.greaterThanOrEquals {
    append(value);
  }

  /// 在列表中(数据库中存储的值为单个，查询条件为多个)
  SingleFilter.inList({required this.field, required List value}) : op = SingleFilterOp.inList {
    appendList(value);
  }

  /// 不在列表中(数据库中存储的值为单个，查询条件为多个)
  SingleFilter.notInList({required this.field, required List value}) : op = SingleFilterOp.notInList {
    appendList(value);
  }

  /// 模糊匹配
  SingleFilter.matches({required this.field, required Object value}) : op = SingleFilterOp.matches {
    append(value);
  }

  /// 模糊不匹配
  SingleFilter.notMatches({required this.field, required Object value}) : op = SingleFilterOp.notMatches {
    append(value);
  }

  /// 模糊匹配开头
  SingleFilter.matchesStart({required this.field, required Object value}) : op = SingleFilterOp.matchesStart {
    append(value);
  }

  /// 模糊不匹配开头
  SingleFilter.notMatchesStart({required this.field, required Object value}) : op = SingleFilterOp.notMatchesStart {
    append(value);
  }

  /// 在区间内
  SingleFilter.between({required this.field, required Object start, required Object end}) : op = SingleFilterOp.between {
    append(start);
    append(end);
  }

  /// 包含全部(数据库中存储的值为多个，查询条件为多个)
  SingleFilter.containsAll({required this.field, required List value}) : op = SingleFilterOp.containsAll {
    appendList(value);
  }

  /// 至少包含一个(数据库中存储的值为多个，查询条件为多个)
  SingleFilter.containsOne({required this.field, required List value}) : op = SingleFilterOp.containsOne {
    appendList(value);
  }

  /// 包含全部(数据库中存储的值为多个，查询条件为多个)
  SingleFilter.contains({required this.field, required Object value}) : op = SingleFilterOp.contains {
    append(value);
  }

  /// 至少包含一个(数据库中存储的值为多个，查询条件为多个)
  SingleFilter.notContains({required this.field, required Object value}) : op = SingleFilterOp.notContains {
    append(value);
  }

  /// 自定义查询
  SingleFilter.custom({required this.field, required this.op, required List value}) {
    for (var value1 in value) {
      append(value1);
    }
  }

  /// 获取值类型
  Type get valueType => _valueType ?? Object;

  /// 获取值
  List<Object> get value => _value;

  /// 想List类型的value中追加一个值，校验或存储值类型
  /// 如果追加的值是List类型，将调用appendList
  void append(Object value) {
    if (value is List) {
      appendList(value);
      return;
    }
    _valueType ??= value.runtimeType;
    assert("${value.runtimeType}" == "$_valueType");
    _value.add(value);
  }

  /// 设置List类型的value中的某个位置的值，校验设置的值类型是否符合
  void set(int index, Object value) {
    _valueType ??= value.runtimeType;
    assert("${value.runtimeType}" == "$_valueType");
    _value[index] = value;
  }

  /// 获取某个位置的值
  T? get<T>(int index) {
    if (index >= _value.length) {
      return null;
    }
    return _value[index] as T;
  }

  /// 追加一个List类型的值，会遍历值是否与当前值类型相符
  void appendList(List valueList) {
    for (Object value in valueList) {
      _valueType ??= value.runtimeType;
      assert("${value.runtimeType}" == "$_valueType");
    }
    _value.add(valueList);
  }

  /// 移除一个位置的值
  void removeAt(int index) {
    _value.removeAt(index);
  }

  /// 清空所有值，但不会清空值类型
  void removeAll(List<int> indexList) {
    for (int index in indexList) {
      removeAt(index);
    }
  }

  /// 清空所有值，并清空值类型
  void clear() {
    _value.clear();
    _valueType = null;
  }

  /// 这是浅克隆
  @override
  SingleFilter clone() {
    SingleFilter newSingleFilter = SingleFilter(field: field, op: op);
    newSingleFilter._value.addAll(value);
    newSingleFilter._valueType = _valueType;
    return newSingleFilter;
  }

  @override
  String toString() {
    return "$field${op.value}$_value($valueType)";
  }
}

/// 组合过滤条件
class GroupFilter extends Filter {
  /// 组合操作服
  GroupFilterOp op;

  /// 子条件
  late List<Filter> children;

  GroupFilter({
    this.op = GroupFilterOp.and,
    List<Filter>? children,
  }) {
    this.children = children ?? [];
  }

  /// 与
  GroupFilter.and(List<Filter>? children) : op = GroupFilterOp.and {
    this.children = children ?? [];
  }

  /// 或
  GroupFilter.or(List<Filter>? children) : op = GroupFilterOp.or {
    this.children = children ?? [];
  }

  @override
  Filter clone() {
    GroupFilter newGroupFilter = GroupFilter(op: op);
    for (Filter child in children) {
      newGroupFilter.children.add(child.clone());
    }
    return newGroupFilter;
  }

  @override
  String toString() {
    if (children.isEmpty) {
      return "${op.name}:[]";
    }
    StringBuffer sb = StringBuffer();
    sb.writeln("${op.name}:[");
    for (var child in children) {
      sb.writeln("  ${child.toString()},");
    }
    sb.write("]");
    return sb.toString();
  }
}

/// 单个过滤条件可匹配
extension SingleFilterMatchable on SingleFilter {
  /// 转换单个过滤条件
  bool isMatch(Map<String, Object?> record) {
    return op.isMatch(record: record, field: field, conditions: value) as bool;
  }

  /// 异步转换条件 适合用代码处理查询条件
  /// record可以使用[ModelConvertor]或[AttributeConvertor]提供
  Future<bool> isMatchAsync(Map<String, Object?> record) async {
    return await op.isMatch(record: record, field: field, conditions: value);
  }
}

/// 条件组可匹配
extension GroupFilterMatchable on GroupFilter {
  bool isMatch(Map<String, Object?> record) {
    if (this.children.isEmpty) return false;
    GroupFilterOp op = this.op;
    List<Filter> children = this.children;
    for (Filter child in children) {
      bool isMatch;
      if (child is GroupFilter) {
        isMatch = child.isMatch(record);
      } else if (child is SingleFilter) {
        isMatch = child.isMatch(record);
      } else {
        continue;
      }
      if (GroupFilterOp.or == op && isMatch) return true;
      if (GroupFilterOp.and == op && !isMatch) return false;
    }
    return GroupFilterOp.and == op;
  }

  /// 异步转换条件 适合用代码处理查询条件
  /// record可以使用[ModelConvertor]或[AttributeConvertor]提供
  Future<bool> isMatchAsync(Map<String, Object?> record) async {
    if (this.children.isEmpty) return false;
    GroupFilterOp op = this.op;
    List<Filter> children = this.children;
    for (Filter child in children) {
      bool isMatch;
      if (child is GroupFilter) {
        isMatch = await child.isMatchAsync(record);
      } else if (child is SingleFilter) {
        isMatch = await child.isMatchAsync(record);
      } else {
        continue;
      }
      if (GroupFilterOp.or == op && isMatch) return true;
      if (GroupFilterOp.and == op && !isMatch) return false;
    }
    return GroupFilterOp.and == op;
  }
}

/// 添加操作符步骤
/// 1. OP类操作
///   1.1 添加符号
///   1.2 添加常量
///   1.3 添加到list和map中
/// 2. Filter类中添加命名构造函数
/// 3. 不同数据库的convert类中，添加操作符转换
class SingleFilterOp<T extends Object> extends FilterOp {
  /// 操作符需要的值的数量
  final int valueNumbers;
  final SingleFilterOp? child;

  /// 是否匹配
  late final FutureOr<bool> Function({
    required Map<String, Object?> record,
    required String field,
    required List<T?> conditions,
  }) isMatch;

  SingleFilterOp(
    String title,
    String symbol, {
    this.valueNumbers = 1,
    required this.isMatch,
    this.child,
  }) : super._(title, symbol);

  SingleFilterOp.not(
    String title,
    String symbol, {
    this.valueNumbers = 1,
    required SingleFilterOp childOp,
  })  : child = childOp,
        super._(title, symbol) {
    isMatch = ({required Map<String, Object?> record, required String field, required List<Object?> conditions}) async {
      FutureOr<bool> childResult = child!.isMatch(record: record, field: field, conditions: conditions);
      if (childResult is Future) {
        return !(await childResult);
      }
      return !childResult;
    };
  }

  static const notSymbol = "not";
  static const equalsSymbol = "=";
  static const notEqualsSymbol = "!=";
  static const isNullSymbol = "isNull";
  static const notNullSymbol = "notNull";
  static const lessThanSymbol = "<";
  static const lessThanOrEqualsSymbol = "<=";
  static const greaterThanSymbol = ">";
  static const greaterThanOrEqualsSymbol = ">=";
  static const inListSymbol = "in";
  static const notInListSymbol = "notin";
  static const matchesSymbol = "matches";
  static const notMatchesSymbol = "notMatches";
  static const matchesStartSymbol = "matchesStart";
  static const notMatchesStartSymbol = "notMatchesStart";
  static const betweenSymbol = "between";
  static const containsAllSymbol = "containsAll";
  static const containsOneSymbol = "containsOne";
  static const containsSymbol = "contains";
  static const notContainsSymbol = "notContains";

  static SingleFilterOp equals = SingleFilterOp(
    "等于",
    equalsSymbol,
    isMatch: ({required Map<String, Object?> record, required String field, required List<Object?> conditions}) {
      Object? value = getValue(conditions, 0);
      return getMatch(
        record: record,
        field: field,
        // 如果value为null null as true
        nullAsTrue: value == null,
        isMatch: (recordValue) {
          if (value is DateTime) {
            int intValue = value.millisecondsSinceEpoch;
            return recordValue == intValue;
          } else {
            return recordValue == value;
          }
        },
      );
    },
  );
  static SingleFilterOp notEquals = SingleFilterOp(
    "不等于",
    notEqualsSymbol,
    isMatch: ({required Map<String, Object?> record, required String field, required List<Object?> conditions}) {
      Object? value = getValue(conditions, 0);
      return getMatch(
        record: record,
        field: field,
        // 如果value为null null as true
        nullAsTrue: value != null,
        isMatch: (recordValue) {
          if (value is DateTime) {
            int intValue = value.millisecondsSinceEpoch;
            return recordValue != intValue;
          } else {
            return recordValue != value;
          }
        },
      );
    },
  );
  static SingleFilterOp isNull = SingleFilterOp(
    "为空",
    isNullSymbol,
    valueNumbers: 0,
    isMatch: ({required Map<String, Object?> record, required String field, required List<Object?> conditions}) {
      return getMatch(
        record: record,
        field: field,
        nullAsTrue: true,
        isMatch: (recordValue) => recordValue == null,
      );
    },
  );
  static SingleFilterOp notNull = SingleFilterOp(
    "非空",
    notNullSymbol,
    valueNumbers: 0,
    isMatch: ({required Map<String, Object?> record, required String field, required List<Object?> conditions}) {
      return getMatch(
        record: record,
        field: field,
        nullAsTrue: false,
        isMatch: (recordValue) => recordValue != null,
      );
    },
  );
  static SingleFilterOp lessThan = SingleFilterOp(
    "小于",
    lessThanSymbol,
    isMatch: ({required Map<String, Object?> record, required String field, required List<Object?> conditions}) {
      Object? value = getValue(conditions, 0);
      return getMatch(
        record: record,
        field: field,
        // 当值不为空的时候，没有值就是小于
        nullAsTrue: value != null,
        isMatch: (recordValue) {
          if (value is DateTime) {
            return _lessThan(recordValue, value.millisecondsSinceEpoch);
          } else {
            return _lessThan(recordValue, value);
          }
        },
      );
    },
  );
  static SingleFilterOp lessThanOrEquals = SingleFilterOp(
    "小于等于",
    lessThanOrEqualsSymbol,
    isMatch: ({required Map<String, Object?> record, required String field, required List<Object?> conditions}) {
      Object? value = getValue(conditions, 0);
      return getMatch(
        record: record,
        field: field,
        nullAsTrue: value != null,
        isMatch: (recordValue) {
          if (value is DateTime) {
            int intValue = value.millisecondsSinceEpoch;
            return _lessThan(recordValue, intValue) || recordValue == intValue;
          } else {
            return _lessThan(recordValue, value) || recordValue == value;
          }
        },
      );
    },
  );
  static SingleFilterOp greaterThan = SingleFilterOp(
    "大于",
    greaterThanSymbol,
    isMatch: ({required Map<String, Object?> record, required String field, required List<Object?> conditions}) {
      Object? value = getValue(conditions, 0);
      return getMatch(
        record: record,
        field: field,
        nullAsTrue: null == value,
        isMatch: (recordValue) {
          if (value is DateTime) {
            return _greaterThan(recordValue, value.millisecondsSinceEpoch);
          } else {
            return _greaterThan(recordValue, value);
          }
        },
      );
    },
  );
  static SingleFilterOp greaterThanOrEquals = SingleFilterOp(
    "大于等于",
    greaterThanOrEqualsSymbol,
    isMatch: ({required Map<String, Object?> record, required String field, required List<Object?> conditions}) {
      Object? value = getValue(conditions, 0);
      return getMatch(
        record: record,
        field: field,
        nullAsTrue: null == value,
        isMatch: (recordValue) {
          if (value is DateTime) {
            int intValue = value.millisecondsSinceEpoch;
            return _greaterThan(recordValue, intValue) || recordValue == intValue;
          } else {
            return _greaterThan(recordValue, value) || recordValue == value;
          }
        },
      );
    },
  );
  static SingleFilterOp inList = SingleFilterOp(
    "在范围内",
    inListSymbol,
    isMatch: ({required Map<String, Object?> record, required String field, required List<Object?> conditions}) {
      List? value = getValue(conditions, 0) as List?;
      return getMatch(
        record: record,
        field: field,
        isMatch: (recordValue) => value?.contains(recordValue) ?? false,
      );
    },
  );
  static SingleFilterOp notInList = SingleFilterOp(
    "不在范围内",
    notInListSymbol,
    isMatch: ({required Map<String, Object?> record, required String field, required List<Object?> conditions}) {
      List? value = getValue(conditions, 0) as List?;
      return getMatch(
        record: record,
        field: field,
        nullAsTrue: true,
        isMatch: (recordValue) {
          if (null == value) return true;
          return !value.contains(recordValue);
        },
      );
    },
  );
  static SingleFilterOp matches = SingleFilterOp(
    "匹配",
    matchesSymbol,
    isMatch: ({required Map<String, Object?> record, required String field, required List<Object?> conditions}) {
      String? value = getValue(conditions, 0) as String?;
      return getMatch(
        record: record,
        field: field,
        nullAsTrue: value == null,
        isMatch: (recordValue) {
          if (null == value) return false;
          return RegExp(value).hasMatch(recordValue.toString());
        },
      );
    },
  );
  static SingleFilterOp notMatches = SingleFilterOp(
    "不匹配",
    matchesSymbol,
    isMatch: ({required Map<String, Object?> record, required String field, required List<Object?> conditions}) {
      String? value = getValue(conditions, 0) as String?;
      return getMatch(
        record: record,
        field: field,
        nullAsTrue: value != null,
        isMatch: (recordValue) {
          if (null == value) return true;
          return !(RegExp(value).hasMatch(recordValue.toString()));
        },
      );
    },
  );
  static SingleFilterOp matchesStart = SingleFilterOp(
    "开始匹配",
    matchesSymbol,
    isMatch: ({required Map<String, Object?> record, required String field, required List<Object?> conditions}) {
      String? value = getValue(conditions, 0) as String?;
      return getMatch(
        record: record,
        field: field,
        nullAsTrue: value == null,
        isMatch: (recordValue) {
          if (null == value) return false;
          return recordValue.toString().startsWith(value);
        },
      );
    },
  );
  static SingleFilterOp notMatchesStart = SingleFilterOp(
    "开始不匹配",
    matchesSymbol,
    isMatch: ({required Map<String, Object?> record, required String field, required List<Object?> conditions}) {
      String? value = getValue(conditions, 0) as String?;
      return getMatch(
        record: record,
        field: field,
        isMatch: (recordValue) {
          if (null == value) return true;
          return !recordValue.toString().startsWith(value);
        },
      );
    },
  );

  /// 左闭右开区间
  static SingleFilterOp between = SingleFilterOp(
    "在区间内",
    betweenSymbol,
    valueNumbers: 2,
    isMatch: ({required Map<String, Object?> record, required String field, required List<Object?> conditions}) {
      return getMatch(
        record: record,
        field: field,
        isMatch: (recordValue) {
          int startInt = 0;
          int endInt = 0;
          if (getValue(conditions, 0) is DateTime) startInt = (getValue(conditions, 0) as DateTime).millisecondsSinceEpoch;
          if (getValue(conditions, 1) is DateTime) endInt = (getValue(conditions, 1) as DateTime).millisecondsSinceEpoch;
          if (null == recordValue) return false;
          if (recordValue is! int) return false;
          if (startInt == 0 && endInt == 0) return false;
          if (startInt != 0 && endInt != 0) return recordValue < endInt && recordValue >= startInt;
          if (startInt == 0) {
            return recordValue < endInt;
          } else {
            return recordValue > startInt;
          }
        },
      );
    },
  );
  static SingleFilterOp containsAll = SingleFilterOp(
    "包含全部",
    containsAllSymbol,
    isMatch: ({
      required Map<String, Object?> record,
      required String field,
      required List<Object?> conditions,
    }) {
      return getMatch(
        record: record,
        field: field,
        isMatch: (recordValue) {
          if (null == recordValue) return false;
          List? filterValueList = getValue(conditions, 0) as List?;
          if (null == filterValueList) return false;
          List recordValueList = recordValue as List;
          for (var oneValue in filterValueList) {
            if (!recordValueList.contains(oneValue)) return false;
          }
          return true;
        },
      );
    },
  );
  static SingleFilterOp containsOne = SingleFilterOp(
    "至少包含一个",
    containsOneSymbol,
    isMatch: ({
      required Map<String, Object?> record,
      required String field,
      required List<Object?> conditions,
    }) {
      return getMatch(
        record: record,
        field: field,
        isMatch: (recordValue) {
          if (null == recordValue) return false;
          List? filterValueList = getValue(conditions, 0) as List?;
          if (null == filterValueList) return false;
          List recordValueList = recordValue as List;
          for (var oneValue in filterValueList) {
            if (recordValueList.contains(oneValue)) return true;
          }
          return false;
        },
      );
    },
  );
  static SingleFilterOp contains = SingleFilterOp(
    "包含",
    containsSymbol,
    isMatch: ({
      required Map<String, Object?> record,
      required String field,
      required List<Object?> conditions,
    }) {
      return getMatch(
        record: record,
        field: field,
        isMatch: (recordValue) {
          Object? value = getValue(conditions, 0);
          if (null == recordValue && null == value) return true;
          if (null != recordValue || null != value) return false;
          List recordValueList = recordValue as List;
          return recordValueList.contains(value);
        },
      );
    },
  );
  static SingleFilterOp notContains = SingleFilterOp(
    "不包含",
    notContainsSymbol,
    isMatch: ({
      required Map<String, Object?> record,
      required String field,
      required List<Object?> conditions,
    }) {
      return getMatch(
        record: record,
        field: field,
        nullAsTrue: true,
        isMatch: (recordValue) {
          Object? value = getValue(conditions, 0);
          if (null == recordValue && null == value) return true;
          if (null != recordValue || null != value) return false;
          List recordValueList = recordValue as List;
          return !recordValueList.contains(value);
        },
      );
    },
  );

  static List<SingleFilterOp> list = [
    equals,
    notEquals,
    isNull,
    notNull,
    lessThan,
    lessThanOrEquals,
    greaterThan,
    greaterThanOrEquals,
    inList,
    notInList,
    matches,
    notMatches,
    matchesStart,
    notMatchesStart,
    between,
    containsAll,
    containsOne,
  ];

  static Map<String, SingleFilterOp> map = {
    equalsSymbol: equals,
    notEqualsSymbol: notEquals,
    isNullSymbol: isNull,
    notNullSymbol: notNull,
    lessThanSymbol: lessThan,
    lessThanOrEqualsSymbol: lessThanOrEquals,
    greaterThanSymbol: greaterThan,
    greaterThanOrEqualsSymbol: greaterThanOrEquals,
    inListSymbol: inList,
    notInListSymbol: notInList,
    matchesSymbol: matches,
    notMatchesSymbol: notMatches,
    matchesStartSymbol: matchesStart,
    notMatchesStartSymbol: notMatchesStart,
    betweenSymbol: between,
    containsAllSymbol: containsAll,
    containsOneSymbol: containsOne,
  };

  static Object? getValue(List<Object?> valueList, int index) {
    if (index >= valueList.length) return null;
    return valueList[index];
  }

  /// 是否匹配
  static bool getMatch({
    required Map<String, Object?> record,
    required String field,
    bool nullAsTrue = false,
    required bool Function(Object? recordValue) isMatch,
  }) {
    return _getMapMatch(mapValue: record, field: field, nullAsTrue: nullAsTrue, isMatch: isMatch);
  }

  /// map类型匹配
  static bool _getMapMatch({
    required Map<String, Object?> mapValue,
    required String field,
    bool nullAsTrue = false,
    required bool Function(Object? recordValue) isMatch,
  }) {
    Map<String, Object?> map = mapValue;
    List<String> keys = field.split(".");
    // 当前key
    String key = keys[0];
    // 不存在key返回不匹配
    if (!map.containsKey(key)) return nullAsTrue;
    // 如果是最后一个key 并且存在key，判断是否匹配
    Object? value = map[key];
    if (keys.length == 1) {
      return isMatch(value);
    }
    // 不是最后一个key 继续向下寻找
    String nextKey = keys.sublist(1).join(".");
    // list类型处理
    if (value is List) {
      return _getListMatch(listValue: value, field: nextKey, nullAsTrue: nullAsTrue, isMatch: isMatch);
    }
    // map类型处理
    if (value is Map) {
      return _getMapMatch(mapValue: value as Map<String, Object?>, field: nextKey, nullAsTrue: nullAsTrue, isMatch: isMatch);
    }
    // 其它类型不匹配
    return false;
  }

  /// list类型匹配
  static bool _getListMatch({
    required List listValue,
    required String field,
    bool nullAsTrue = false,
    required bool Function(Object? recordValue) isMatch,
  }) {
    bool match = false;
    for (Object? value in listValue) {
      if (null == value) continue;
      // list类型处理
      if (value is List) {
        match = match || _getListMatch(listValue: value, field: field, nullAsTrue: nullAsTrue, isMatch: isMatch);
      }
      // map类型处理
      if (value is Map) {
        match = match || _getMapMatch(mapValue: value as Map<String, Object?>, field: field, nullAsTrue: nullAsTrue, isMatch: isMatch);
      }
      if (match) {
        return match;
      }
    }
    return match;
  }

  /// 比较 copy from sembast
  static int? _safeCompare(Object? value1, Object? value2) {
    try {
      if (value1 is Comparable && value2 is Comparable) {
        return Comparable.compare(value1, value2);
      }
    } catch (_) {}
    return null;
  }

  /// 是否小于 copy from sembast
  static bool _lessThan(Object? value1, Object? value2) {
    var cmp = _safeCompare(value1, value2);
    return cmp != null && cmp < 0;
  }

  /// 是否大于 copy from sembast
  static bool _greaterThan(Object? value1, Object? value2) {
    var cmp = _safeCompare(value1, value2);
    return cmp != null && cmp > 0;
  }
}

/// 条件组操作符
class GroupFilterOp extends FilterOp {
  const GroupFilterOp._(String title, String symbol) : super._(title, symbol);

  static const _andSymbol = "and";
  static const _orSymbol = "or";

  static const GroupFilterOp and = GroupFilterOp._("并且", _andSymbol);
  static const GroupFilterOp or = GroupFilterOp._("或者", _orSymbol);

  static const List<GroupFilterOp> list = [and, or];

  static const Map<String, GroupFilterOp> map = {_andSymbol: and, _orSymbol: or};
}
