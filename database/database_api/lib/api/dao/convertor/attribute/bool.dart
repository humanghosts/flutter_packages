import 'package:hgs_database_api/database_api.dart';
import 'package:hgs_entity/entity.dart';

/// 布尔类型
class BooleanAttributeConvertor extends AttributeConvertor<BooleanAttribute, bool> {
  BooleanAttributeConvertor(AttributeConvertors parent) : super(parent);

  @override
  Future<bool?> to(BooleanAttribute? value, {Transaction? tx, bool? isLogicDelete}) async {
    return value?.value;
  }

  @override
  Future<BooleanAttribute?> from(Object? value, {BooleanAttribute? attribute, Transaction? tx, bool? isLogicDelete}) async {
    if (null == attribute) return attribute;
    attribute.clear();
    if (value is! bool?) return attribute;
    attribute.valueTypeless = value;
    return attribute;
  }
}

class BooleanListAttributeConvertor extends AttributeConvertor<BooleanListAttribute, List<bool>> {
  BooleanListAttributeConvertor(AttributeConvertors parent) : super(parent);

  @override
  Future<List<bool>?> to(BooleanListAttribute? value, {Transaction? tx, bool? isLogicDelete}) async {
    return value?.value;
  }

  @override
  Future<BooleanListAttribute?> from(Object? value, {BooleanListAttribute? attribute, Transaction? tx, bool? isLogicDelete}) async {
    if (null == attribute) return attribute;
    attribute.clear();
    if (null == value) return attribute;
    if (value is! List) return attribute;
    for (Object? one in value) {
      if (null == one) continue;
      if (one is! bool?) continue;
      attribute.add(one as bool);
    }
    return attribute;
  }
}
