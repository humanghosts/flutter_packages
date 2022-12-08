import 'package:hgs_entity/entity.dart';

/// 自定义类型的属性
class CustomAttribute<T extends CustomValue?> extends Attribute<T> {
  CustomAttribute({
    required super.parent,
    required super.name,
    super.title,
    super.comment,
    super.value,
    super.dvalue,
    super.listenerMap,
    T Function()? fromDValue,
  }) : super(fromDValue: fromDValue ?? () => dvalue?.clone() as T);

  @override
  bool get isNull => value == null || value!.isNull;

  @override
  T get cvalue => value?.clone() as T;
}

class CustomListAttribute<T extends CustomValue> extends ListAttribute<T> {
  CustomListAttribute({
    required super.parent,
    required super.name,
    super.title,
    super.comment,
    super.value,
    super.dvalue,
    super.listenerMap,
    List<T> Function()? fromDValue,
  }) : super(fromDValue: fromDValue ?? () => (dvalue ?? []).map((e) => e.clone() as T).toList());

  @override
  List<T> get cvalue {
    if (isNull) return [];
    return value.map((e) => e.clone() as T).toList();
  }
}
