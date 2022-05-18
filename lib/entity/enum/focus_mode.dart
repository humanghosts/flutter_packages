import 'package:flutter/cupertino.dart';

/// 专注模式
@immutable
class FocusMode {
  /// 名称
  final String name;

  /// 值
  final int value;

  const FocusMode._(this.name, this.value);

  int toMap() {
    return value;
  }

  static FocusMode? fromMap(int value) {
    return map[value];
  }

  static const List<FocusMode> list = [
    down,
    up,
  ];

  static const _downValue = 0;
  static const _upValue = 1;

  static const Map<int, FocusMode> map = {
    _downValue: down,
    _upValue: up,
  };
  static const FocusMode down = FocusMode._("倒计时", _downValue);
  static const FocusMode up = FocusMode._("正计时", _upValue);
}
