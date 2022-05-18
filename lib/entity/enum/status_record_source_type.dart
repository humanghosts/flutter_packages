import 'package:flutter/material.dart';

/// 状态来源枚举
class StatusRecordSourceType {
  final String name;
  final String value;
  final IconData icon;

  const StatusRecordSourceType._(this.name, this.value, this.icon);

  String toMap() {
    return value;
  }

  static StatusRecordSourceType? fromMap(String? value) {
    return map[value];
  }

  static const _auto = "user";
  static const _user = "system";

  static const StatusRecordSourceType auto = StatusRecordSourceType._("系统", _auto, Icons.computer);
  static const StatusRecordSourceType user = StatusRecordSourceType._("用户", _user, Icons.person);

  static const Map<String, StatusRecordSourceType> map = {
    _auto: auto,
    _user: user,
  };

  static const List<StatusRecordSourceType> list = [
    auto,
    user,
  ];

  @override
  String toString() {
    return name;
  }
}
