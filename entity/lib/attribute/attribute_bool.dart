import 'package:entity/entity.dart';

/// 布尔类型的值
class BooleanAttribute<T extends bool?> extends Attribute<T> {
  BooleanAttribute({
    required super.parent,
    required super.name,
    super.title,
    super.comment,
    super.value,
    super.dvalue,
    super.listenerMap,
    super.fromDValue,
  });

  @override
  String toString() {
    if (value == null) return "";
    if (value == true) return "是";
    if (value == false) return "否";
    return value.toString();
  }
}

class BooleanListAttribute<T extends bool> extends ListAttribute<T> {
  BooleanListAttribute({
    required super.parent,
    required super.name,
    super.title,
    super.comment,
    super.value,
    super.dvalue,
    super.listenerMap,
    super.fromDValue,
  });

  @override
  String toString() {
    if (value.isEmpty) return "";
    return value.map((e) {
      if (e == true) return "是";
      if (e == false) return "否";
      return e.toString();
    }).join(",");
  }
}
