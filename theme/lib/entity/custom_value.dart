import 'package:entity/entity.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

import 'export.dart';

/// 主题模式
class ThemeModeValue extends CustomValue {
  late ThemeMode mode;

  ThemeModeValue({this.mode = ThemeMode.system});

  @override
  ThemeModeValue clone() => ThemeModeValue(mode: mode);

  @override
  Future<Object?> toMap({Map<String, Object?>? args}) async {
    return mode.index;
  }

  @override
  Future<ThemeModeValue> fromMap(Object? value, {Map<String, Object?>? args}) async {
    if (value is! int) return this;
    mode = ThemeMode.values[value];
    return this;
  }

  @override
  bool get isNull => false;

  @override
  ThemeModeValue merge(CustomValue value) {
    if (value is! ThemeModeValue) return this;
    mode = value.mode;
    return this;
  }

  @override
  String toString() {
    return mode.title;
  }
}

/// 主题方案
class FlexSchemeValue extends CustomValue {
  late FlexScheme scheme;

  FlexSchemeValue({this.scheme = FlexScheme.hippieBlue});

  @override
  FlexSchemeValue clone() => FlexSchemeValue(scheme: scheme);

  @override
  Future<Object?> toMap({Map<String, Object?>? args}) async {
    return scheme.index;
  }

  @override
  Future<FlexSchemeValue> fromMap(Object? value, {Map<String, Object?>? args}) async {
    if (value is! int) return this;
    scheme = FlexScheme.values[value];
    return this;
  }

  @override
  bool get isNull => false;

  @override
  FlexSchemeValue merge(CustomValue value) {
    if (value is! FlexSchemeValue) return this;
    scheme = value.scheme;
    return this;
  }

  @override
  String toString() {
    return scheme.title;
  }
}

/// 表面值
class FlexSurfaceModeValue extends CustomValue {
  late FlexSurfaceMode mode;

  FlexSurfaceModeValue({this.mode = FlexSurfaceMode.highScaffoldLowSurface});

  @override
  FlexSurfaceModeValue clone() => FlexSurfaceModeValue(mode: mode);

  @override
  Future<Object?> toMap({Map<String, Object?>? args}) async {
    return mode.index;
  }

  @override
  Future<FlexSurfaceModeValue> fromMap(Object? value, {Map<String, Object?>? args}) async {
    if (value is! int) return this;
    mode = FlexSurfaceMode.values[value];
    return this;
  }

  @override
  bool get isNull => false;

  @override
  FlexSurfaceModeValue merge(CustomValue value) {
    if (value is! FlexSurfaceModeValue) return this;
    mode = value.mode;
    return this;
  }

  @override
  String toString() {
    return mode.title;
  }
}

/// 方案色彩
class SchemeColorValue extends CustomValue {
  late SchemeColor? scheme;

  SchemeColorValue({this.scheme});

  @override
  SchemeColorValue clone() => SchemeColorValue(scheme: scheme);

  @override
  Future<Object?> toMap({Map<String, Object?>? args}) async {
    return scheme?.index;
  }

  @override
  Future<SchemeColorValue> fromMap(Object? value, {Map<String, Object?>? args}) async {
    if (value is! int) return this;
    scheme = SchemeColor.values[value];
    return this;
  }

  @override
  bool get isNull => false;

  @override
  SchemeColorValue merge(CustomValue value) {
    if (value is! SchemeColorValue) return this;
    scheme = value.scheme;
    return this;
  }

  @override
  String toString() {
    return scheme?.colorType?.title ?? "";
  }
}

/// AppBar样式
class FlexAppBarStyleValue extends CustomValue {
  late FlexAppBarStyle style;

  FlexAppBarStyleValue({this.style = FlexAppBarStyle.primary});

  @override
  FlexAppBarStyleValue clone() => FlexAppBarStyleValue(style: style);

  @override
  Future<Object?> toMap({Map<String, Object?>? args}) async {
    return style.index;
  }

  @override
  Future<FlexAppBarStyleValue> fromMap(Object? value, {Map<String, Object?>? args}) async {
    if (value is! int) return this;
    style = FlexAppBarStyle.values[value];
    return this;
  }

  @override
  bool get isNull => false;

  @override
  FlexAppBarStyleValue merge(CustomValue value) {
    if (value is! FlexAppBarStyleValue) return this;
    style = value.style;
    return this;
  }

  @override
  String toString() {
    return style.title;
  }
}

/// TabBar样式
class FlexTabBarStyleValue extends CustomValue {
  late FlexTabBarStyle style;

  FlexTabBarStyleValue({this.style = FlexTabBarStyle.forAppBar});

  @override
  FlexTabBarStyleValue clone() => FlexTabBarStyleValue(style: style);

  @override
  Future<Object?> toMap({Map<String, Object?>? args}) async {
    return style.index;
  }

  @override
  Future<FlexTabBarStyleValue> fromMap(Object? value, {Map<String, Object?>? args}) async {
    if (value is! int) return this;
    style = FlexTabBarStyle.values[value];
    return this;
  }

  @override
  bool get isNull => false;

  @override
  FlexTabBarStyleValue merge(CustomValue value) {
    if (value is! FlexTabBarStyleValue) return this;
    style = value.style;
    return this;
  }

  @override
  String toString() {
    return style.title;
  }
}

/// 输入框边框类型
class FlexInputBorderTypeValue extends CustomValue {
  late FlexInputBorderType type;

  FlexInputBorderTypeValue({this.type = FlexInputBorderType.outline});

  @override
  FlexInputBorderTypeValue clone() => FlexInputBorderTypeValue(type: type);

  @override
  Future<Object?> toMap({Map<String, Object?>? args}) async {
    return type.index;
  }

  @override
  Future<FlexInputBorderTypeValue> fromMap(Object? value, {Map<String, Object?>? args}) async {
    if (value is! int) return this;
    type = FlexInputBorderType.values[value];
    return this;
  }

  @override
  bool get isNull => false;

  @override
  FlexInputBorderTypeValue merge(CustomValue value) {
    if (value is! FlexInputBorderTypeValue) return this;
    type = value.type;
    return this;
  }

  @override
  String toString() {
    return type.title;
  }
}

/// 系统导航栏样式
class FlexSystemNavBarStyleValue extends CustomValue {
  late FlexSystemNavBarStyle style;

  FlexSystemNavBarStyleValue({this.style = FlexSystemNavBarStyle.background});

  @override
  FlexSystemNavBarStyleValue clone() => FlexSystemNavBarStyleValue(style: style);

  @override
  Future<Object?> toMap({Map<String, Object?>? args}) async {
    return style.index;
  }

  @override
  Future<FlexSystemNavBarStyleValue> fromMap(Object? value, {Map<String, Object?>? args}) async {
    if (value is! int) return this;
    style = FlexSystemNavBarStyle.values[value];
    return this;
  }

  @override
  bool get isNull => false;

  @override
  FlexSystemNavBarStyleValue merge(CustomValue value) {
    if (value is! FlexSystemNavBarStyleValue) return this;
    style = value.style;
    return this;
  }

  @override
  String toString() {
    return style.title;
  }
}

/// 导航目的地标签行为
class NavigationDestinationLabelBehaviorValue extends CustomValue {
  late NavigationDestinationLabelBehavior behavior;

  NavigationDestinationLabelBehaviorValue({this.behavior = NavigationDestinationLabelBehavior.alwaysShow});

  @override
  NavigationDestinationLabelBehaviorValue clone() => NavigationDestinationLabelBehaviorValue(behavior: behavior);

  @override
  Future<Object?> toMap({Map<String, Object?>? args}) async {
    return behavior.index;
  }

  @override
  Future<NavigationDestinationLabelBehaviorValue> fromMap(Object? value, {Map<String, Object?>? args}) async {
    if (value is! int) return this;
    behavior = NavigationDestinationLabelBehavior.values[value];
    return this;
  }

  @override
  bool get isNull => false;

  @override
  NavigationDestinationLabelBehaviorValue merge(CustomValue value) {
    if (value is! NavigationDestinationLabelBehaviorValue) return this;
    behavior = value.behavior;
    return this;
  }

  @override
  String toString() {
    return behavior.title;
  }
}

/// 导航栏标签类型
class NavigationRailLabelTypeValue extends CustomValue {
  late NavigationRailLabelType type;

  NavigationRailLabelTypeValue({this.type = NavigationRailLabelType.all});

  @override
  NavigationRailLabelTypeValue clone() => NavigationRailLabelTypeValue(type: type);

  @override
  Future<Object?> toMap({Map<String, Object?>? args}) async {
    return type.index;
  }

  @override
  Future<NavigationRailLabelTypeValue> fromMap(Object? value, {Map<String, Object?>? args}) async {
    if (value is! int) return this;
    type = NavigationRailLabelType.values[value];
    return this;
  }

  @override
  bool get isNull => false;

  @override
  NavigationRailLabelTypeValue merge(CustomValue value) {
    if (value is! NavigationRailLabelTypeValue) return this;
    type = value.type;
    return this;
  }

  @override
  String toString() {
    return type.title;
  }
}

/// 色彩
class ColorValue extends CustomValue {
  late Color color;

  ColorValue({this.color = const Color(0xFF004881)});

  @override
  ColorValue clone() => ColorValue(color: color);

  @override
  Future<Object?> toMap({Map<String, Object?>? args}) async {
    return color.value;
  }

  @override
  Future<ColorValue> fromMap(Object? value, {Map<String, Object?>? args}) async {
    if (value is! int) return this;
    color = Color(value);
    return this;
  }

  @override
  bool get isNull => false;

  @override
  ColorValue merge(CustomValue value) {
    if (value is! ColorValue) return this;
    color = value.color;
    return this;
  }

  @override
  String toString() {
    return '#${color.hexCode}';
  }
}
