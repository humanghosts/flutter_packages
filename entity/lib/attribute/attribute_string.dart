import 'package:entity/entity.dart';

/// 字符串类型属性
class StringAttribute<T extends String?> extends Attribute<T> {
  StringAttribute({
    required super.parent,
    required super.name,
    super.title,
    super.comment,
    super.value,
    super.dvalue,
    super.listenerMap,
    super.fromDValue,
  });
}

class StringListAttribute<T extends String> extends ListAttribute<T> {
  StringListAttribute({
    required super.parent,
    required super.name,
    super.title,
    super.comment,
    super.value,
    super.dvalue,
    super.listenerMap,
    super.fromDValue,
  });
}
