import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hg_framework/hg_framework.dart';

import 'icon_type/icon_type.dart';

/// 图标值
class IconValue extends CustomValue {
  /// 图标类型
  late IconType _iconType;
  static const String _iconTypeKey = "icon_type";

  /// 图标数据
  late TypeIcon _iconData;
  static const String _iconDataKey = "icon_data";

  /// 图标颜色
  int? iconColor;
  static const String _iconColorKey = "icon_color";

  /// 背景色
  int? backgroundColor;
  static const String _backgroundColorKey = "background_color";

  /// 空参构造，默认值
  IconValue() {
    _iconType = FontIcon.iconType;
    _iconData = FontIcon.fromIconData(Icons.add_task_outlined);
  }

  /// 图标类型
  IconValue.fontIcon({
    IconData iconData = Icons.add_task_outlined,
    Color? iconColor,
    Color? backgroundColor,
  })  : _iconType = FontIcon.iconType,
        _iconData = FontIcon.fromIconData(iconData),
        iconColor = iconColor?.value,
        backgroundColor = backgroundColor?.value;

  /// 文字类型
  IconValue.text({
    String text = "文",
    Color? iconColor,
    Color? backgroundColor,
  })  : _iconType = TextIcon.iconType,
        _iconData = TextIcon(text),
        iconColor = iconColor?.value,
        backgroundColor = backgroundColor?.value;

  /// 文字类型
  IconValue.svg({
    required String path,
    Color? iconColor,
    Color? backgroundColor,
  })  : _iconType = SvgIcon.iconType,
        _iconData = SvgIcon(path),
        iconColor = iconColor?.value,
        backgroundColor = backgroundColor?.value;

  /// 获取图标类型
  IconType get iconType => _iconType;

  /// 获取图标值
  TypeIcon get iconData => _iconData;

  /// 设置图标值，同时设置图标类型
  set iconData(TypeIcon iconData) {
    _iconData = iconData;
    _iconType = iconData.type;
  }

  /// 是否为空
  @override
  bool get isNull => false;

  /// 合并
  @override
  IconValue merge(Object value) {
    if (value is! IconValue) return this;
    _iconType = value._iconType;
    iconData = value.iconData;
    iconColor = value.iconColor;
    backgroundColor = value.backgroundColor;
    return this;
  }

  /// 复制
  @override
  IconValue clone() {
    Color? iconColor = this.iconColor == null ? null : Color(this.iconColor!);
    Color? backgroundColor = this.backgroundColor == null ? null : Color(this.backgroundColor!);

    switch (_iconType) {
      case IconType.text:
        return IconValue.text(
          text: (iconData as TextIcon).text,
          iconColor: iconColor,
          backgroundColor: backgroundColor,
        );
      case IconType.font:
        return IconValue.fontIcon(
          iconData: (iconData as FontIcon).toIconData(),
          iconColor: iconColor,
          backgroundColor: backgroundColor,
        );
      case IconType.svg:
        return IconValue.svg(
          path: (iconData as SvgIcon).path,
          iconColor: iconColor,
          backgroundColor: backgroundColor,
        );
    }
  }

  /// 转换为map
  @override
  Future<Map<String, Object?>> toMap({Map<String, Object?>? args}) async {
    Map<String, Object?> map = {};
    map[_iconTypeKey] = _iconType.value;
    map[_iconDataKey] = iconData.toMap();
    map[_iconColorKey] = iconColor;
    map[_backgroundColorKey] = backgroundColor;
    return map;
  }

  /// 从map转换
  @override
  Future<IconValue> fromMap(Object? value, {Map<String, Object?>? args}) async {
    if (value is! Map) return this;
    Map<String, Object?> mapValue = value as Map<String, Object?>;
    iconColor = mapValue[_iconColorKey] as int?;
    backgroundColor = mapValue[_backgroundColorKey] as int?;
    String? iconTypeValue = mapValue[_iconTypeKey] as String?;
    Map<String, Object?> iconData = mapValue[_iconDataKey] as Map<String, Object?>;
    _iconType = IconTypeEx.fromValue(iconTypeValue);
    switch (_iconType) {
      case IconType.text:
        this.iconData = TextIcon.fromMap(iconData);
        break;
      case IconType.font:
        this.iconData = FontIcon.fromMap(iconData);
        break;
      case IconType.svg:
        this.iconData = SvgIcon.fromMap(iconData);
        break;
    }
    return this;
  }

  @override
  String toString() {
    Map<String, Object?> map = {};
    map[_iconTypeKey] = _iconType.toString();
    map[_iconDataKey] = iconData.toMap();
    map[_iconColorKey] = iconColor;
    map[_backgroundColorKey] = backgroundColor;
    return json.encode(map);
  }
}
