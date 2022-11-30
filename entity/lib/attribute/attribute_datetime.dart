import 'package:entity/entity.dart';

/// 时间类型
class DateTimeAttribute<T extends DateTime?> extends Attribute<T> {
  DateTimeAttribute({
    required super.parent,
    required super.name,
    super.title,
    super.comment,
    super.value,
    super.dvalue,
    super.listenerMap,
    T Function()? fromDValue,
  }) : super(fromDValue: fromDValue ?? () => DateTime.fromMillisecondsSinceEpoch((dvalue as DateTime).millisecondsSinceEpoch) as T);

  @override
  T get cvalue {
    if (isNull) {
      return null as T;
    }
    return DateTime.fromMillisecondsSinceEpoch((value as DateTime).millisecondsSinceEpoch) as T;
  }
}

class DateTimeListAttribute<T extends DateTime> extends ListAttribute<T> {
  DateTimeListAttribute({
    required super.parent,
    required super.name,
    super.title,
    super.comment,
    super.value,
    super.dvalue,
    super.listenerMap,
    List<T> Function()? fromDValue,
  }) : super(fromDValue: fromDValue ?? () => (dvalue ?? []).map((e) => DateTime.fromMillisecondsSinceEpoch(e.millisecondsSinceEpoch) as T).toList());

  @override
  List<T> get cvalue {
    if (isNull) return [];
    return value.map((e) => DateTime.fromMillisecondsSinceEpoch(e.millisecondsSinceEpoch) as T).toList();
  }
}
