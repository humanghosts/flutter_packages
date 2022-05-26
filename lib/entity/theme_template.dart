import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hg_entity/hg_entity.dart';

import '../app/app_logic.dart';
import 'theme_custom_value.dart';

class ThemeTemplate extends DataModel {
  /// 模板名称
  late final Attribute<String?> name;
  late final Attribute<String?> fontFamily;

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

  // 表面色彩混合设置
  // ===========================================================================
  late final Attribute<FlexSurfaceModeValue> surfaceModeLight;
  late final Attribute<FlexSurfaceModeValue> surfaceModeDark;
  late final Attribute<int> blendLevel;
  late final Attribute<int> blendLevelDark;
  late final Attribute<int> blendOnLevel;
  late final Attribute<int> blendOnLevelDark;
  late final Attribute<int> usedColors;
  late final Attribute<bool> swapLightColors;
  late final Attribute<bool> swapDarkColors;
  late final Attribute<bool> lightIsWhite;
  late final Attribute<bool> darkIsTrueBlack;

  // On color blending ON/OFF
  late final Attribute<bool> blendLightOnColors;
  late final Attribute<bool> blendDarkOnColors;
  late final Attribute<bool> blendLightTextTheme;
  late final Attribute<bool> blendDarkTextTheme;

  // InputDecorator SETTINGS.
  // ===========================================================================
  late final Attribute<SchemeColorValue> inputDecoratorSchemeColorLight;
  late final Attribute<SchemeColorValue> inputDecoratorSchemeColorDark;
  late final Attribute<bool> inputDecoratorIsFilled;
  late final Attribute<FlexInputBorderTypeValue> inputDecoratorBorderType;
  late final Attribute<double?> inputDecoratorBorderRadius;
  late final Attribute<bool> inputDecoratorUnfocusedHasBorder;
  late final Attribute<bool> inputDecoratorUnfocusedBorderIsColored;

  // AppBar SETTINGS.
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

  // TabBar SETTINGS.
  // ===========================================================================
  late final Attribute<FlexTabBarStyleValue> tabBarStyle;
  late final Attribute<SchemeColorValue> tabBarIndicatorLight;
  late final Attribute<SchemeColorValue> tabBarIndicatorDark;
  late final Attribute<SchemeColorValue> tabBarItemSchemeColorLight;
  late final Attribute<SchemeColorValue> tabBarItemSchemeColorDark;

  // BottomSheet SETTINGS.
  // ===========================================================================
  late final Attribute<double?> bottomSheetBorderRadius;

  // Android System Navigator bar SETTINGS.
  // ===========================================================================
  late final Attribute<FlexSystemNavBarStyleValue> sysNavBarStyle;
  late final Attribute<double> sysNavBarOpacity;
  late final Attribute<bool> useSysNavDivider;

  // BottomNavigationBar SETTINGS.
  // ===========================================================================
  late final Attribute<SchemeColorValue> bottomNavBarBackgroundSchemeColor;
  late final Attribute<double> bottomNavigationBarOpacity;
  late final Attribute<double> bottomNavigationBarElevation;
  late final Attribute<SchemeColorValue> bottomNavBarSelectedSchemeColor;
  late final Attribute<SchemeColorValue> bottomNavBarUnselectedSchemeColor;
  late final Attribute<bool> bottomNavBarMuteUnselected;
  late final Attribute<bool> bottomNavShowSelectedLabels;
  late final Attribute<bool> bottomNavShowUnselectedLabels;

  // NavigationBar SETTINGS.
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

  // NavigationRail SETTINGS.
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

  // Button SETTINGS.
  // ===========================================================================
  late final Attribute<SchemeColorValue> textButtonSchemeColor;
  late final Attribute<double?> textButtonBorderRadius;
  late final Attribute<SchemeColorValue> elevatedButtonSchemeColor;
  late final Attribute<double?> elevatedButtonBorderRadius;
  late final Attribute<SchemeColorValue> outlinedButtonSchemeColor;
  late final Attribute<double?> outlinedButtonBorderRadius;

  // Toggleable SETTINGS.
  // ===========================================================================
  late final Attribute<SchemeColorValue> toggleButtonsSchemeColor;
  late final Attribute<double?> toggleButtonsBorderRadius;
  late final Attribute<bool> unselectedToggleIsColored;
  late final Attribute<SchemeColorValue> switchSchemeColor;
  late final Attribute<SchemeColorValue> checkboxSchemeColor;
  late final Attribute<SchemeColorValue> radioSchemeColor;

  // Fab, Chip, SnackBar, Popup, Card nad Dialog SETTINGS.
  // ===========================================================================
  late final Attribute<double?> fabBorderRadius;
  late final Attribute<SchemeColorValue> fabSchemeColor;
  late final Attribute<SchemeColorValue> chipSchemeColor;
  late final Attribute<double?> chipBorderRadius;
  late final Attribute<SchemeColorValue> snackBarSchemeColor;
  late final Attribute<double> popupMenuOpacity;
  late final Attribute<double?> popupMenuBorderRadius;
  late final Attribute<double?> cardBorderRadius;
  late final Attribute<SchemeColorValue> dialogBackgroundSchemeColor;
  late final Attribute<double?> dialogBorderRadius;
  late final Attribute<bool> tooltipsMatchBackground;

  ThemeTemplate() {
    name = attributes.stringNullable(name: "name", title: "名称");
    fontFamily = attributes.stringNullable(name: "fontFamily", title: "字体");
    themeMode = attributes.custom(name: "themeMode", title: "主题模式");
    defaultRadius = attributes.floatNullable(name: "defaultRadius", title: "默认半径");

    surfaceModeLight = attributes.custom(name: "surfaceModeLight", title: "表面模式光");
    surfaceModeDark = attributes.custom(name: "surfaceModeDark", title: "表面模式暗");
    blendLevel = attributes.integer(name: "blendLevel", title: "混合级别", dvalue: 20);
    blendLevelDark = attributes.integer(name: "blendLevelDark", title: "混合水平黑暗", dvalue: 15);
    blendOnLevel = attributes.integer(name: "blendOnLevel", title: "混合水平", dvalue: 20);
    blendOnLevelDark = attributes.integer(name: "blendOnLevelDark", title: "混合水平黑暗", dvalue: 30);
    usedColors = attributes.integer(name: "usedColors", title: "输入的颜色数量", dvalue: 6);
    swapLightColors = attributes.boolean(name: "swapLightColors", title: "交换浅色", dvalue: false);
    swapDarkColors = attributes.boolean(name: "swapDarkColors", title: "交换深色", dvalue: false);
    lightIsWhite = attributes.boolean(name: "lightIsWhite", title: "光是白色的", dvalue: false);
    darkIsTrueBlack = attributes.boolean(name: "darkIsTrueBlack", title: "黑暗是真正的黑色", dvalue: false);
    blendLightOnColors = attributes.boolean(name: "blendLightOnColors", title: "混合灯光颜色", dvalue: false);
    blendDarkOnColors = attributes.boolean(name: "blendDarkOnColors", title: "混合深色", dvalue: true);
    blendLightTextTheme = attributes.boolean(name: "blendLightTextTheme", title: "混合轻文本主题", dvalue: true);
    blendDarkTextTheme = attributes.boolean(name: "blendDarkTextTheme", title: "混合深色文本主题", dvalue: true);

    useKeyColors = attributes.boolean(name: "useKeyColors", title: "使用关键颜色", dvalue: false);
    useSecondary = attributes.boolean(name: "useSecondary", title: "使用次要", dvalue: false);
    useTertiary = attributes.boolean(name: "useTertiary", title: "使用第三", dvalue: false);
    keepPrimary = attributes.boolean(name: "keepPrimary", title: "保持主要", dvalue: false);
    keepSecondary = attributes.boolean(name: "keepSecondary", title: "保持次要", dvalue: false);
    keepTertiary = attributes.boolean(name: "keepTertiary", title: "保持大专", dvalue: false);
    keepPrimaryContainer = attributes.boolean(name: "keepPrimaryContainer", title: "保留主容器", dvalue: false);
    keepSecondaryContainer = attributes.boolean(name: "keepSecondaryContainer", title: "保留辅助容器", dvalue: false);
    keepTertiaryContainer = attributes.boolean(name: "keepTertiaryContainer", title: "保留第三级容器", dvalue: false);
    keepDarkPrimary = attributes.boolean(name: "keepDarkPrimary", title: "保持黑暗初级", dvalue: false);
    keepDarkSecondary = attributes.boolean(name: "keepDarkSecondary", title: "保持黑暗中学", dvalue: false);
    keepDarkTertiary = attributes.boolean(name: "keepDarkTertiary", title: "保持黑暗第三", dvalue: false);
    keepDarkPrimaryContainer = attributes.boolean(name: "keepDarkPrimaryContainer", title: "保留暗主容器", dvalue: false);
    keepDarkSecondaryContainer = attributes.boolean(name: "keepDarkSecondaryContainer", title: "保持黑暗辅助容器", dvalue: false);
    keepDarkTertiaryContainer = attributes.boolean(name: "keepDarkTertiaryContainer", title: "保持暗三级容器", dvalue: false);
    usedFlexToneSetup = attributes.integer(name: "usedFlexToneSetup", title: "使用 Flex Tone 设置", dvalue: 1);

    inputDecoratorSchemeColorLight = attributes.custom(name: "inputDecoratorSchemeColorLight", title: "输入装饰方案颜色光");
    inputDecoratorSchemeColorDark = attributes.custom(name: "inputDecoratorSchemeColorDark", title: "输入装饰方案颜色深");
    inputDecoratorIsFilled = attributes.boolean(name: "inputDecoratorIsFilled", title: "输入装饰器已填充", dvalue: true);
    inputDecoratorBorderType = attributes.custom(name: "inputDecoratorBorderType", title: "输入装饰器边框类型");
    inputDecoratorBorderRadius = attributes.floatNullable(name: "inputDecoratorBorderRadius", title: "输入装饰器边框半径");
    inputDecoratorUnfocusedHasBorder = attributes.boolean(name: "inputDecoratorUnfocusedHasBorder", title: "输入装饰器无焦点有边框", dvalue: true);
    inputDecoratorUnfocusedBorderIsColored = attributes.boolean(name: "inputDecoratorUnfocusedBorderIsColored", title: "输入装饰器未聚焦的边框是彩色的", dvalue: true);

    appBarStyleLight = attributes.custom(name: "appBarStyleLight", title: "亮色AppBar风格");
    appBarStyleDark = attributes.custom(name: "appBarStyleDark", title: "暗色AppBar风格", dvalue: FlexAppBarStyleValue(style: FlexAppBarStyle.background));
    appBarOpacityLight = attributes.float(name: "appBarOpacityLight", title: "应用栏不透明度灯", dvalue: 0.95);
    appBarOpacityDark = attributes.float(name: "appBarOpacityDark", title: "应用程序栏不透明度深色", dvalue: 0.9);
    appBarElevationLight = attributes.float(name: "appBarElevationLight", title: "亮色AppBar高度", dvalue: 0.0);
    appBarElevationDark = attributes.float(name: "appBarElevationDark", title: "暗色AppBar高度", dvalue: 0.0);
    transparentStatusBar = attributes.boolean(name: "transparentStatusBar", title: "透明状态栏", dvalue: true);
    appBarBackgroundSchemeColorLight = attributes.custom(name: "appBarBackgroundSchemeColorLight", title: "应用栏背景方案颜色光");
    appBarBackgroundSchemeColorDark = attributes.custom(name: "appBarBackgroundSchemeColorDark", title: "应用栏背景方案颜色深");

    tabBarStyle = attributes.custom(name: "tabBarStyle", title: "选项卡栏样式");
    tabBarIndicatorLight = attributes.custom(name: "tabBarIndicatorLight", title: "选项卡栏指示灯");
    tabBarIndicatorDark = attributes.custom(name: "tabBarIndicatorDark", title: "选项卡栏暗");
    tabBarItemSchemeColorLight = attributes.custom(name: "tabBarItemSchemeColorLight", title: "选项卡栏项目方案颜色灯");
    tabBarItemSchemeColorDark = attributes.custom(name: "tabBarItemSchemeColorDark", title: "选项卡栏项目方案颜色深");

    bottomSheetBorderRadius = attributes.floatNullable(name: "bottomSheetBorderRadius", title: "底部工作表边框半径");
    sysNavBarStyle = attributes.custom(name: "sysNavBarStyle", title: "sys 导航栏样式");
    sysNavBarOpacity = attributes.float(name: "sysNavBarOpacity", title: "sys 导航栏不透明度", dvalue: 1.0);
    useSysNavDivider = attributes.boolean(name: "useSysNavDivider", title: "使用系统分割栏", dvalue: false);

    bottomNavBarBackgroundSchemeColor = attributes.custom(name: "bottomNavBarBackgroundSchemeColor", title: "底部导航栏背景方案颜色");
    bottomNavigationBarOpacity = attributes.float(name: "bottomNavigationBarOpacity", title: "底部导航栏不透明度", dvalue: 1.0);
    bottomNavigationBarElevation = attributes.float(name: "bottomNavigationBarElevation", title: "底部导航栏高度", dvalue: 0);
    bottomNavBarSelectedSchemeColor = attributes.custom(name: "bottomNavBarSelectedSchemeColor", title: "底部导航栏选择的方案颜色");
    bottomNavBarUnselectedSchemeColor = attributes.custom(name: "bottomNavBarUnselectedSchemeColor", title: "底部导航栏未选择的方案颜色");
    bottomNavBarMuteUnselected = attributes.boolean(name: "bottomNavBarMuteUnselected", title: "底部导航栏静音未选中", dvalue: true);
    bottomNavShowSelectedLabels = attributes.boolean(name: "bottomNavShowSelectedLabels", title: "底部导航显示选定的标签", dvalue: true);
    bottomNavShowUnselectedLabels = attributes.boolean(name: "bottomNavShowUnselectedLabels", title: "底部导航显示未选择的标签", dvalue: true);

    navBarBackgroundSchemeColor = attributes.custom(name: "navBarBackgroundSchemeColor", title: "导航栏背景方案颜色");
    navBarOpacity = attributes.float(name: "navBarOpacity", title: "导航栏不透明度", dvalue: 1.0);
    navBarHeight = attributes.floatNullable(name: "navBarHeight", title: "导航栏高度");
    navBarSelectedSchemeColor = attributes.custom(name: "navBarSelectedSchemeColor", title: "导航栏选择的方案颜色");
    navBarUnselectedSchemeColor = attributes.custom(name: "navBarUnselectedSchemeColor", title: "导航栏未选择的方案颜色");
    navBarMuteUnselected = attributes.boolean(name: "navBarMuteUnselected", title: "导航栏静音未选中", dvalue: true);
    navBarIndicatorSchemeColor = attributes.custom(name: "navBarIndicatorSchemeColor", title: "导航栏指示器方案颜色");
    navBarIndicatorOpacity = attributes.floatNullable(name: "navBarIndicatorOpacity", title: "导航栏指示器不透明度");
    navBarLabelBehavior = attributes.custom(name: "navBarLabelBehavior", title: "导航栏标签行为");

    navRailBackgroundSchemeColor = attributes.custom(name: "navRailBackgroundSchemeColor", title: "导航栏背景方案颜色");
    navRailOpacity = attributes.float(name: "navRailOpacity", title: "nav 铁路不透明度", dvalue: 1.0);
    navigationRailElevation = attributes.float(name: "navigationRailElevation", title: "导航 铁路标高", dvalue: 0);
    navRailSelectedSchemeColor = attributes.custom(name: "navRailSelectedSchemeColor", title: "nav Rail 所选方案颜色");
    navRailUnselectedSchemeColor = attributes.custom(name: "navRailUnselectedSchemeColor", title: "nav Rail 未选择的方案颜色");
    navRailMuteUnselected = attributes.boolean(name: "navRailMuteUnselected", title: "nav Rail Mute 未选择", dvalue: true);
    navRailLabelType = attributes.custom(name: "navRailLabelType", title: "nav 导轨标签类型");
    navRailUseIndicator = attributes.boolean(name: "navRailUseIndicator", title: "nav 铁路使用指示器", dvalue: true);
    navRailIndicatorSchemeColor = attributes.custom(name: "navRailIndicatorSchemeColor", title: "nav 铁路指示器方案颜色");
    navRailIndicatorOpacity = attributes.floatNullable(name: "navRailIndicatorOpacity", title: "nav 轨道指示器不透明度");

    textButtonSchemeColor = attributes.custom(name: "textButtonSchemeColor", title: "文本按钮方案颜色");
    textButtonBorderRadius = attributes.floatNullable(name: "textButtonBorderRadius", title: "文本按钮边框半径");
    elevatedButtonSchemeColor = attributes.custom(name: "elevatedButtonSchemeColor", title: "提升按钮方案颜色");
    elevatedButtonBorderRadius = attributes.floatNullable(name: "elevatedButtonBorderRadius", title: "升高的按钮边框半径");
    outlinedButtonSchemeColor = attributes.custom(name: "outlinedButtonSchemeColor", title: "概述按钮方案颜色");
    outlinedButtonBorderRadius = attributes.floatNullable(name: "outlinedButtonBorderRadius", title: "概述按钮边框半径");
    toggleButtonsSchemeColor = attributes.custom(name: "toggleButtonsSchemeColor", title: "切换按钮方案颜色");
    toggleButtonsBorderRadius = attributes.floatNullable(name: "toggleButtonsBorderRadius", title: "切换按钮边框半径");
    unselectedToggleIsColored = attributes.boolean(name: "unselectedToggleIsColored", title: "未选中 切换为彩色", dvalue: false);
    switchSchemeColor = attributes.custom(name: "switchSchemeColor", title: "切换方案颜色");
    checkboxSchemeColor = attributes.custom(name: "checkboxSchemeColor", title: "复选框方案颜色");
    radioSchemeColor = attributes.custom(name: "radioSchemeColor", title: "收音机方案颜色");

    fabBorderRadius = attributes.floatNullable(name: "fabBorderRadius", title: "晶圆厂边界半径");
    fabSchemeColor = attributes.custom(name: "fabSchemeColor", title: "晶圆厂方案颜色");
    chipSchemeColor = attributes.custom(name: "chipSchemeColor", title: "芯片方案颜色");
    chipBorderRadius = attributes.floatNullable(name: "chipBorderRadius", title: "芯片边界半径");
    snackBarSchemeColor = attributes.custom(name: "snackBarSchemeColor", title: "小吃店方案颜色");
    popupMenuOpacity = attributes.float(name: "popupMenuOpacity", title: "弹出菜单不透明度", dvalue: 1.0);
    popupMenuBorderRadius = attributes.floatNullable(name: "popupMenuBorderRadius", title: "弹出菜单边框半径");
    cardBorderRadius = attributes.floatNullable(name: "cardBorderRadius", title: "卡片边框半径");
    dialogBackgroundSchemeColor = attributes.custom(name: "dialogBackgroundSchemeColor", title: "对话框背景方");
    dialogBorderRadius = attributes.floatNullable(name: "dialogBorderRadius", title: "对话框边框半径");
    tooltipsMatchBackground = attributes.boolean(name: "tooltipsMatchBackground", title: "tooltip是否匹配背景", dvalue: false);

    primaryLight = attributes.custom(name: "primaryLight", title: "主要色彩", dvalue: ColorValue(color: const Color(0xFF004881)));
    primaryContainerLight = attributes.custom(name: "primaryContainerLight", title: "主要容器色彩", dvalue: ColorValue(color: const Color(0xFFD0E4FF)));
    secondaryLight = attributes.custom(name: "secondaryLight", title: "二级色彩", dvalue: ColorValue(color: const Color(0xFFAC3306)));
    secondaryContainerLight = attributes.custom(name: "secondaryContainerLight", title: "二级容器色彩", dvalue: ColorValue(color: const Color(0xFFFFDBCF)));
    tertiaryLight = attributes.custom(name: "tertiaryLight", title: "三级色彩", dvalue: ColorValue(color: const Color(0xFF006875)));
    tertiaryContainerLight = attributes.custom(name: "tertiaryContainerLight", title: "三级容器色彩", dvalue: ColorValue(color: const Color(0xFF95F0FF)));
    primaryDark = attributes.custom(name: "primaryDark", title: "主要暗色", dvalue: ColorValue(color: const Color(0xFF9FC9FF)));
    primaryContainerDark = attributes.custom(name: "primaryContainerDark", title: "主要暗色容器", dvalue: ColorValue(color: const Color(0xFF00325B)));
    secondaryDark = attributes.custom(name: "secondaryDark", title: "二级暗色", dvalue: ColorValue(color: const Color(0xFFFFB59D)));
    secondaryContainerDark = attributes.custom(name: "secondaryContainerDark", title: "二级暗色容器", dvalue: ColorValue(color: const Color(0xFF872100)));
    tertiaryDark = attributes.custom(name: "tertiaryDark", title: "三级暗色", dvalue: ColorValue(color: const Color(0xFF872100)));
    tertiaryContainerDark = attributes.custom(name: "tertiaryContainerDark", title: "三级暗色容器", dvalue: ColorValue(color: const Color(0xFF004E59)));
  }

  /// 预制数据
  static List<ThemeTemplate> get initData {
    return [
      ThemeTemplate()
        ..id.value = "default"
        ..name.value = "默认模板",
      ThemeTemplate().withFlexScheme(FlexScheme.material)
        ..id.value = "material"
        ..name.value = "material",
      ThemeTemplate().withFlexScheme(FlexScheme.materialHc)
        ..id.value = "materialHc"
        ..name.value = "高对比度",
      ThemeTemplate().withFlexScheme(FlexScheme.blue)
        ..id.value = "blue"
        ..name.value = "蓝",
      ThemeTemplate().withFlexScheme(FlexScheme.indigo)
        ..id.value = "indigo"
        ..name.value = "青",
      ThemeTemplate().withFlexScheme(FlexScheme.hippieBlue)
        ..id.value = "hippieBlue"
        ..name.value = "嬉皮蓝",
      ThemeTemplate().withFlexScheme(FlexScheme.aquaBlue)
        ..id.value = "aquaBlue"
        ..name.value = "水蓝",
      ThemeTemplate().withFlexScheme(FlexScheme.brandBlue)
        ..id.value = "brandBlue"
        ..name.value = "品牌蓝",
      ThemeTemplate().withFlexScheme(FlexScheme.deepBlue)
        ..id.value = "deepBlue"
        ..name.value = "深蓝",
      ThemeTemplate().withFlexScheme(FlexScheme.sakura)
        ..id.value = "sakura"
        ..name.value = "樱",
      ThemeTemplate().withFlexScheme(FlexScheme.mandyRed)
        ..id.value = "mandyRed"
        ..name.value = "曼迪红",
      ThemeTemplate().withFlexScheme(FlexScheme.red)
        ..id.value = "red"
        ..name.value = "红",
      ThemeTemplate().withFlexScheme(FlexScheme.redWine)
        ..id.value = "redWine"
        ..name.value = "酒红",
      ThemeTemplate().withFlexScheme(FlexScheme.purpleBrown)
        ..id.value = "purpleBrown"
        ..name.value = "紫棕",
      ThemeTemplate().withFlexScheme(FlexScheme.green)
        ..id.value = "green"
        ..name.value = "绿",
      ThemeTemplate().withFlexScheme(FlexScheme.money)
        ..id.value = "money"
        ..name.value = "美元绿",
      ThemeTemplate().withFlexScheme(FlexScheme.jungle)
        ..id.value = "jungle"
        ..name.value = "野绿",
      ThemeTemplate().withFlexScheme(FlexScheme.greyLaw)
        ..id.value = "greyLaw"
        ..name.value = "蓝灰",
      ThemeTemplate().withFlexScheme(FlexScheme.wasabi)
        ..id.value = "wasabi"
        ..name.value = "芥末绿",
      ThemeTemplate().withFlexScheme(FlexScheme.gold)
        ..id.value = "gold"
        ..name.value = "金",
      ThemeTemplate().withFlexScheme(FlexScheme.mango)
        ..id.value = "mango"
        ..name.value = "芒",
      ThemeTemplate().withFlexScheme(FlexScheme.amber)
        ..id.value = "amber"
        ..name.value = "琥珀",
      ThemeTemplate().withFlexScheme(FlexScheme.vesuviusBurn)
        ..id.value = "vesuviusBurn"
        ..name.value = "火山灰",
      ThemeTemplate().withFlexScheme(FlexScheme.deepPurple)
        ..id.value = "deepPurple"
        ..name.value = "深紫",
      ThemeTemplate().withFlexScheme(FlexScheme.ebonyClay)
        ..id.value = "ebonyClay"
        ..name.value = "深蓝灰",
      ThemeTemplate().withFlexScheme(FlexScheme.barossa)
        ..id.value = "barossa"
        ..name.value = "巴罗莎",
      ThemeTemplate().withFlexScheme(FlexScheme.shark)
        ..id.value = "shark"
        ..name.value = "鲨鱼",
      ThemeTemplate().withFlexScheme(FlexScheme.bigStone)
        ..id.value = "bigStone"
        ..name.value = "石",
      ThemeTemplate().withFlexScheme(FlexScheme.damask)
        ..id.value = "damask"
        ..name.value = "锦",
      ThemeTemplate().withFlexScheme(FlexScheme.bahamaBlue)
        ..id.value = "bahamaBlue"
        ..name.value = "巴哈马蓝",
      ThemeTemplate().withFlexScheme(FlexScheme.mallardGreen)
        ..id.value = "mallardGreen"
        ..name.value = "鸭头绿",
      ThemeTemplate().withFlexScheme(FlexScheme.espresso)
        ..id.value = "espresso"
        ..name.value = "咖啡",
      ThemeTemplate().withFlexScheme(FlexScheme.outerSpace)
        ..id.value = "outerSpace"
        ..name.value = "外太空",
      ThemeTemplate().withFlexScheme(FlexScheme.blueWhale)
        ..id.value = "blueWhale"
        ..name.value = "蓝鲸",
      ThemeTemplate().withFlexScheme(FlexScheme.sanJuanBlue)
        ..id.value = "sanJuanBlue"
        ..name.value = "圣胡安蓝",
      ThemeTemplate().withFlexScheme(FlexScheme.rosewood)
        ..id.value = "rosewood"
        ..name.value = "红木",
      ThemeTemplate().withFlexScheme(FlexScheme.blumineBlue)
        ..id.value = "blumineBlue"
        ..name.value = "蓝光",
      ThemeTemplate().withFlexScheme(FlexScheme.flutterDash)
        ..id.value = "flutterDash"
        ..name.value = "flutter",
      ThemeTemplate().withFlexScheme(FlexScheme.materialBaseline)
        ..id.value = "materialBaseline"
        ..name.value = "material基础色",
      ThemeTemplate().withFlexScheme(FlexScheme.verdunHemlock)
        ..id.value = "verdunHemlock"
        ..name.value = "凡尔登铁杉",
      ThemeTemplate().withFlexScheme(FlexScheme.dellGenoa)
        ..id.value = "dellGenoa"
        ..name.value = "热那亚",
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
      // Used number of colors from the selected input FlexColorScheme based theme
      usedColors: usedColors.value,
      // Use controller to select surface mode
      surfaceMode: surfaceModeLight.value.mode,
      // Integer used to control the level of primary color
      // surface blends applied to surfaces and backgrounds.
      blendLevel: blendLevel.value,
      // Enum used to select what AppBar style we use.
      appBarStyle: appBarStyleLight.value.style,
      // Set background opacity on app bar.
      appBarOpacity: appBarOpacityLight.value,
      // Used to control if we use one or two toned status bar.
      transparentStatusBar: transparentStatusBar.value,
      // Used to modify the themed AppBar elevation.
      appBarElevation: appBarElevationLight.value,
      // Enum used to select what TabBar style we use.
      tabBarStyle: tabBarStyle.value.style,
      // Keep scaffold plain white in all blend modes.
      lightIsWhite: lightIsWhite.value,
      // Swap primary and secondary colors.
      swapColors: swapLightColors.value,
      // If true, tooltip theme background will be light in light
      // theme, and dark in dark themes. The Flutter and Material
      // default and standard is the other way, tooltip background
      // color is inverted compared to app background.
      // Set to true, to mimic e.g. the look of Windows desktop
      // tooltips. You could tie this to the active platform and
      // have different style of tooltips on different platforms.
      tooltipsMatchBackground: tooltipsMatchBackground.value,
      //
      // Opt in/out of using opinionated sub-themes.
      subThemesData: FlexSubThemesData(
        // Want color themed disable hover, focus, highlight and
        // splash colors? Then keep this one on.
        interactionEffects: true,
        // Blend level for on colors for on colors, primary
        // secondary and tertiary and their containers.
        blendOnLevel: blendOnLevel.value,
        // Use blend level values also with main on colors, not
        // only with container and on surfaces.
        blendOnColors: blendLightOnColors.value,
        // By default sub themes mode also opts in on using colored text for
        // the themed text. If you plan to put text on surfaces that are not
        // primary color tinted or primary colored, then you may need to
        // turn this off, or make custom text themes for those surfaces.
        // Material3 has containers with matching colors too, they work
        // great for contrast colored text, do use them too.
        blendTextTheme: blendLightTextTheme.value,
        // Opt in/out of the Material 3 style matched TextTheme geometry, or
        // Typography, as it is called in Flutter SDK. The M3 Typography is
        // not yet natively available in Flutter SDK 2.10.3 or earlier,
        // this offers it as a way to use it already now.
        useTextTheme: true,
        // Prefer Flutter SDK null default behavior for sub-themes, when
        // possible.
        useFlutterDefaults: false,
        // Value to adjust themed border radius on widgets with
        // an adjustable corner rounding, this one is very handy.
        // If null, it defaults to Material3 (You) design
        // guide values, when available: https://m3.material.io/
        // If you give it value, "all" Flutter built-in widgets
        // supporting border radius will use the give radius.
        defaultRadius: defaultRadius.value,
        // Border radius can be customized per widget too, here are
        // examples, it overrides M3 default and global default setting.
        bottomSheetRadius: bottomSheetBorderRadius.value,
        elevatedButtonRadius: elevatedButtonBorderRadius.value,
        outlinedButtonRadius: outlinedButtonBorderRadius.value,
        textButtonRadius: textButtonBorderRadius.value,
        toggleButtonsRadius: toggleButtonsBorderRadius.value,
        // SchemeColor based ColorScheme color used on buttons & toggles.
        textButtonSchemeColor: textButtonSchemeColor.value.scheme,
        elevatedButtonSchemeColor: elevatedButtonSchemeColor.value.scheme,
        outlinedButtonSchemeColor: outlinedButtonSchemeColor.value.scheme,
        toggleButtonsSchemeColor: toggleButtonsSchemeColor.value.scheme,
        switchSchemeColor: switchSchemeColor.value.scheme,
        checkboxSchemeColor: checkboxSchemeColor.value.scheme,
        radioSchemeColor: radioSchemeColor.value.scheme,
        // Style of unselected switch/checkbox/radio.
        unselectedToggleIsColored: unselectedToggleIsColored.value,
        //
        // Base ColorScheme used by TextField InputDecorator.
        inputDecoratorSchemeColor: inputDecoratorSchemeColorLight.value.scheme,
        // Text input field uses a themed fill color.
        inputDecoratorIsFilled: inputDecoratorIsFilled.value,
        // Underline or outline border type?
        inputDecoratorBorderType: inputDecoratorBorderType.value.type,
        inputDecoratorRadius: inputDecoratorBorderRadius.value,
        // Only want a border when the text input has focus
        // or error, then set this to false. By default it always
        // has a border of selected style, but thinner.
        inputDecoratorUnfocusedHasBorder: inputDecoratorUnfocusedHasBorder.value,
        // Want to use uncolored border/underline when unfocused,
        // set this to false
        inputDecoratorUnfocusedBorderIsColored: inputDecoratorUnfocusedBorderIsColored.value,
        // Set to false to keep using M2 style FAB and ignore
        // M3 type default and global radius on the FAB, it thus
        // remains circular or stadium shaped in extended mode.
        fabUseShape: true,
        fabRadius: fabBorderRadius.value,
        fabSchemeColor: fabSchemeColor.value.scheme,
        snackBarBackgroundSchemeColor: snackBarSchemeColor.value.scheme,
        chipSchemeColor: chipSchemeColor.value.scheme,
        chipRadius: chipBorderRadius.value,
        cardRadius: cardBorderRadius.value,
        popupMenuOpacity: popupMenuOpacity.value,
        popupMenuRadius: popupMenuBorderRadius.value,
        // ColorScheme used on various widgets.
        dialogBackgroundSchemeColor: dialogBackgroundSchemeColor.value.scheme,
        dialogRadius: dialogBorderRadius.value,
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
      //
      // Advanced color properties for seed generated ColorScheme's
      //
      // Use key color based M3 ColorScheme.
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
      // Use Material3 error colors with Material2 themes.
      useMaterial3ErrorColors: true,
      // Use predefined [FlexTones] setups for the generated
      // [TonalPalette] and it's usage in [ColorScheme] config.
      // You can make your custom [FlexTones] object right here
      // and apps it it, this just uses an int value to select
      // between a few pre-configured ones.
      tones: flexTonesConfig(Brightness.light, usedFlexToneSetup.value),
      //
      // ThemeData properties passed along directly to ThemeData.
      //
      // Modify the value in the AppData class to change it.
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      // Custom font, modify in AppData class to change it.
      fontFamily: fontFamily.value,
      // The platform can be toggled in the app, but not saved.
      platform: defaultTargetPlatform,
      // Opt-in/out of using Flutter SDK Material3 based theming
      // features. In Flutter SDK 2.10 and earlier it has almost no
      // effect, but it will later and then we can use this toggle
      // with FlexColorScheme too, and in this demo we can see its
      // impact easily.
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
      swapColors: swapDarkColors.value,
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
        inputDecoratorRadius: inputDecoratorBorderRadius.value,
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
      platform: defaultTargetPlatform,
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
