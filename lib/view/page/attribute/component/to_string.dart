import 'package:hg_orm/hg_orm.dart';
import 'package:hg_logger/entity/enum/event_filter.dart';

String? groupFilterToString(GroupFilterValue groupFilterValue, {bool format = false, int level = 1}) {
  // 为空返回
  if (groupFilterValue.isNull) return null;
  // 子条件
  List<FilterValue> filters = groupFilterValue.filters;
  // 操作符
  GroupFilterOp op = groupFilterValue.op;
  // 子条件为空 返回空条件值
  if (filters.isEmpty) return "${op.name}:[]";
  StringBuffer sb = StringBuffer();
  // 拼接操作符 如果格式化，操作符后换行
  sb.write("${op.name}:[${format ? "\n" : ""}");
  // 子条件集合
  List<String> childrenStr = [];
  // 缩进
  String subPrefix = "";
  String prefix = "";
  if (format) {
    for (int i = 0; i < level; i++) {
      subPrefix += "  ";
    }
    for (int i = 0; i < level - 1; i++) {
      prefix += "  ";
    }
  }
  // 遍历子条件
  for (FilterValue filter in filters) {
    // 子条件字符串
    String? childStr;
    if (filter is SingleFilterValue) {
      childStr = singleFilterToString(filter);
    } else {
      childStr = groupFilterToString(filter as GroupFilterValue, format: format, level: level + 1);
    }
    if (null == childStr) continue;
    childrenStr.add("$subPrefix$childStr");
  }
  // 添加子条件字符串
  sb.write(childrenStr.join(format ? ",\n" : ","));
  sb.write("${format ? "\n" : ""}$prefix]");
  return sb.toString();
}

String? singleFilterToString(SingleFilterValue singleFilterValue) {
  SingleFilter? filter = singleFilterValue.filter;
  if (null == filter) return null;
  EventFilterField field = EventFilterField.map[filter.field]!;
  String fieldText = field.title;
  String opText = filter.op.name;
  String valueText;
  List<Object> filterValueList = filter.value;
  if (filterValueList.isEmpty) {
    if (filter.op == SingleFilterOp.isNull || filter.op == SingleFilterOp.notNull) {
      valueText = "";
    } else {
      valueText = "空";
    }
  } else {
    if (field.valueType == EventFilterValueType.datetime) {
      if (filter.op == SingleFilterOp.between) {
        valueText = filterValueList.map((e) => e.toString()).join("到");
      } else {
        valueText = filterValueList.first.toString() == "" ? "空" : filterValueList.first.toString();
      }
    } else if (field.valueType == EventFilterValueType.modelList) {
      valueText = "[${(filterValueList.first as List).map((e) => e.toString()).join(",")}]";
    } else {
      valueText = filterValueList.first.toString() == "" ? "空" : filterValueList.first.toString();
    }
  }
  return "$fieldText$opText$valueText";
}

String? sortToString(SortValue sortValue) {
  Sort? sort = sortValue.sort;
  if (null == sort) return null;
  String fieldText = EventFilterField.map[sort.field]!.title;
  String opText = sort.op.title;
  return "$fieldText$opText";
}
