import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hg_entity/hg_entity.dart';
import 'package:hg_logger/entity/config/theme/theme.dart';

/// 新拟态主题模板数据
class NeumorphicThemeTemplateData extends ThemeTemplateData {
  /// 基础色
  late final Attribute<int> baseColor;

  /// 高度/深度
  late final Attribute<double> depth;

  /// 凸起亮投影色
  late final Attribute<int> shadowLightColor;

  /// 凸起暗投影色
  late final Attribute<int> shadowDarkColor;

  /// 凹陷暗投影色
  late final Attribute<int> shadowDarkColorEmboss;

  /// 凹陷亮投影色
  late final Attribute<int> shadowLightColorEmboss;

  /// 边框宽度
  late final Attribute<double> borderWidth;

  /// 边框颜色
  late final Attribute<int> borderColor;

  /// 默认按钮颜色
  late final Attribute<int> defaultIconColor;

  /// 默认文本颜色
  late final Attribute<int> defaultTextColor;

  /// 默认禁用颜色
  late final Attribute<int> disabledColor;

  /// 默认强调颜色
  late final Attribute<int> accentColor;

  /// 色彩强度
  late final Attribute<double> intensity;

  NeumorphicThemeTemplateData({
    String? name,
    int? baseColor,
    double? depth,
    int? shadowLightColor,
    int? shadowDarkColor,
    int? shadowDarkColorEmboss,
    int? shadowLightColorEmboss,
    double? borderWidth,
    int? borderColor,
    int? defaultIconColor,
    int? defaultTextColor,
    int? disabledColor,
    int? accentColor,
    double? intensity,
  }) {
    this.baseColor = attributes.integer(name: "base_color", title: "基础色", value: baseColor, dvalue: NeumorphicColors.background.value);
    this.depth = attributes.float(name: "depth", title: "高度/深度", value: depth, dvalue: 4);
    this.shadowLightColor =
        attributes.integer(name: "shadow_light_color", title: "凸起亮投影色", value: shadowLightColor, dvalue: NeumorphicColors.decorationMaxWhiteColor.value);
    this.shadowDarkColor =
        attributes.integer(name: "shadow_dark_color", title: "凸起暗投影色", value: shadowDarkColor, dvalue: NeumorphicColors.decorationMaxDarkColor.value);
    this.shadowDarkColorEmboss =
        attributes.integer(name: "shadow_dark_color_emboss", title: "凹陷暗投影色", value: shadowDarkColorEmboss, dvalue: NeumorphicColors.embossMaxDarkColor.value);
    this.shadowLightColorEmboss = attributes.integer(
        name: "shadow_light_color_emboss", title: "凹陷亮投影色", value: shadowLightColorEmboss, dvalue: NeumorphicColors.embossMaxWhiteColor.value);
    this.borderWidth = attributes.float(name: "border_width", title: "边框宽度", value: borderWidth, dvalue: 0.3);
    this.borderColor = attributes.integer(name: "border_color", title: "边框颜色", value: borderColor, dvalue: NeumorphicColors.defaultBorder.value);
    this.defaultIconColor = attributes.integer(name: "default_icon_color", title: "默认图标颜色", value: defaultIconColor, dvalue: Colors.black.value);
    this.defaultTextColor = attributes.integer(name: "default_text_color", title: "默认文本颜色", value: defaultTextColor, dvalue: Colors.black.value);
    this.disabledColor = attributes.integer(name: "disabled_color", title: "默认禁用颜色", value: disabledColor, dvalue: NeumorphicColors.disabled.value);
    this.accentColor = attributes.integer(name: "accent_color", title: "默认强调颜色", value: accentColor, dvalue: NeumorphicColors.accent.value);
    this.intensity = attributes.float(name: "intensity", title: "色彩强度", value: intensity, dvalue: 0.7);
  }

  @override
  void fromMap(Map<String, Object?>? map) {
    if (null == map) return;
    for (Attribute attribute in attributes.attributeList) {
      attribute.valueTypeless = map[attribute.name];
    }
  }

  @override
  Map<String, Object?> toMap() {
    Map<String, Object?> map = {};
    for (Attribute attribute in attributes.attributeList) {
      map[attribute.name] = attribute.value;
    }
    return map;
  }

  @override
  ThemeData toThemeData({Brightness? brightness}) {
    return ThemeData(
      brightness: brightness,
      canvasColor: Colors.transparent,
      primaryColor: Color(baseColor.value),
      scaffoldBackgroundColor: Color(baseColor.value),
      // 输入框样式 虽然没用上，有备无患
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: Color(disabledColor.value)),
        border: InputBorder.none,
        contentPadding: const EdgeInsets.all(8),
      ),
      // 导航栏样式 虽然没用上，有备无患
      appBarTheme: AppBarTheme(
        color: Color(baseColor.value),
        actionsIconTheme: IconThemeData(color: Color(defaultIconColor.value), size: 18),
        centerTitle: true,
        titleTextStyle: TextStyle(color: Color(defaultTextColor.value)),
        elevation: 0,
      ),
      // 弹出菜单样式 虽然没用上，有备无患
      popupMenuTheme: PopupMenuThemeData(
        color: Color(baseColor.value),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
      ),
      // 帮助样式
      tooltipTheme: TooltipThemeData(
        textStyle: TextStyle(color: Color(defaultTextColor.value), overflow: TextOverflow.visible),
        padding: const EdgeInsets.all(4),
        margin: const EdgeInsets.only(top: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Color(borderColor.value)),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          color: Color(baseColor.value),
        ),
      ),
      // 文本选择样式
      textSelectionTheme: const TextSelectionThemeData(),
      // 文本样式
      textTheme: TextTheme(
        headline1: TextStyle(overflow: TextOverflow.ellipsis, color: Color(defaultTextColor.value)),
        headline2: TextStyle(overflow: TextOverflow.ellipsis, color: Color(defaultTextColor.value)),
        headline3: TextStyle(overflow: TextOverflow.ellipsis, color: Color(defaultTextColor.value)),
        headline4: TextStyle(overflow: TextOverflow.ellipsis, color: Color(defaultTextColor.value)),
        headline5: TextStyle(overflow: TextOverflow.ellipsis, color: Color(defaultTextColor.value)),
        headline6: TextStyle(overflow: TextOverflow.ellipsis, color: Color(defaultTextColor.value)),
        subtitle1: TextStyle(overflow: TextOverflow.ellipsis, color: Color(defaultTextColor.value)),
        subtitle2: TextStyle(overflow: TextOverflow.ellipsis, color: Color(defaultTextColor.value)),
        bodyText1: TextStyle(overflow: TextOverflow.ellipsis, color: Color(defaultTextColor.value)),
        // Text()默认颜色
        bodyText2: TextStyle(overflow: TextOverflow.ellipsis, color: Color(defaultTextColor.value)),
        caption: TextStyle(overflow: TextOverflow.ellipsis, color: Color(defaultTextColor.value)),
        button: TextStyle(overflow: TextOverflow.ellipsis, color: Color(defaultTextColor.value)),
        overline: TextStyle(overflow: TextOverflow.ellipsis, color: Color(defaultTextColor.value)),
      ),
    );
  }

  /// 转换为新拟态模版数据
  NeumorphicThemeData toNeumorphicThemeData() {
    return NeumorphicThemeData(
      // 基础色
      baseColor: Color(baseColor.value),
      // 阴影色色
      shadowLightColor: Color(shadowLightColor.value),
      shadowDarkColor: Color(shadowDarkColor.value),
      shadowLightColorEmboss: Color(shadowLightColorEmboss.value),
      shadowDarkColorEmboss: Color(shadowDarkColorEmboss.value),
      // 高度/深度
      depth: depth.value,
      // 边框
      borderWidth: borderWidth.value,
      borderColor: Color(borderColor.value),
      // 强度
      intensity: intensity.value,
      accentColor: Color(accentColor.value),
      // 默认颜色
      defaultTextColor: Color(defaultTextColor.value),
      disabledColor: Color(disabledColor.value),
      // 默认形状
      boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
      // 按钮样式
      buttonStyle: NeumorphicStyle(
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
        border: const NeumorphicBorder(),
        shape: NeumorphicShape.flat,
        depth: depth.value,
      ),
      // 标题样式
      iconTheme: IconThemeData(color: Color(defaultIconColor.value), size: 18),
      // 导航栏样式
      appBarTheme: NeumorphicAppBarThemeData(
        textStyle: TextStyle(color: Color(defaultTextColor.value)),
        buttonPadding: const EdgeInsets.all(8),
        buttonStyle: NeumorphicStyle(
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
          border: const NeumorphicBorder(),
          shape: NeumorphicShape.flat,
          depth: depth.value,
        ),
      ),
      // 文本样式
      textTheme: TextTheme(
        headline1: TextStyle(overflow: TextOverflow.ellipsis, color: Color(defaultTextColor.value)),
        headline2: TextStyle(overflow: TextOverflow.ellipsis, color: Color(defaultTextColor.value)),
        headline3: TextStyle(overflow: TextOverflow.ellipsis, color: Color(defaultTextColor.value)),
        headline4: TextStyle(overflow: TextOverflow.ellipsis, color: Color(defaultTextColor.value)),
        headline5: TextStyle(overflow: TextOverflow.ellipsis, color: Color(defaultTextColor.value)),
        headline6: TextStyle(overflow: TextOverflow.ellipsis, color: Color(defaultTextColor.value)),
        subtitle1: TextStyle(overflow: TextOverflow.ellipsis, color: Color(defaultTextColor.value)),
        subtitle2: TextStyle(overflow: TextOverflow.ellipsis, color: Color(defaultTextColor.value)),
        bodyText1: TextStyle(overflow: TextOverflow.ellipsis, color: Color(defaultTextColor.value)),
        // Text()默认颜色
        bodyText2: TextStyle(overflow: TextOverflow.ellipsis, color: Color(defaultTextColor.value)),
        caption: TextStyle(overflow: TextOverflow.ellipsis, color: Color(defaultTextColor.value)),
        button: TextStyle(overflow: TextOverflow.ellipsis, color: Color(defaultTextColor.value)),
        overline: TextStyle(overflow: TextOverflow.ellipsis, color: Color(defaultTextColor.value)),
      ),
    );
  }
}
