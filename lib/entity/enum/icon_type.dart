import 'package:flutter/material.dart';

/// 图标类型
abstract class IconType {
  const IconType();

  /// 从map转换出来
  Map<String, Object?> toMap();
}

/// 图标图标
/// 代码是从IconData类拷贝过来的，因为要直接存储这个类的所有数据
class FontIcon extends IconType {
  final int codePoint;
  final String? fontFamily;
  final String? fontPackage;
  final bool matchTextDirection;

  FontIcon(
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
  Map<String, Object?> toMap() {
    return {
      "codePoint": codePoint,
      "fontFamily": fontFamily,
      "fontPackage": fontPackage,
      "matchTextDirection": matchTextDirection,
    };
  }
}

/// 文字图标
@immutable
class TextIcon extends IconType {
  final String text;

  const TextIcon(this.text);

  /// 从map构建
  TextIcon.fromMap(Map<String, Object?> map) : text = map["text"].toString();

  @override
  Map<String, Object?> toMap() => {"text": text};
}

@immutable
class SvgIcon extends IconType {
  /// svg文件路径
  final String path;

  const SvgIcon(this.path);

  /// 从map构建
  SvgIcon.fromMap(Map<String, Object?> map) : path = map["path"].toString();

  @override
  Map<String, Object?> toMap() => {"path": path};
}
