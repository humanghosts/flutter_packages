export 'font_icon.dart';
export 'svg_icon.dart';
export 'text_icon.dart';

/// 图标类型
enum IconType {
  text,
  font,
  svg,
}

/// 图标类型扩展
extension IconTypeEx on IconType {
  String get title {
    switch (this) {
      case IconType.text:
        return "文字图标";
      case IconType.font:
        return "字体图标";
      case IconType.svg:
        return "SVG图标";
    }
  }

  String get name {
    switch (this) {
      case IconType.text:
        return "text";
      case IconType.font:
        return "font";
      case IconType.svg:
        return "svg";
    }
  }

  String get value => name;

  static IconType fromValue(String? value) {
    return IconType.values.firstWhere((element) => value == element.value, orElse: () => IconType.text);
  }
}

/// 类型图标
abstract class TypeIcon {
  const TypeIcon();

  /// 获取图标类型
  IconType get type;

  /// 转换为map
  Map<String, Object?> toMap();
}
