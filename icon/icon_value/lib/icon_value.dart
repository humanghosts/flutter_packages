import 'dart:convert';

import 'package:entity/entity.dart';
import 'package:flutter/material.dart';
import 'package:icon/icon.dart';

/// 图标值
class IconValue extends CustomValue {
  /// 图标类型
  late IconType _iconType;
  static const String _iconTypeKey = "icon_type";

  /// 图标数据
  late TypeIcon _iconData;
  static const String _iconDataKey = "icon_data";

  /// 空参构造，默认值
  IconValue() {
    _iconType = FontIcon.iconType;
    _iconData = FontIcon.fromIconData(Icons.add_task_outlined);
  }

  /// 图标类型
  IconValue.fontIcon({
    IconData iconData = Icons.add_task_outlined,
  })  : _iconType = FontIcon.iconType,
        _iconData = FontIcon.fromIconData(iconData);

  /// 文字类型
  IconValue.text({
    String text = "文",
  })  : _iconType = TextIcon.iconType,
        _iconData = TextIcon(text);

  /// 文字类型
  IconValue.svg({
    required TypeIcon iconData,
  })  : _iconType = SvgIcon.iconType,
        _iconData = iconData;

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
    return this;
  }

  /// 复制
  @override
  IconValue clone() {
    switch (_iconType) {
      case IconType.text:
        return IconValue.text(text: (iconData as TextIcon).text);
      case IconType.font:
        return IconValue.fontIcon(iconData: (iconData as FontIcon).toIconData());
      case IconType.svg:
        return IconValue.svg(iconData: _iconData);
    }
  }

  /// 转换为map
  @override
  Future<Map<String, Object?>> toMap({Map<String, Object?>? args}) async {
    Map<String, Object?> map = {};
    map[_iconTypeKey] = _iconType.value;
    map[_iconDataKey] = iconData.toMap();
    return map;
  }

  /// 从map转换
  @override
  Future<IconValue> fromMap(Object? value, {Map<String, Object?>? args}) async {
    if (value is! Map) return this;
    Map<String, Object?> mapValue = value as Map<String, Object?>;
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
    return json.encode(map);
  }
}
