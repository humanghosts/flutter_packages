import 'package:flutter/material.dart';

import 'icon_type.dart';

/// 文字图标
@immutable
class TextIcon extends TypeIcon {
  static IconType iconType = IconType.text;

  final String text;

  const TextIcon(this.text);

  /// 从map构建
  TextIcon.fromMap(Map<String, Object?> map) : text = map["text"].toString();

  @override
  Map<String, Object?> toMap() => {"text": text};

  @override
  IconType get type => iconType;

  @override
  Widget build() {
    return Text(text, maxLines: 1, textScaleFactor: 1);
  }
}
