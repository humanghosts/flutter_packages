import 'package:hg_framework/ability/database/database.dart';
import 'package:hg_framework/ability/entity/entity.dart';

/// 时间属性转换器
class DateTimeAttributeConvertor extends AttributeConvertor<DateTimeAttribute, int> {
  DateTimeAttributeConvertor(AttributeConvertors parent) : super(parent);

  @override
  Future<int?> to(DateTimeAttribute? value, {Transaction? tx, bool? isLogicDelete}) async {
    if (value == null) return null;
    DateTime? dateTime = value.value;
    if (null == dateTime) return null;
    return getValue(dateTime);
  }

  @override
  Future<DateTimeAttribute?> from(Object? value, {DateTimeAttribute? attribute, Transaction? tx, bool? isLogicDelete}) async {
    if (null == attribute) return attribute;
    attribute.clear();
    if (null == value) return attribute;
    if (value is! int?) return attribute;
    attribute.value = getDateTime(value as int);
    return attribute;
  }

  /// 转换时间类型
  int getValue(DateTime dateTime) {
    return dateTime.millisecondsSinceEpoch;
  }

  /// 转换为时间类型
  DateTime getDateTime(int value) {
    return DateTime.fromMillisecondsSinceEpoch(value);
  }
}

class DateTimeListAttributeConvertor extends AttributeConvertor<DateTimeListAttribute, List<int>> {
  DateTimeListAttributeConvertor(AttributeConvertors parent) : super(parent);

  @override
  Future<List<int>?> to(DateTimeListAttribute? value, {Transaction? tx, bool? isLogicDelete}) async {
    if (null == value) return null;
    if (value.isNull) return null;
    return value.value.map(getValue).toList();
  }

  @override
  Future<DateTimeListAttribute?> from(Object? value, {DateTimeListAttribute? attribute, Transaction? tx, bool? isLogicDelete}) async {
    if (null == attribute) return attribute;
    attribute.clear();
    if (null == value) return attribute;
    if (value is! List) return attribute;
    for (Object? one in value) {
      if (null == one) continue;
      if (one is! int?) continue;
      attribute.add(getDateTime(one as int));
    }
    return attribute;
  }

  /// 转换时间类型
  int getValue(DateTime dateTime) {
    return dateTime.millisecondsSinceEpoch;
  }

  /// 转换为时间类型
  DateTime getDateTime(int value) {
    return DateTime.fromMillisecondsSinceEpoch(value);
  }
}
