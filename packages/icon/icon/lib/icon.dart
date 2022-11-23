import 'package:flutter/material.dart';

import 'icon_type/icon_type.dart';
import 'icon_value.dart';
import 'icon_widget.dart';

export 'icon_type/icon_type.dart';
export 'icon_value.dart';
export 'icon_widget.dart';

/// 图标枚举
abstract class IconEnum<T extends TypeIcon> {
  final String name;

  /// 获取图标类型
  Type get iconType => T;

  const IconEnum({required this.name});
}

/// 字体图标枚举
abstract class FontIconEnum<T extends FontIcon> extends IconEnum<T> {
  final IconData iconData;

  const FontIconEnum({required String name, required this.iconData}) : super(name: name);

  String? get fontFamily => iconData.fontFamily;

  int get codePoint => iconData.codePoint;

  String? get fontPackage => iconData.fontPackage;

  bool get matchTextDirection => iconData.matchTextDirection;
}

/// SVG图标枚举
abstract class SvgIconEnum<T extends SvgIcon> extends IconEnum<T> {
  const SvgIconEnum({required String name}) : super(name: name);

  /// 获取文件路径
  String get path;

  /// 获取图标数据
  IconValue get iconValue => IconValue.svg(path: path);

  /// 构建图标
  Widget buildIcon({double? size, Color? color}) => iconValue.buildPreset(size: size, color: color);

  IconValue getIconValue({Color? iconColor, Color? backgroundColor}) => IconValue.svg(
        path: path,
        iconColor: iconColor,
        backgroundColor: backgroundColor,
      );
}
