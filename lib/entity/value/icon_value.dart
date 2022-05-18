import 'package:flutter/material.dart';
import 'package:hg_entity/hg_entity.dart';

import '../enum/icon_type.dart';

/// 图标值，不一定是图标，可以是文字，图标
class IconValue extends CustomValue {
  /// 图标类型
  late Type iconType;
  static const String _iconTypeKey = "icon_type";

  /// 图标数据
  late IconType _iconData;
  static const String _iconDataKey = "icon_data";

  /// 图标颜色
  late int iconColor;
  static const String _iconColorKey = "icon_color";

  /// 背景色
  late int backgroundColor;
  static const String _backgroundColorKey = "background_color";

  /// 空参构造，默认值
  IconValue() {
    iconType = FontIcon;
    _iconData = FontIcon.fromIconData(Icons.add_task_outlined);
    iconColor = Colors.black.value;
    backgroundColor = Colors.white.value;
  }

  /// 图标类型
  IconValue.fontIcon({
    IconData iconData = Icons.add_task_outlined,
    Color iconColor = Colors.black,
    Color backgroundColor = Colors.white,
  })  : iconType = FontIcon,
        _iconData = FontIcon.fromIconData(iconData),
        iconColor = iconColor.value,
        backgroundColor = backgroundColor.value;

  /// 文字类型
  IconValue.text({
    String text = "事",
    Color iconColor = Colors.black,
    Color backgroundColor = Colors.white,
  })  : iconType = TextIcon,
        _iconData = TextIcon(text),
        iconColor = iconColor.value,
        backgroundColor = backgroundColor.value;

  /// 文字类型
  IconValue.svg({
    required String path,
    Color iconColor = Colors.black,
    Color backgroundColor = Colors.white,
  })  : iconType = SvgIcon,
        _iconData = SvgIcon(path),
        iconColor = iconColor.value,
        backgroundColor = backgroundColor.value;

  /// 获取值
  IconType get iconData => _iconData;

  /// 设置值
  set iconData(IconType iconData) {
    _iconData = iconData;
    iconType = iconData.runtimeType;
  }

  /// 是否为空
  @override
  bool get isNull => false;

  /// 合并
  @override
  IconValue merge(Object value) {
    if (value is! IconValue) return this;
    iconType = value.iconType;
    iconData = value.iconData;
    iconColor = value.iconColor;
    backgroundColor = value.backgroundColor;
    return this;
  }

  /// 复制
  @override
  IconValue clone() {
    if (iconType == TextIcon) {
      return IconValue.text(text: (iconData as TextIcon).text, iconColor: Color(iconColor), backgroundColor: Color(backgroundColor));
    } else if (iconType == SvgIcon) {
      return IconValue.svg(path: (iconData as SvgIcon).path, iconColor: Color(iconColor), backgroundColor: Color(backgroundColor));
    } else {
      return IconValue.fontIcon(iconData: (iconData as FontIcon).toIconData(), iconColor: Color(iconColor), backgroundColor: Color(backgroundColor));
    }
  }

  /// 转换为map
  @override
  Future<Map<String, Object>> toMap({Map<String, Object?>? args}) async {
    Map<String, Object> map = {};
    map[_iconTypeKey] = iconType.toString();
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
    iconColor = mapValue[_iconColorKey] as int;
    backgroundColor = mapValue[_backgroundColorKey] as int;
    String iconTypeKey = mapValue[_iconTypeKey] as String;
    Map<String, Object?> iconData = mapValue[_iconDataKey] as Map<String, Object?>;
    if (iconTypeKey == "TextIcon") {
      iconType = TextIcon;
      this.iconData = TextIcon.fromMap(iconData);
    } else if (iconTypeKey == "SvgIcon") {
      iconType = SvgIcon;
      this.iconData = SvgIcon.fromMap(iconData);
    } else {
      iconType = FontIcon;
      this.iconData = FontIcon.fromMap(iconData);
    }
    return this;
  }
}
