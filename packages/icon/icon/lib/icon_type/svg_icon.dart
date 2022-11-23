import 'package:flutter/material.dart';

import 'icon_type.dart';

/// SVG图标
@immutable
class SvgIcon extends TypeIcon {
  static IconType iconType = IconType.svg;

  /// svg文件路径
  final String path;

  const SvgIcon(this.path);

  /// 从map构建
  SvgIcon.fromMap(Map<String, Object?> map) : path = map["path"].toString();

  @override
  Map<String, Object?> toMap() => {"path": path};

  @override
  IconType get type => iconType;
}
