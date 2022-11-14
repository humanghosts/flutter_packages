import 'package:hg_framework/ability/database/database.dart';
import 'package:hg_framework/ability/entity/entity.dart';

/// 自定义值类型
class CustomAttributeConvertor extends AttributeConvertor<CustomAttribute, Object> {
  CustomAttributeConvertor(AttributeConvertors parent) : super(parent);

  @override
  Future<Object?> to(CustomAttribute? value, {Transaction? tx, bool? isLogicDelete}) async {
    if (null == value) return null;
    CustomValue? customValue = value.value;
    if (customValue == null || customValue.isNull) return null;
    return await customValue.toMap(args: {
      "tx": tx,
      "isLogicDelete": isLogicDelete,
    });
  }

  @override
  Future<CustomAttribute?> from(Object? value, {CustomAttribute? attribute, Transaction? tx, bool? isLogicDelete}) async {
    if (null == attribute) return attribute;
    attribute.clear();
    if (null == value) return attribute;
    if (attribute.isNull) {
      attribute.value = ConstructorCache.get(attribute.type);
    }
    // entity包在orm包之下，使用map传参
    await attribute.value!.fromMap(value, args: {
      "tx": tx,
      "isLogicDelete": isLogicDelete,
    });
    return attribute;
  }
}

class CustomListAttributeConvertor extends AttributeConvertor<CustomListAttribute, List<Object>> {
  CustomListAttributeConvertor(AttributeConvertors parent) : super(parent);

  @override
  Future<List<Object>?> to(CustomListAttribute? value, {Transaction? tx, bool? isLogicDelete}) async {
    if (null == value) return null;
    if (value.isNull) return null;
    List<Object> valueList = [];
    for (CustomValue customValue in value.value) {
      Object? oneValue = await customValue.toMap(args: {
        "tx": tx,
        "isLogicDelete": isLogicDelete,
      });
      if (oneValue == null) continue;
      valueList.add(oneValue);
    }
    return valueList;
  }

  @override
  Future<CustomListAttribute?> from(Object? value, {CustomListAttribute? attribute, Transaction? tx, bool? isLogicDelete}) async {
    if (null == attribute) return attribute;
    attribute.clear();
    if (value is! List) return attribute;
    for (Object? one in value) {
      if (null == one) continue;
      CustomValue customValue = ConstructorCache.get(attribute.type);
      await customValue.fromMap(one, args: {
        "tx": tx,
        "isLogicDelete": isLogicDelete,
      });
      attribute.add(customValue);
    }
    return attribute;
  }
}
