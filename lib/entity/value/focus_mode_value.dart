import 'package:hg_entity/hg_entity.dart';
import 'package:hg_logger/entity/enum/focus_mode.dart';

class FocusModeValue extends CustomValue {
  late FocusMode mode;

  FocusModeValue({this.mode = FocusMode.down});

  @override
  FocusModeValue clone() => FocusModeValue(mode: mode);

  @override
  Future<Object?> toMap({Map<String, Object?>? args}) async {
    return mode.value;
  }

  @override
  Future<FocusModeValue> fromMap(Object? value, {Map<String, Object?>? args}) async {
    if (value is! int) return this;
    mode = FocusMode.map[value]!;
    return this;
  }

  @override
  bool get isNull => false;

  @override
  FocusModeValue merge(CustomValue value) {
    if (value is! FocusModeValue) return this;
    mode = value.mode;
    return this;
  }
}
