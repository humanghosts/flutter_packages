import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:theme/theme.dart';

import 'icon_type/icon_type.dart';
import 'icon_value.dart';

/// 图标值 扩展，用于通过图标值直接构建组件
extension IconValueWidget on IconValue {
  /// 直接构建图标
  /// [size]指定图标大小
  /// [color]指定图标颜色
  Widget build({double? size, Color? color}) {
    switch (iconType) {
      case IconType.text:
        return SizedBox.square(
          dimension: size,
          child: FittedBox(
            fit: BoxFit.contain,
            child: Text(
              (iconData as TextIcon).text,
              maxLines: 1,
              textScaleFactor: 1,
            ),
          ),
        );
      case IconType.font:
        return Icon(
          (iconData as FontIcon).toIconData(),
          size: size,
        );
      case IconType.svg:
        return SvgPicture.asset(
          (iconData as SvgIcon).path,
          width: size,
          height: size,
        );
    }
  }

  /// 预置构建图标
  /// [size]不指定使用24
  /// [color]不指定使用Icon自带Color，次用主题默认颜色
  /// 需要[ThemeHelper]支持
  Widget buildPreset({double? size, Color? color}) {
    Color? iconColor = color ?? (this.iconColor == null ? null : Color(this.iconColor!));
    ThemeData themeData = ThemeHelper().themeData;
    Widget icon;
    switch (iconType) {
      case IconType.text:
        icon = Text(
          (iconData as TextIcon).text,
          maxLines: 1,
          textScaleFactor: 1,
          style: TextStyle(
            color: iconColor,
            overflow: TextOverflow.clip,
          ).merge(
            themeData.textTheme.displayLarge?.copyWith(
              color: iconColor,
              overflow: TextOverflow.clip,
            ),
          ),
        );
        break;
      case IconType.font:
        icon = Icon(
          (iconData as FontIcon).toIconData(),
          color: iconColor,
          size: size,
        );
        break;
      case IconType.svg:
        icon = SvgPicture.asset(
          (iconData as SvgIcon).path,
          color: iconColor ?? themeData.iconTheme.color,
          width: size,
          height: size,
        );
        break;
    }
    return SizedBox.square(
      dimension: size ?? 24,
      child: FittedBox(child: icon),
    );
  }
}
