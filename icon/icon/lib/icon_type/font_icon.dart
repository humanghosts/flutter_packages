import 'package:flutter/material.dart';

import 'icon_type.dart';

/// 图标图标
/// 代码是从IconData类拷贝过来的，因为要直接存储这个类的所有数据
@immutable
class FontIcon extends TypeIcon {
  final int codePoint;
  final String? fontFamily;
  final String? fontPackage;
  final bool matchTextDirection;

  static IconType iconType = IconType.font;

  const FontIcon(
    this.codePoint, {
    this.fontFamily,
    this.fontPackage,
    this.matchTextDirection = false,
  });

  /// 从IconData 构建
  FontIcon.fromIconData(IconData iconData)
      : codePoint = iconData.codePoint,
        fontFamily = iconData.fontFamily,
        fontPackage = iconData.fontPackage,
        matchTextDirection = iconData.matchTextDirection;

  /// 从map构建
  FontIcon.fromMap(Map<String, Object?> map)
      : codePoint = map["codePoint"] as int,
        fontFamily = map["fontFamily"] as String?,
        fontPackage = map["fontPackage"] as String?,
        matchTextDirection = map["matchTextDirection"] as bool;

  IconData toIconData() {
    return IconData(codePoint, fontFamily: fontFamily, fontPackage: fontPackage, matchTextDirection: matchTextDirection);
  }

  @override
  IconType get type => iconType;

  @override
  Map<String, Object?> toMap() {
    return {
      "codePoint": codePoint,
      "fontFamily": fontFamily,
      "fontPackage": fontPackage,
      "matchTextDirection": matchTextDirection,
    };
  }

  @override
  Widget build() {
    return Icon(toIconData());
  }
}
