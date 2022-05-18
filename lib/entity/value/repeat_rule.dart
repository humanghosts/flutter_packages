import 'package:hg_entity/hg_entity.dart';
import 'package:hg_logger/entity/enum/repeat_unit.dart';
import 'package:hg_logger/util/datetime_util.dart';

/// 重复规则
class RepeatRule extends CustomValue {
  /// 重复间隔单位
  late RepeatUnit unit;
  static const String _unitKey = "unit";

  /// 重复间隔数
  int? unitNumber;
  static const String _numbersKey = "numbers";

  /// 截至日期 与次数二选一
  DateTime? deadline;
  static const String _deadlineKey = "deadline";

  /// 截止次数 与截至日期二选一
  int? deadtimes;
  static const String _deadtimesKey = "deadtimes";

  /// 构造方法，默认是day
  RepeatRule({this.unitNumber, RepeatUnit? unit, this.deadline, this.deadtimes}) {
    this.unit = unit ?? RepeatUnit.days;
  }

  /// 是否为空 只判断间隔是否大于0
  @override
  bool get isNull => null == unitNumber || unitNumber! <= 0;

  String get uniqueCode => "${unit.value}_${unitNumber}_${deadline?.microsecondsSinceEpoch}_$deadtimes";

  /// 清空
  clear() {
    unit = RepeatUnit.days;
    unitNumber = null;
    deadline = null;
    deadtimes = null;
  }

  /// 复制
  @override
  RepeatRule clone() {
    return RepeatRule(
      unit: unit,
      unitNumber: unitNumber,
      deadline: deadline,
      deadtimes: deadtimes,
    );
  }

  /// 合并
  @override
  RepeatRule merge(Object value) {
    if (value is! RepeatRule) return this;
    unit = value.unit;
    unitNumber = value.unitNumber;
    deadline = value.deadline;
    deadtimes = value.deadtimes;
    return this;
  }

  /// 转换为map
  @override
  Future<Map<String, Object?>> toMap({Map<String, Object?>? args}) async {
    return {
      _unitKey: unit.toMap(),
      _numbersKey: unitNumber,
      _deadlineKey: deadline?.millisecondsSinceEpoch,
      _deadtimesKey: deadtimes,
    };
  }

  /// 从map转换
  @override
  Future<RepeatRule> fromMap(Object? value, {Map<String, Object?>? args}) async {
    if (value is! Map) return this;
    unit = RepeatUnit.fromMap(value[_unitKey])!;
    unitNumber = value[_numbersKey];
    deadline = value[_deadlineKey] == null ? null : DateTime.fromMillisecondsSinceEpoch(value[_deadlineKey]);
    deadtimes = value[_deadtimesKey];
    return this;
  }

  /// 转换为String
  @override
  String toString() {
    if (isNull) {
      return "不重复";
    }
    String text = "每$unitNumber${unit.name}重复一次,";
    if (null != deadline) {
      text += "直到${DateTimeUtil.format(deadline)}";
    } else if (null != deadtimes) {
      text += "重复$deadtimes次";
    } else {
      text += "永远重复";
    }
    return text;
  }
}
