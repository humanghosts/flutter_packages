import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'icon_type.dart';

/// SVG图标
class SvgIcon extends TypeIcon {
  static IconType iconType = IconType.svg;

  /// svg内容 可修改
  final String svg;

  const SvgIcon({required this.svg});

  SvgIcon.fromMap(Map<String, Object?> map) : svg = map["svg"] as String;

  @override
  IconType get type => iconType;

  @override
  Widget build() {
    return SvgPicture.string(svg);
  }

  @override
  Map<String, Object?> toMap() {
    return {"svg": svg};
  }
}
