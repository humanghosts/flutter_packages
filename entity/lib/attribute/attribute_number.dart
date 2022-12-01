import 'package:hgs_entity/entity.dart';

/// 数字类型属性
class NumberAttribute<T extends num?> extends Attribute<T> {
  NumberAttribute({
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

class NumberListAttribute<T extends num> extends ListAttribute<T> {
  NumberListAttribute({
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

/// 整型
class IntegerAttribute<T extends int?> extends NumberAttribute<T> {
  IntegerAttribute({
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

class IntegerListAttribute<T extends int> extends NumberListAttribute<T> {
  IntegerListAttribute({
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

/// 浮点型
class FloatAttribute<T extends double?> extends NumberAttribute<T> {
  FloatAttribute({
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

class FloatListAttribute<T extends double> extends NumberListAttribute<T> {
  FloatListAttribute({
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
