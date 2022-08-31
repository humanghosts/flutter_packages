import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:hg_entity/hg_entity.dart';
import 'package:hg_framework/hg_framework.dart';

class ThemeTemplate extends DataModel {
  // 基础设置
  late final Attribute<String?> name;
  late final Attribute<String?> fontFamily;

  // ===========================================================================
  // 全局设置.
  late final Attribute<ThemeModeValue> themeMode;
  late final Attribute<double?> defaultRadius;
  late final Attribute<ColorValue> primaryLight;
  late final Attribute<ColorValue> primaryContainerLight;
  late final Attribute<ColorValue> secondaryLight;
  late final Attribute<ColorValue> secondaryContainerLight;
  late final Attribute<ColorValue> tertiaryLight;
  late final Attribute<ColorValue> tertiaryContainerLight;
  late final Attribute<ColorValue> primaryDark;
  late final Attribute<ColorValue> primaryContainerDark;
  late final Attribute<ColorValue> secondaryDark;
  late final Attribute<ColorValue> secondaryContainerDark;
  late final Attribute<ColorValue> tertiaryDark;
  late final Attribute<ColorValue> tertiaryContainerDark;

  // ===========================================================================
  // 色彩方案设置
  // ===========================================================================
  late final Attribute<bool> useKeyColors;
  late final Attribute<bool> useSecondary;
  late final Attribute<bool> useTertiary;
  late final Attribute<bool> keepPrimary;
  late final Attribute<bool> keepSecondary;
  late final Attribute<bool> keepTertiary;
  late final Attribute<bool> keepPrimaryContainer;
  late final Attribute<bool> keepSecondaryContainer;
  late final Attribute<bool> keepTertiaryContainer;
  late final Attribute<bool> keepDarkPrimary;
  late final Attribute<bool> keepDarkSecondary;
  late final Attribute<bool> keepDarkTertiary;
  late final Attribute<bool> keepDarkPrimaryContainer;
  late final Attribute<bool> keepDarkSecondaryContainer;
  late final Attribute<bool> keepDarkTertiaryContainer;
  late final Attribute<int> usedFlexToneSetup;

  // ===========================================================================
  // 表面色彩混合设置
  // ===========================================================================
  late final Attribute<FlexSurfaceModeValue> surfaceModeLight;
  late final Attribute<FlexSurfaceModeValue> surfaceModeDark;
  late final Attribute<int> blendLevel;
  late final Attribute<int> blendLevelDark;
  late final Attribute<int> blendOnLevel;
  late final Attribute<int> blendOnLevelDark;
  late final Attribute<int> usedColors;
  late final Attribute<bool> lightIsWhite;
  late final Attribute<bool> darkIsTrueBlack;
  late final Attribute<bool> blendLightOnColors;
  late final Attribute<bool> blendDarkOnColors;
  late final Attribute<bool> blendLightTextTheme;
  late final Attribute<bool> blendDarkTextTheme;

  // ===========================================================================
  // 文本输入框设置
  // ===========================================================================
  late final Attribute<SchemeColorValue> inputDecoratorSchemeColorLight;
  late final Attribute<SchemeColorValue> inputDecoratorSchemeColorDark;
  late final Attribute<bool> inputDecoratorIsFilled;
  late final Attribute<FlexInputBorderTypeValue> inputDecoratorBorderType;
  late final Attribute<double?> inputDecoratorBorderRadius;
  late final Attribute<bool> inputDecoratorUnfocusedHasBorder;
  late final Attribute<bool> inputDecoratorUnfocusedBorderIsColored;

  // ===========================================================================
  // 应用栏设置
  // ===========================================================================
  late final Attribute<FlexAppBarStyleValue> appBarStyleLight;
  late final Attribute<FlexAppBarStyleValue> appBarStyleDark;
  late final Attribute<double> appBarOpacityLight;
  late final Attribute<double> appBarOpacityDark;
  late final Attribute<double> appBarElevationLight;
  late final Attribute<double> appBarElevationDark;
  late final Attribute<bool> transparentStatusBar;
  late final Attribute<SchemeColorValue> appBarBackgroundSchemeColorLight;
  late final Attribute<SchemeColorValue> appBarBackgroundSchemeColorDark;

  // ===========================================================================
  // 标签页栏设置
  // ===========================================================================
  late final Attribute<FlexTabBarStyleValue> tabBarStyle;
  late final Attribute<SchemeColorValue> tabBarIndicatorLight;
  late final Attribute<SchemeColorValue> tabBarIndicatorDark;
  late final Attribute<SchemeColorValue> tabBarItemSchemeColorLight;
  late final Attribute<SchemeColorValue> tabBarItemSchemeColorDark;

  // ===========================================================================
  // 底部弹框
  // ===========================================================================
  late final Attribute<double?> bottomSheetBorderRadius;

  // ===========================================================================
  // 安卓导航栏设置
  // ===========================================================================
  late final Attribute<FlexSystemNavBarStyleValue> sysNavBarStyle;
  late final Attribute<double> sysNavBarOpacity;
  late final Attribute<bool> useSysNavDivider;

  // ===========================================================================
  // 底部导航栏设置
  // ===========================================================================
  late final Attribute<SchemeColorValue> bottomNavBarBackgroundSchemeColor;
  late final Attribute<double> bottomNavigationBarOpacity;
  late final Attribute<double> bottomNavigationBarElevation;
  late final Attribute<SchemeColorValue> bottomNavBarSelectedSchemeColor;
  late final Attribute<SchemeColorValue> bottomNavBarUnselectedSchemeColor;
  late final Attribute<bool> bottomNavBarMuteUnselected;
  late final Attribute<bool> bottomNavShowSelectedLabels;
  late final Attribute<bool> bottomNavShowUnselectedLabels;

  // ===========================================================================
  // 导航栏设置
  // ===========================================================================
  late final Attribute<SchemeColorValue> navBarBackgroundSchemeColor;
  late final Attribute<double> navBarOpacity;
  late final Attribute<double?> navBarHeight;
  late final Attribute<SchemeColorValue> navBarSelectedSchemeColor;
  late final Attribute<SchemeColorValue> navBarUnselectedSchemeColor;
  late final Attribute<bool> navBarMuteUnselected;
  late final Attribute<SchemeColorValue> navBarIndicatorSchemeColor;
  late final Attribute<double?> navBarIndicatorOpacity;
  late final Attribute<NavigationDestinationLabelBehaviorValue> navBarLabelBehavior;

  // ===========================================================================
  // 侧导航栏设置
  // ===========================================================================
  late final Attribute<SchemeColorValue> navRailBackgroundSchemeColor;
  late final Attribute<double> navRailOpacity;
  late final Attribute<double> navigationRailElevation;
  late final Attribute<SchemeColorValue> navRailSelectedSchemeColor;
  late final Attribute<SchemeColorValue> navRailUnselectedSchemeColor;
  late final Attribute<bool> navRailMuteUnselected;
  late final Attribute<NavigationRailLabelTypeValue> navRailLabelType;
  late final Attribute<bool> navRailUseIndicator;
  late final Attribute<SchemeColorValue> navRailIndicatorSchemeColor;
  late final Attribute<double?> navRailIndicatorOpacity;

  // ===========================================================================
  // 按钮设置
  // ===========================================================================
  late final Attribute<SchemeColorValue> textButtonSchemeColor;
  late final Attribute<double?> textButtonBorderRadius;
  late final Attribute<SchemeColorValue> elevatedButtonSchemeColor;
  late final Attribute<double?> elevatedButtonBorderRadius;
  late final Attribute<SchemeColorValue> outlinedButtonSchemeColor;
  late final Attribute<double?> outlinedButtonBorderRadius;

  // ===========================================================================
  // 可切换组件设置
  // ===========================================================================
  late final Attribute<SchemeColorValue> toggleButtonsSchemeColor;
  late final Attribute<double?> toggleButtonsBorderRadius;
  late final Attribute<bool> unselectedToggleIsColored;
  late final Attribute<SchemeColorValue> switchSchemeColor;
  late final Attribute<SchemeColorValue> checkboxSchemeColor;
  late final Attribute<SchemeColorValue> radioSchemeColor;

  // ===========================================================================
  // 其他组件设置
  // ===========================================================================
  late final Attribute<double?> fabBorderRadius;
  late final Attribute<SchemeColorValue> fabSchemeColor;
  late final Attribute<SchemeColorValue> chipSchemeColor;
  late final Attribute<double?> chipBorderRadius;
  late final Attribute<SchemeColorValue> snackBarSchemeColor;
  late final Attribute<double> popupMenuOpacity;
  late final Attribute<double?> popupMenuBorderRadius;
  late final Attribute<double?> popupMenuElevation;
  late final Attribute<double?> cardBorderRadius;
  late final Attribute<double?> cardElevation;
  late final Attribute<SchemeColorValue> dialogBackgroundSchemeColor;
  late final Attribute<double?> dialogBorderRadius;
  late final Attribute<double?> dialogElevation;
  late final Attribute<bool> tooltipsMatchBackground;

  ThemeTemplate() {
    name = attributes.stringNullable(name: "name", title: "主题名称");
    fontFamily = attributes.stringNullable(name: "font_family", title: "字体");
    themeMode = attributes.custom(name: "theme_mode", title: "主题模式");
    defaultRadius = attributes.floatNullable(name: "default_radius", title: "默认圆角半径");

    primaryLight = attributes.custom(name: "primary_light", title: ColorType.primary.title, dvalue: ColorValue(color: const Color(0xFF004881)));
    primaryContainerLight =
        attributes.custom(name: "primary_container_light", title: ColorType.primaryContainer.title, dvalue: ColorValue(color: const Color(0xFFD0E4FF)));
    secondaryLight = attributes.custom(name: "secondary_light", title: ColorType.secondary.title, dvalue: ColorValue(color: const Color(0xFFAC3306)));
    secondaryContainerLight =
        attributes.custom(name: "secondary_container_light", title: ColorType.secondaryContainer.title, dvalue: ColorValue(color: const Color(0xFFFFDBCF)));
    tertiaryLight = attributes.custom(name: "tertiary_light", title: ColorType.tertiary.title, dvalue: ColorValue(color: const Color(0xFF006875)));
    tertiaryContainerLight =
        attributes.custom(name: "tertiary_container_light", title: ColorType.tertiaryContainer.title, dvalue: ColorValue(color: const Color(0xFF95F0FF)));
    primaryDark = attributes.custom(name: "primary_dark", title: "${ColorType.primary.title}(深色模式)", dvalue: ColorValue(color: const Color(0xFF9FC9FF)));
    primaryContainerDark = attributes.custom(
        name: "primary_container_dark", title: "${ColorType.primaryContainer.title}(深色模式)", dvalue: ColorValue(color: const Color(0xFF00325B)));
    secondaryDark = attributes.custom(name: "secondary_dark", title: "${ColorType.secondary.title}(深色模式)", dvalue: ColorValue(color: const Color(0xFFFFB59D)));
    secondaryContainerDark = attributes.custom(
        name: "secondary_container_dark", title: "${ColorType.secondaryContainer.title}(深色模式)", dvalue: ColorValue(color: const Color(0xFF872100)));
    tertiaryDark = attributes.custom(name: "tertiary_dark", title: "${ColorType.tertiary.title}(深色模式)", dvalue: ColorValue(color: const Color(0xFF872100)));
    tertiaryContainerDark = attributes.custom(
        name: "tertiary_container_dark", title: "${ColorType.tertiaryContainer.title}(深色模式)", dvalue: ColorValue(color: const Color(0xFF004E59)));

    surfaceModeLight = attributes.custom(name: "surface_mode_light", title: "前景模式");
    surfaceModeDark = attributes.custom(name: "surface_mode_dark", title: "前景模式(深色模式)");
    blendLevel = attributes.integer(name: "blend_level", title: "混合级别", dvalue: 20);
    blendLevelDark = attributes.integer(name: "blend_level_dark", title: "混合级别(深色模式)", dvalue: 15);
    blendOnLevel = attributes.integer(name: "blend_on_level", title: "表面混合水平", dvalue: 20);
    blendOnLevelDark = attributes.integer(name: "blend_on_level_dark", title: "表面混合水平(深色模式)", dvalue: 30);
    usedColors = attributes.integer(name: "used_colors", title: "输入的颜色数量", dvalue: 6);
    lightIsWhite = attributes.boolean(name: "light_is_white", title: "纯白(亮色模式)", dvalue: false);
    darkIsTrueBlack = attributes.boolean(name: "dark_is_true_black", title: "纯黑(深色模式)", dvalue: false);
    blendLightOnColors = attributes.boolean(name: "blend_light_on_colors", title: "混合表面色", dvalue: false);
    blendDarkOnColors = attributes.boolean(name: "blend_dark_on_colors", title: "混合表面色(深色模式)", dvalue: true);
    blendLightTextTheme = attributes.boolean(name: "blend_light_text_theme", title: "混合文本", dvalue: true);
    blendDarkTextTheme = attributes.boolean(name: "blend_dark_text_theme", title: "混合文本(深色模式)", dvalue: true);

    useKeyColors = attributes.boolean(name: "use_key_colors", title: "使用生成色彩", dvalue: false);
    useSecondary = attributes.boolean(name: "use_secondary", title: "使用${ColorType.secondary.title}", dvalue: false);
    useTertiary = attributes.boolean(name: "use_tertiary", title: "使用${ColorType.tertiary.title}", dvalue: false);
    keepPrimary = attributes.boolean(name: "keep_primary", title: "锁定${ColorType.primary.title}输入", dvalue: false);
    keepSecondary = attributes.boolean(name: "keep_secondary", title: "锁定${ColorType.secondary.title}输入", dvalue: false);
    keepTertiary = attributes.boolean(name: "keep_tertiary", title: "锁定${ColorType.tertiary.title}输入", dvalue: false);
    keepPrimaryContainer = attributes.boolean(name: "keep_primary_container", title: "锁定${ColorType.primaryContainer.title}", dvalue: false);
    keepSecondaryContainer = attributes.boolean(name: "keep_secondary_container", title: "锁定${ColorType.secondaryContainer.title}", dvalue: false);
    keepTertiaryContainer = attributes.boolean(name: "keep_tertiary_container", title: "锁定${ColorType.tertiaryContainer.title}", dvalue: false);
    keepDarkPrimary = attributes.boolean(name: "keep_dark_primary", title: "锁定${ColorType.primary.title}(深色模式)", dvalue: false);
    keepDarkSecondary = attributes.boolean(name: "keep_dark_secondary", title: "锁定${ColorType.secondary.title}(深色模式)", dvalue: false);
    keepDarkTertiary = attributes.boolean(name: "keep_dark_tertiary", title: "锁定${ColorType.tertiary.title}(深色模式)", dvalue: false);
    keepDarkPrimaryContainer = attributes.boolean(name: "keep_dark_primary_container", title: "锁定${ColorType.primaryContainer.title}(深色模式)", dvalue: false);
    keepDarkSecondaryContainer =
        attributes.boolean(name: "keep_dark_secondary_container", title: "锁定${ColorType.secondaryContainer.title}(深色模式)", dvalue: false);
    keepDarkTertiaryContainer = attributes.boolean(name: "keep_dark_tertiary_container", title: "锁定${ColorType.tertiaryContainer.title}(深色模式)", dvalue: false);
    usedFlexToneSetup = attributes.integer(name: "used_flex_tone_setup", title: "使用色调设置", dvalue: 1);

    inputDecoratorSchemeColorLight = attributes.custom(name: "input_decorator_scheme_color_light", title: "输入框主题");
    inputDecoratorSchemeColorDark = attributes.custom(name: "input_decorator_scheme_color_dark", title: "输入框主题(深色模式)");
    inputDecoratorIsFilled = attributes.boolean(name: "input_decorator_is_filled", title: "填充输入框", dvalue: true);
    inputDecoratorBorderType = attributes.custom(name: "input_decorator_border_type", title: "输入框边框类型");
    inputDecoratorBorderRadius = attributes.floatNullable(name: "input_decorator_border_radius", title: "输入框边框圆角半径");
    inputDecoratorUnfocusedHasBorder = attributes.boolean(name: "input_decorator_unfocused_has_border", title: "失焦输入框边框", dvalue: true);
    inputDecoratorUnfocusedBorderIsColored = attributes.boolean(name: "input_decorator_unfocused_border_is_colored", title: "失焦输入框颜色", dvalue: true);

    appBarStyleLight = attributes.custom(name: "app_bar_style_light", title: "应用栏样式");
    appBarStyleDark = attributes.custom(name: "app_bar_style_dark", title: "应用栏样式(深色模式)", dvalue: FlexAppBarStyleValue(style: FlexAppBarStyle.background));
    appBarOpacityLight = attributes.float(name: "app_bar_opacity_light", title: "应用栏不透明度", dvalue: 0.95);
    appBarOpacityDark = attributes.float(name: "app_bar_opacity_dark", title: "应用栏不透明度(深色模式)", dvalue: 0.9);
    appBarElevationLight = attributes.float(name: "app_bar_elevation_light", title: "应用栏海拔", dvalue: 0.0);
    appBarElevationDark = attributes.float(name: "app_bar_elevation_dark", title: "应用栏海拔(深色模式)", dvalue: 0.0);
    transparentStatusBar = attributes.boolean(name: "transparent_status_bar", title: "状态栏透明", dvalue: true);
    appBarBackgroundSchemeColorLight = attributes.custom(name: "app_bar_background_scheme_color_light", title: "应用栏背景色");
    appBarBackgroundSchemeColorDark = attributes.custom(name: "app_bar_background_scheme_color_dark", title: "应用栏背景色(深色模式)");

    tabBarStyle = attributes.custom(name: "tab_bar_style", title: "标签页栏样式");
    tabBarIndicatorLight = attributes.custom(name: "tab_bar_indicator_light", title: "标签页栏指示器");
    tabBarIndicatorDark = attributes.custom(name: "tab_bar_indicator_dark", title: "标签页栏指示器(深色模式)");
    tabBarItemSchemeColorLight = attributes.custom(name: "tab_bar_item_scheme_color_light", title: "标签页栏目");
    tabBarItemSchemeColorDark = attributes.custom(name: "tab_bar_item_scheme_color_dark", title: "标签页栏目(深色模式)");

    bottomSheetBorderRadius = attributes.floatNullable(name: "bottom_sheet_border_radius", title: "底部弹框边框圆角");
    sysNavBarStyle = attributes.custom(name: "sys_nav_bar_style", title: "系统导航栏样式");
    sysNavBarOpacity = attributes.float(name: "sys_nav_bar_opacity", title: "系统导航栏不透明度", dvalue: 1.0);
    useSysNavDivider = attributes.boolean(name: "use_sys_nav_divider", title: "系统导航栏分隔符", dvalue: false);

    bottomNavBarBackgroundSchemeColor = attributes.custom(name: "bottom_nav_bar_background_scheme_color", title: "底部导航栏背景色");
    bottomNavigationBarOpacity = attributes.float(name: "bottom_navigation_bar_opacity", title: "底部导航栏不透明度", dvalue: 1.0);
    bottomNavigationBarElevation = attributes.float(name: "bottom_navigation_bar_elevation", title: "底部导航栏海拔", dvalue: 0);
    bottomNavBarSelectedSchemeColor = attributes.custom(name: "bottom_nav_bar_selected_scheme_color", title: "底部导航栏选中颜色");
    bottomNavBarUnselectedSchemeColor = attributes.custom(name: "bottom_nav_bar_unselected_scheme_color", title: "底部导航栏未选中颜色");
    bottomNavBarMuteUnselected = attributes.boolean(name: "bottom_nav_bar_mute_unselected", title: "底部导航栏屏蔽未选中", dvalue: true);
    bottomNavShowSelectedLabels = attributes.boolean(name: "bottom_nav_show_selected_labels", title: "底部导航显示选中标签", dvalue: true);
    bottomNavShowUnselectedLabels = attributes.boolean(name: "bottom_nav_show_unselected_labels", title: "底部导航显示未选中标签", dvalue: true);

    navBarBackgroundSchemeColor = attributes.custom(name: "nav_bar_background_scheme_color", title: "导航栏背景色");
    navBarOpacity = attributes.float(name: "nav_bar_opacity", title: "导航栏不透明度", dvalue: 1.0);
    navBarHeight = attributes.floatNullable(name: "nav_bar_height", title: "导航栏海拔");
    navBarSelectedSchemeColor = attributes.custom(name: "nav_bar_selected_scheme_color", title: "导航栏选中颜色");
    navBarUnselectedSchemeColor = attributes.custom(name: "nav_bar_unselected_scheme_color", title: "导航栏未选中颜色");
    navBarMuteUnselected = attributes.boolean(name: "nav_bar_mute_unselected", title: "导航栏屏蔽未选中", dvalue: true);
    navBarIndicatorSchemeColor = attributes.custom(name: "nav_bar_indicator_scheme_color", title: "导航栏指示器颜色");
    navBarIndicatorOpacity = attributes.floatNullable(name: "nav_bar_indicator_opacity", title: "导航栏指示器不透明度");
    navBarLabelBehavior = attributes.custom(name: "nav_bar_label_behavior", title: "导航栏标签行为");

    navRailBackgroundSchemeColor = attributes.custom(name: "nav_rail_background_scheme_color", title: "侧导航栏背景色");
    navRailOpacity = attributes.float(name: "nav_rail_opacity", title: "侧导航栏不透明度", dvalue: 1.0);
    navigationRailElevation = attributes.float(name: "navigation_rail_elevation", title: "侧导航栏海拔", dvalue: 0);
    navRailSelectedSchemeColor = attributes.custom(name: "nav_rail_selected_scheme_color", title: "侧导航栏选中颜色");
    navRailUnselectedSchemeColor = attributes.custom(name: "nav_rail_unselected_scheme_color", title: "侧导航栏未选中颜色");
    navRailMuteUnselected = attributes.boolean(name: "nav_rail_mute_unselected", title: "侧导航栏屏蔽未选中", dvalue: true);
    navRailLabelType = attributes.custom(name: "nav_rail_label_type", title: "侧导航栏标签行为");
    navRailUseIndicator = attributes.boolean(name: "nav_rail_use_indicator", title: "侧导航栏指示器", dvalue: true);
    navRailIndicatorSchemeColor = attributes.custom(name: "nav_rail_indicator_scheme_color", title: "侧导航栏指示器颜色");
    navRailIndicatorOpacity = attributes.floatNullable(name: "nav_rail_indicator_opacity", title: "侧导航栏指示器不透明度");

    textButtonSchemeColor = attributes.custom(name: "text_button_scheme_color", title: "文本按钮颜色");
    textButtonBorderRadius = attributes.floatNullable(name: "text_button_border_radius", title: "文本按钮边框圆角半径");
    elevatedButtonSchemeColor = attributes.custom(name: "elevated_button_scheme_color", title: "浮动按钮颜色");
    elevatedButtonBorderRadius = attributes.floatNullable(name: "elevated_button_border_radius", title: "浮动按钮边框圆角半径");
    outlinedButtonSchemeColor = attributes.custom(name: "outlined_button_scheme_color", title: "轮廓按钮颜色");
    outlinedButtonBorderRadius = attributes.floatNullable(name: "outlined_button_border_radius", title: "轮廓按钮边框圆角半径");
    toggleButtonsSchemeColor = attributes.custom(name: "toggle_buttons_scheme_color", title: "可切换按钮颜色");
    toggleButtonsBorderRadius = attributes.floatNullable(name: "toggle_buttons_border_radius", title: "可切换按钮边框圆角半径");
    unselectedToggleIsColored = attributes.boolean(name: "unselected_toggle_is_colored", title: "可切换按钮未选中颜色", dvalue: false);
    switchSchemeColor = attributes.custom(name: "switch_scheme_color", title: "开关颜色");
    checkboxSchemeColor = attributes.custom(name: "checkbox_scheme_color", title: "复选框颜色");
    radioSchemeColor = attributes.custom(name: "radio_scheme_color", title: "单选框颜色");

    fabBorderRadius = attributes.floatNullable(name: "fab_border_radius", title: "浮动操作按钮边框圆角半径");
    fabSchemeColor = attributes.custom(name: "fab_scheme_color", title: "浮动操作按钮颜色");
    chipSchemeColor = attributes.custom(name: "chip_scheme_color", title: "标签颜色");
    chipBorderRadius = attributes.floatNullable(name: "chip_border_radius", title: "标签边框圆角半径");
    snackBarSchemeColor = attributes.custom(name: "snack_bar_scheme_color", title: "提示横幅颜色");
    popupMenuOpacity = attributes.float(name: "popup_menu_opacity", title: "弹出菜单不透明度", dvalue: 1.0);
    popupMenuBorderRadius = attributes.floatNullable(name: "popup_menu_border_radius", title: "弹出菜单边框圆角半径");
    popupMenuElevation = attributes.floatNullable(name: "popup menu elevation", title: "弹出菜单h海拔");
    cardBorderRadius = attributes.floatNullable(name: "card_border_radius", title: "卡片边框圆角半径");
    cardElevation = attributes.floatNullable(name: "card elevation", title: "卡片海拔");
    dialogBackgroundSchemeColor = attributes.custom(name: "dialog_background_scheme_color", title: "对话框背景色");
    dialogBorderRadius = attributes.floatNullable(name: "dialog_border_radius", title: "对话框边框圆角半径", dvalue: 0);
    dialogElevation = attributes.floatNullable(name: "dialog elevation", title: "对话框海拔", dvalue: 0);
    tooltipsMatchBackground = attributes.boolean(name: "tooltips_match_background", title: "提示匹配背景", dvalue: false);
  }

  @override
  String toString() {
    return name.value ?? "未命名";
  }

  /// 预制数据
  static List<ThemeTemplate> get initData {
    return [
      ThemeTemplate()
        ..id.value = "default"
        ..name.value = "默认模板",
      ThemeTemplate().withFlexScheme(FlexScheme.material)
        ..id.value = FlexScheme.material.name
        ..name.value = FlexScheme.material.title,
      ThemeTemplate().withFlexScheme(FlexScheme.materialHc)
        ..id.value = FlexScheme.materialHc.name
        ..name.value = FlexScheme.materialHc.title,
      ThemeTemplate().withFlexScheme(FlexScheme.blue)
        ..id.value = FlexScheme.blue.name
        ..name.value = FlexScheme.blue.title,
      ThemeTemplate().withFlexScheme(FlexScheme.indigo)
        ..id.value = FlexScheme.indigo.name
        ..name.value = FlexScheme.indigo.title,
      ThemeTemplate().withFlexScheme(FlexScheme.hippieBlue)
        ..id.value = FlexScheme.hippieBlue.name
        ..name.value = FlexScheme.hippieBlue.title,
      ThemeTemplate().withFlexScheme(FlexScheme.aquaBlue)
        ..id.value = FlexScheme.aquaBlue.name
        ..name.value = FlexScheme.aquaBlue.title,
      ThemeTemplate().withFlexScheme(FlexScheme.brandBlue)
        ..id.value = FlexScheme.brandBlue.name
        ..name.value = FlexScheme.brandBlue.title,
      ThemeTemplate().withFlexScheme(FlexScheme.deepBlue)
        ..id.value = FlexScheme.deepBlue.name
        ..name.value = FlexScheme.deepBlue.title,
      ThemeTemplate().withFlexScheme(FlexScheme.sakura)
        ..id.value = FlexScheme.sakura.name
        ..name.value = FlexScheme.sakura.title,
      ThemeTemplate().withFlexScheme(FlexScheme.mandyRed)
        ..id.value = FlexScheme.mandyRed.name
        ..name.value = FlexScheme.mandyRed.title,
      ThemeTemplate().withFlexScheme(FlexScheme.red)
        ..id.value = FlexScheme.red.name
        ..name.value = FlexScheme.red.title,
      ThemeTemplate().withFlexScheme(FlexScheme.redWine)
        ..id.value = FlexScheme.redWine.name
        ..name.value = FlexScheme.redWine.title,
      ThemeTemplate().withFlexScheme(FlexScheme.purpleBrown)
        ..id.value = FlexScheme.purpleBrown.name
        ..name.value = FlexScheme.purpleBrown.title,
      ThemeTemplate().withFlexScheme(FlexScheme.green)
        ..id.value = FlexScheme.green.name
        ..name.value = FlexScheme.green.title,
      ThemeTemplate().withFlexScheme(FlexScheme.money)
        ..id.value = FlexScheme.money.name
        ..name.value = FlexScheme.money.title,
      ThemeTemplate().withFlexScheme(FlexScheme.jungle)
        ..id.value = FlexScheme.jungle.name
        ..name.value = FlexScheme.jungle.title,
      ThemeTemplate().withFlexScheme(FlexScheme.greyLaw)
        ..id.value = FlexScheme.greyLaw.name
        ..name.value = FlexScheme.greyLaw.title,
      ThemeTemplate().withFlexScheme(FlexScheme.wasabi)
        ..id.value = FlexScheme.wasabi.name
        ..name.value = FlexScheme.wasabi.title,
      ThemeTemplate().withFlexScheme(FlexScheme.gold)
        ..id.value = FlexScheme.gold.name
        ..name.value = FlexScheme.gold.title,
      ThemeTemplate().withFlexScheme(FlexScheme.mango)
        ..id.value = FlexScheme.mango.name
        ..name.value = FlexScheme.mango.title,
      ThemeTemplate().withFlexScheme(FlexScheme.amber)
        ..id.value = FlexScheme.amber.name
        ..name.value = FlexScheme.amber.title,
      ThemeTemplate().withFlexScheme(FlexScheme.vesuviusBurn)
        ..id.value = FlexScheme.vesuviusBurn.name
        ..name.value = FlexScheme.vesuviusBurn.title,
      ThemeTemplate().withFlexScheme(FlexScheme.deepPurple)
        ..id.value = FlexScheme.deepPurple.name
        ..name.value = FlexScheme.deepPurple.title,
      ThemeTemplate().withFlexScheme(FlexScheme.ebonyClay)
        ..id.value = FlexScheme.ebonyClay.name
        ..name.value = FlexScheme.ebonyClay.title,
      ThemeTemplate().withFlexScheme(FlexScheme.barossa)
        ..id.value = FlexScheme.barossa.name
        ..name.value = FlexScheme.barossa.title,
      ThemeTemplate().withFlexScheme(FlexScheme.shark)
        ..id.value = FlexScheme.shark.name
        ..name.value = FlexScheme.shark.title,
      ThemeTemplate().withFlexScheme(FlexScheme.bigStone)
        ..id.value = FlexScheme.bigStone.name
        ..name.value = FlexScheme.bigStone.title,
      ThemeTemplate().withFlexScheme(FlexScheme.damask)
        ..id.value = FlexScheme.damask.name
        ..name.value = FlexScheme.damask.title,
      ThemeTemplate().withFlexScheme(FlexScheme.bahamaBlue)
        ..id.value = FlexScheme.bahamaBlue.name
        ..name.value = FlexScheme.bahamaBlue.title,
      ThemeTemplate().withFlexScheme(FlexScheme.mallardGreen)
        ..id.value = FlexScheme.mallardGreen.name
        ..name.value = FlexScheme.mallardGreen.title,
      ThemeTemplate().withFlexScheme(FlexScheme.espresso)
        ..id.value = FlexScheme.espresso.name
        ..name.value = FlexScheme.espresso.title,
      ThemeTemplate().withFlexScheme(FlexScheme.outerSpace)
        ..id.value = FlexScheme.outerSpace.name
        ..name.value = FlexScheme.outerSpace.title,
      ThemeTemplate().withFlexScheme(FlexScheme.blueWhale)
        ..id.value = FlexScheme.blueWhale.name
        ..name.value = FlexScheme.blueWhale.title,
      ThemeTemplate().withFlexScheme(FlexScheme.sanJuanBlue)
        ..id.value = FlexScheme.sanJuanBlue.name
        ..name.value = FlexScheme.sanJuanBlue.title,
      ThemeTemplate().withFlexScheme(FlexScheme.rosewood)
        ..id.value = FlexScheme.rosewood.name
        ..name.value = FlexScheme.rosewood.title,
      ThemeTemplate().withFlexScheme(FlexScheme.blumineBlue)
        ..id.value = FlexScheme.blumineBlue.name
        ..name.value = FlexScheme.blumineBlue.title,
      ThemeTemplate().withFlexScheme(FlexScheme.flutterDash)
        ..id.value = FlexScheme.flutterDash.name
        ..name.value = FlexScheme.flutterDash.title,
      ThemeTemplate().withFlexScheme(FlexScheme.materialBaseline)
        ..id.value = FlexScheme.materialBaseline.name
        ..name.value = FlexScheme.materialBaseline.title,
      ThemeTemplate().withFlexScheme(FlexScheme.verdunHemlock)
        ..id.value = FlexScheme.verdunHemlock.name
        ..name.value = FlexScheme.verdunHemlock.title,
      ThemeTemplate().withFlexScheme(FlexScheme.dellGenoa)
        ..id.value = FlexScheme.dellGenoa.name
        ..name.value = FlexScheme.dellGenoa.title,
    ];
  }
}

extension FlexColorSchemeConvert on ThemeTemplate {
  /// 使用FlexScheme来覆盖ThemeTemplate的设置
  ThemeTemplate withFlexScheme(FlexScheme flexScheme) {
    FlexSchemeData? flexSchemeData = FlexColor.schemes[flexScheme];
    if (null == flexSchemeData) return this;
    FlexSchemeColor light = flexSchemeData.light;
    FlexSchemeColor dark = flexSchemeData.dark;
    primaryLight.value.color = light.primary;
    primaryContainerLight.value.color = light.primaryContainer;
    secondaryLight.value.color = light.secondary;
    secondaryContainerLight.value.color = light.secondaryContainer;
    tertiaryLight.value.color = light.tertiary;
    tertiaryContainerLight.value.color = light.tertiaryContainer;

    primaryDark.value.color = dark.primary;
    primaryContainerDark.value.color = dark.primaryContainer;
    secondaryDark.value.color = dark.secondary;
    secondaryContainerDark.value.color = dark.secondaryContainer;
    tertiaryDark.value.color = dark.tertiary;
    tertiaryContainerDark.value.color = dark.tertiaryContainer;
    return this;
  }

  FlexSchemeColor toFlexSchemeColorLight() {
    return FlexSchemeColor(
      primary: primaryLight.value.color,
      primaryContainer: primaryContainerLight.value.color,
      secondary: secondaryLight.value.color,
      secondaryContainer: secondaryContainerLight.value.color,
      tertiary: tertiaryLight.value.color,
      tertiaryContainer: tertiaryContainerLight.value.color,
    );
  }

  FlexSchemeColor toFlexSchemeColorDark() {
    return FlexSchemeColor(
      primary: primaryDark.value.color,
      primaryContainer: primaryContainerDark.value.color,
      secondary: secondaryDark.value.color,
      secondaryContainer: secondaryContainerDark.value.color,
      tertiary: tertiaryDark.value.color,
      tertiaryContainer: tertiaryContainerDark.value.color,
    );
  }

  FlexSchemeColor toFlexSchemeColor({Brightness? brightness}) {
    return (brightness ?? AppLogic.instance.brightness) == Brightness.light ? toFlexSchemeColorLight() : toFlexSchemeColorDark();
  }

  FlexColorScheme toFlexColorTheme({Brightness? brightness}) {
    return (brightness ?? AppLogic.instance.brightness) == Brightness.light ? toFlexColorThemeLight() : toFlexColorThemeDark();
  }

  FlexColorScheme toFlexColorThemeLight() {
    return FlexColorScheme.light(
      usedColors: usedColors.value,
      surfaceMode: surfaceModeLight.value.mode,
      blendLevel: blendLevel.value,
      appBarStyle: appBarStyleLight.value.style,
      appBarOpacity: appBarOpacityLight.value,
      transparentStatusBar: transparentStatusBar.value,
      appBarElevation: appBarElevationLight.value,
      tabBarStyle: tabBarStyle.value.style,
      lightIsWhite: lightIsWhite.value,
      swapColors: false,
      tooltipsMatchBackground: tooltipsMatchBackground.value,
      subThemesData: FlexSubThemesData(
        interactionEffects: true,
        blendOnLevel: blendOnLevel.value,
        blendOnColors: blendLightOnColors.value,
        blendTextTheme: blendLightTextTheme.value,
        useTextTheme: true,
        useFlutterDefaults: false,
        defaultRadius: defaultRadius.value,
        bottomSheetRadius: bottomSheetBorderRadius.value,
        elevatedButtonRadius: elevatedButtonBorderRadius.value,
        outlinedButtonRadius: outlinedButtonBorderRadius.value,
        textButtonRadius: textButtonBorderRadius.value,
        toggleButtonsRadius: toggleButtonsBorderRadius.value,
        textButtonSchemeColor: textButtonSchemeColor.value.scheme,
        elevatedButtonSchemeColor: elevatedButtonSchemeColor.value.scheme,
        outlinedButtonSchemeColor: outlinedButtonSchemeColor.value.scheme,
        toggleButtonsSchemeColor: toggleButtonsSchemeColor.value.scheme,
        switchSchemeColor: switchSchemeColor.value.scheme,
        checkboxSchemeColor: checkboxSchemeColor.value.scheme,
        radioSchemeColor: radioSchemeColor.value.scheme,
        unselectedToggleIsColored: unselectedToggleIsColored.value,
        inputDecoratorSchemeColor: inputDecoratorSchemeColorLight.value.scheme,
        inputDecoratorIsFilled: inputDecoratorIsFilled.value,
        inputDecoratorBorderType: inputDecoratorBorderType.value.type,
        inputDecoratorRadius: inputDecoratorBorderRadius.value ?? 20,
        inputDecoratorUnfocusedHasBorder: inputDecoratorUnfocusedHasBorder.value,
        inputDecoratorUnfocusedBorderIsColored: inputDecoratorUnfocusedBorderIsColored.value,
        fabUseShape: true,
        fabRadius: fabBorderRadius.value,
        fabSchemeColor: fabSchemeColor.value.scheme,
        snackBarBackgroundSchemeColor: snackBarSchemeColor.value.scheme,
        chipSchemeColor: chipSchemeColor.value.scheme,
        chipRadius: chipBorderRadius.value,
        cardRadius: cardBorderRadius.value,
        cardElevation: cardElevation.value ?? 0,
        popupMenuOpacity: popupMenuOpacity.value,
        popupMenuRadius: popupMenuBorderRadius.value,
        popupMenuElevation: popupMenuElevation.value ?? 0,
        dialogBackgroundSchemeColor: dialogBackgroundSchemeColor.value.scheme,
        dialogRadius: dialogBorderRadius.value,
        dialogElevation: dialogElevation.value ?? 0,
        timePickerDialogRadius: dialogBorderRadius.value,
        appBarBackgroundSchemeColor: appBarBackgroundSchemeColorLight.value.scheme,
        tabBarItemSchemeColor: tabBarItemSchemeColorLight.value.scheme,
        tabBarIndicatorSchemeColor: tabBarIndicatorLight.value.scheme,
        // BottomNavigationBar settings
        bottomNavigationBarSelectedLabelSchemeColor: bottomNavBarSelectedSchemeColor.value.scheme,
        bottomNavigationBarUnselectedLabelSchemeColor: bottomNavBarUnselectedSchemeColor.value.scheme,
        bottomNavigationBarMutedUnselectedLabel: bottomNavBarMuteUnselected.value,
        bottomNavigationBarSelectedIconSchemeColor: bottomNavBarSelectedSchemeColor.value.scheme,
        bottomNavigationBarUnselectedIconSchemeColor: bottomNavBarUnselectedSchemeColor.value.scheme,
        bottomNavigationBarMutedUnselectedIcon: bottomNavBarMuteUnselected.value,
        bottomNavigationBarBackgroundSchemeColor: bottomNavBarBackgroundSchemeColor.value.scheme,
        bottomNavigationBarOpacity: bottomNavigationBarOpacity.value,
        bottomNavigationBarElevation: bottomNavigationBarElevation.value,
        bottomNavigationBarShowSelectedLabels: bottomNavShowSelectedLabels.value,
        bottomNavigationBarShowUnselectedLabels: bottomNavShowUnselectedLabels.value,
        // NavigationBar settings
        navigationBarSelectedLabelSchemeColor: navBarSelectedSchemeColor.value.scheme,
        navigationBarUnselectedLabelSchemeColor: navBarUnselectedSchemeColor.value.scheme,
        navigationBarMutedUnselectedLabel: navBarMuteUnselected.value,
        navigationBarSelectedIconSchemeColor: navBarSelectedSchemeColor.value.scheme,
        navigationBarUnselectedIconSchemeColor: navBarUnselectedSchemeColor.value.scheme,
        navigationBarMutedUnselectedIcon: navBarMuteUnselected.value,
        navigationBarIndicatorSchemeColor: navBarIndicatorSchemeColor.value.scheme,
        navigationBarIndicatorOpacity: navBarIndicatorOpacity.value,
        navigationBarBackgroundSchemeColor: navBarBackgroundSchemeColor.value.scheme,
        navigationBarOpacity: navBarOpacity.value,
        navigationBarHeight: navBarHeight.value,
        navigationBarLabelBehavior: navBarLabelBehavior.value.behavior,
        // NavigationRail settings
        navigationRailSelectedLabelSchemeColor: navRailSelectedSchemeColor.value.scheme,
        navigationRailUnselectedLabelSchemeColor: navRailUnselectedSchemeColor.value.scheme,
        navigationRailMutedUnselectedLabel: navRailMuteUnselected.value,
        navigationRailSelectedIconSchemeColor: navRailSelectedSchemeColor.value.scheme,
        navigationRailUnselectedIconSchemeColor: navRailUnselectedSchemeColor.value.scheme,
        navigationRailMutedUnselectedIcon: navRailMuteUnselected.value,
        navigationRailUseIndicator: navRailUseIndicator.value,
        navigationRailIndicatorSchemeColor: navRailIndicatorSchemeColor.value.scheme,
        navigationRailIndicatorOpacity: navRailIndicatorOpacity.value,
        navigationRailBackgroundSchemeColor: navRailBackgroundSchemeColor.value.scheme,
        navigationRailOpacity: navRailOpacity.value,
        navigationRailElevation: navigationRailElevation.value,
        navigationRailLabelType: navRailLabelType.value.type,
      ),
      keyColors: FlexKeyColors(
        useKeyColors: useKeyColors.value,
        useSecondary: useSecondary.value,
        useTertiary: useTertiary.value,
        keepPrimary: keepPrimary.value,
        keepSecondary: keepSecondary.value,
        keepTertiary: keepTertiary.value,
        keepPrimaryContainer: keepPrimaryContainer.value,
        keepSecondaryContainer: keepSecondaryContainer.value,
        keepTertiaryContainer: keepTertiaryContainer.value,
      ),
      useMaterial3ErrorColors: true,
      tones: flexTonesConfig(Brightness.light, usedFlexToneSetup.value),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      fontFamily: fontFamily.value,
      platform: DeviceInfoHelper.targetPlatform,
      useMaterial3: true,
      primary: primaryLight.value.color,
      primaryContainer: primaryContainerLight.value.color,
      secondary: secondaryLight.value.color,
      secondaryContainer: secondaryContainerLight.value.color,
      tertiary: tertiaryLight.value.color,
      tertiaryContainer: tertiaryContainerLight.value.color,
    );
  }

  FlexColorScheme toFlexColorThemeDark() {
    return FlexColorScheme.dark(
      usedColors: usedColors.value,
      surfaceMode: surfaceModeDark.value.mode,
      blendLevel: blendLevelDark.value,
      appBarStyle: appBarStyleDark.value.style,
      appBarOpacity: appBarOpacityDark.value,
      transparentStatusBar: transparentStatusBar.value,
      appBarElevation: appBarElevationDark.value,
      tabBarStyle: tabBarStyle.value.style,
      darkIsTrueBlack: darkIsTrueBlack.value,
      tooltipsMatchBackground: tooltipsMatchBackground.value,
      //
      subThemesData: FlexSubThemesData(
        interactionEffects: true,
        blendOnLevel: blendOnLevelDark.value,
        blendOnColors: blendDarkOnColors.value,
        blendTextTheme: blendDarkTextTheme.value,
        useFlutterDefaults: false,
        useTextTheme: true,
        //
        defaultRadius: defaultRadius.value,
        bottomSheetRadius: bottomSheetBorderRadius.value,
        textButtonRadius: textButtonBorderRadius.value,
        elevatedButtonRadius: elevatedButtonBorderRadius.value,
        outlinedButtonRadius: outlinedButtonBorderRadius.value,
        toggleButtonsRadius: toggleButtonsBorderRadius.value,
        //
        textButtonSchemeColor: textButtonSchemeColor.value.scheme,
        elevatedButtonSchemeColor: elevatedButtonSchemeColor.value.scheme,
        outlinedButtonSchemeColor: outlinedButtonSchemeColor.value.scheme,
        toggleButtonsSchemeColor: toggleButtonsSchemeColor.value.scheme,
        switchSchemeColor: switchSchemeColor.value.scheme,
        checkboxSchemeColor: checkboxSchemeColor.value.scheme,
        radioSchemeColor: radioSchemeColor.value.scheme,
        unselectedToggleIsColored: unselectedToggleIsColored.value,
        //
        inputDecoratorSchemeColor: inputDecoratorSchemeColorDark.value.scheme,
        inputDecoratorIsFilled: inputDecoratorIsFilled.value,
        inputDecoratorBorderType: inputDecoratorBorderType.value.type,
        inputDecoratorRadius: inputDecoratorBorderRadius.value ?? 20,
        inputDecoratorUnfocusedHasBorder: inputDecoratorUnfocusedHasBorder.value,
        inputDecoratorUnfocusedBorderIsColored: inputDecoratorUnfocusedBorderIsColored.value,
        //
        fabUseShape: true,
        fabRadius: fabBorderRadius.value,
        fabSchemeColor: fabSchemeColor.value.scheme,
        snackBarBackgroundSchemeColor: snackBarSchemeColor.value.scheme,
        chipSchemeColor: chipSchemeColor.value.scheme,
        chipRadius: chipBorderRadius.value,
        cardRadius: cardBorderRadius.value,
        popupMenuOpacity: popupMenuOpacity.value,
        popupMenuRadius: popupMenuBorderRadius.value,
        //
        dialogBackgroundSchemeColor: dialogBackgroundSchemeColor.value.scheme,
        dialogRadius: dialogBorderRadius.value,
        timePickerDialogRadius: dialogBorderRadius.value,
        appBarBackgroundSchemeColor: appBarBackgroundSchemeColorDark.value.scheme,
        tabBarItemSchemeColor: tabBarItemSchemeColorDark.value.scheme,
        tabBarIndicatorSchemeColor: tabBarIndicatorDark.value.scheme,
        // BottomNavigationBar settings
        bottomNavigationBarSelectedLabelSchemeColor: bottomNavBarSelectedSchemeColor.value.scheme,
        bottomNavigationBarUnselectedLabelSchemeColor: bottomNavBarUnselectedSchemeColor.value.scheme,
        bottomNavigationBarMutedUnselectedLabel: bottomNavBarMuteUnselected.value,
        bottomNavigationBarSelectedIconSchemeColor: bottomNavBarSelectedSchemeColor.value.scheme,
        bottomNavigationBarUnselectedIconSchemeColor: bottomNavBarUnselectedSchemeColor.value.scheme,
        bottomNavigationBarMutedUnselectedIcon: bottomNavBarMuteUnselected.value,
        bottomNavigationBarBackgroundSchemeColor: bottomNavBarBackgroundSchemeColor.value.scheme,
        bottomNavigationBarOpacity: bottomNavigationBarOpacity.value,
        bottomNavigationBarElevation: bottomNavigationBarElevation.value,
        bottomNavigationBarShowSelectedLabels: bottomNavShowSelectedLabels.value,
        bottomNavigationBarShowUnselectedLabels: bottomNavShowUnselectedLabels.value,
        // NavigationBar settings
        navigationBarSelectedLabelSchemeColor: navBarSelectedSchemeColor.value.scheme,
        navigationBarUnselectedLabelSchemeColor: navBarUnselectedSchemeColor.value.scheme,
        navigationBarMutedUnselectedLabel: navBarMuteUnselected.value,
        navigationBarSelectedIconSchemeColor: navBarSelectedSchemeColor.value.scheme,
        navigationBarUnselectedIconSchemeColor: navBarUnselectedSchemeColor.value.scheme,
        navigationBarMutedUnselectedIcon: navBarMuteUnselected.value,
        navigationBarIndicatorSchemeColor: navBarIndicatorSchemeColor.value.scheme,
        navigationBarIndicatorOpacity: navBarIndicatorOpacity.value,
        navigationBarBackgroundSchemeColor: navBarBackgroundSchemeColor.value.scheme,
        navigationBarOpacity: navBarOpacity.value,
        navigationBarHeight: navBarHeight.value,
        navigationBarLabelBehavior: navBarLabelBehavior.value.behavior,
        // NavigationRail settings
        navigationRailSelectedLabelSchemeColor: navRailSelectedSchemeColor.value.scheme,
        navigationRailUnselectedLabelSchemeColor: navRailUnselectedSchemeColor.value.scheme,
        navigationRailMutedUnselectedLabel: navRailMuteUnselected.value,
        navigationRailSelectedIconSchemeColor: navRailSelectedSchemeColor.value.scheme,
        navigationRailUnselectedIconSchemeColor: navRailUnselectedSchemeColor.value.scheme,
        navigationRailMutedUnselectedIcon: navRailMuteUnselected.value,
        navigationRailUseIndicator: navRailUseIndicator.value,
        navigationRailIndicatorSchemeColor: navRailIndicatorSchemeColor.value.scheme,
        navigationRailIndicatorOpacity: navRailIndicatorOpacity.value,
        navigationRailBackgroundSchemeColor: navRailBackgroundSchemeColor.value.scheme,
        navigationRailOpacity: navRailOpacity.value,
        navigationRailElevation: navigationRailElevation.value,
        navigationRailLabelType: navRailLabelType.value.type,
      ),
      //
      // Advanced color properties for seed generated ColorScheme's
      // Use key color based M3 ColorScheme.
      keyColors: FlexKeyColors(
        useKeyColors: useKeyColors.value,
        useSecondary: useSecondary.value,
        useTertiary: useTertiary.value,
        keepPrimary: keepDarkPrimary.value,
        keepSecondary: keepDarkSecondary.value,
        keepTertiary: keepDarkTertiary.value,
        keepPrimaryContainer: keepDarkPrimaryContainer.value,
        keepSecondaryContainer: keepDarkSecondaryContainer.value,
        keepTertiaryContainer: keepDarkTertiaryContainer.value,
      ),
      useMaterial3ErrorColors: true,
      tones: flexTonesConfig(Brightness.dark, usedFlexToneSetup.value),
      //
      // ThemeData properties passed along directly to ThemeData.
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      fontFamily: fontFamily.value,
      platform: DeviceInfoHelper.targetPlatform,
      useMaterial3: true,
      primary: primaryDark.value.color,
      primaryContainer: primaryContainerDark.value.color,
      secondary: secondaryDark.value.color,
      secondaryContainer: secondaryContainerDark.value.color,
      tertiary: tertiaryDark.value.color,
      tertiaryContainer: tertiaryContainerDark.value.color,
    );
  }

  /// Return [FlexTones] based on passed in [brightness] and [tones] value.
  FlexTones flexTonesConfig(Brightness brightness, int tones) {
    if (tones == 2) {
      return FlexTones.soft(brightness);
    } else if (tones == 3) {
      return FlexTones.vivid(brightness);
    } else if (tones == 4) {
      return FlexTones.vividSurfaces(brightness);
    } else if (tones == 5) {
      return FlexTones.highContrast(brightness);
    } else {
      return FlexTones.material(brightness);
    }
  }
}
