import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:hg_entity/hg_entity.dart';

import 'app_color.dart';
import 'theme_custom_value.dart';

class ThemeTemplate extends DataModel {
  // GENERAL SETTINGS.
  // ThemeMode, use FlexColorScheme and sub-themes, current scheme, view, etc.
  // ===========================================================================
  late final Attribute<ThemeModeValue> themeMode;
  late final Attribute<bool> useFlexColorScheme;
  late final Attribute<bool> useSubThemes;
  late final Attribute<bool> useFlutterDefaults;
  late final Attribute<bool> isLargeGridView;
  late final Attribute<int> viewIndex;
  late final Attribute<bool> useTextTheme;
  late final Attribute<bool> useAppFont;
  late final Attribute<FlexSchemeValue> usedScheme;
  late final Attribute<int> schemeIndex;
  late final Attribute<bool> interactionEffects;
  late final Attribute<double?> defaultRadius;
  late final Attribute<bool> tooltipsMatchBackground;

  // Surface and blend SETTINGS.
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
  late final Attribute<bool> useDarkColorsForSeed;
  late final Attribute<bool> useToDarkMethod;
  late final Attribute<bool> toDarkSwapPrimaryAndContainer;
  late final Attribute<int> darkMethodLevel;

  // On color blending ON/OFF
  late final Attribute<bool> blendLightOnColors;
  late final Attribute<bool> blendDarkOnColors;
  late final Attribute<bool> blendLightTextTheme;
  late final Attribute<bool> blendDarkTextTheme;

  // Material 3 and Seed ColorScheme SETTINGS.
  // ===========================================================================
  late final Attribute<bool> useMaterial3;
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
  late final Attribute<bool> useM3ErrorColors;

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
  late final Attribute<SchemeColorValue> toggleButtonsSchemeColor;
  late final Attribute<double?> toggleButtonsBorderRadius;

  // Toggleable SETTINGS.
  // ===========================================================================
  late final Attribute<bool> unselectedToggleIsColored;
  late final Attribute<SchemeColorValue> switchSchemeColor;
  late final Attribute<SchemeColorValue> checkboxSchemeColor;
  late final Attribute<SchemeColorValue> radioSchemeColor;

  // Fab, Chip, SnackBar, Popup, Card nad Dialog SETTINGS.
  // ===========================================================================
  late final Attribute<bool> fabUseShape;
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

  // Custom color SETTINGS.
  // ===========================================================================
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

  ThemeTemplate() {
    themeMode = attributes.custom(name: "themeMode", title: "主题模式");
    useFlexColorScheme = attributes.boolean(name: "useFlexColorScheme", title: "使用Flex色彩方案", dvalue: true);
    useSubThemes = attributes.boolean(name: "useSubThemes", title: "使用子主题", dvalue: true);
    useFlutterDefaults = attributes.boolean(name: "useFlutterDefaults", title: "使用 Flutter 默认值", dvalue: false);
    isLargeGridView = attributes.boolean(name: "isLargeGridView", title: "是大网格视图", dvalue: false);
    viewIndex = attributes.integer(name: "viewIndex", title: "索引", dvalue: 0);
    useTextTheme = attributes.boolean(name: "useTextTheme", title: "使用文本主题", dvalue: true);
    useAppFont = attributes.boolean(name: "useAppFont", title: "使用应用字体", dvalue: true);
    useAppFont = attributes.boolean(name: "useAppFont", title: "使用应用字体", dvalue: true);
    usedScheme = attributes.custom(name: "usedScheme", title: "使用的方案");
    schemeIndex = attributes.integer(name: "schemeIndex", title: "方案索引", dvalue: 39);
    interactionEffects = attributes.boolean(name: "interactionEffects", title: "交互效果", dvalue: true);
    defaultRadius = attributes.floatNullable(name: "defaultRadius", title: "默认半径");
    tooltipsMatchBackground = attributes.boolean(name: "tooltipsMatchBackground", title: "工具提示匹配背景", dvalue: false);

    surfaceModeLight = attributes.custom(name: "surfaceModeLight", title: "表面模式光");
    surfaceModeDark = attributes.custom(name: "surfaceModeDark", title: "表面模式暗");
    blendLevel = attributes.integer(name: "blendLevel", title: "混合级别", dvalue: 20);
    blendLevelDark = attributes.integer(name: "blendLevelDark", title: "混合水平黑暗", dvalue: 15);
    blendOnLevel = attributes.integer(name: "blendOnLevel", title: "混合水平", dvalue: 20);
    blendOnLevelDark = attributes.integer(name: "blendOnLevelDark", title: "混合水平黑暗", dvalue: 30);
    usedColors = attributes.integer(name: "usedColors", title: "用过的颜色", dvalue: 6);
    swapLightColors = attributes.boolean(name: "swapLightColors", title: "交换浅色", dvalue: false);
    swapDarkColors = attributes.boolean(name: "swapDarkColors", title: "交换深色", dvalue: false);
    lightIsWhite = attributes.boolean(name: "lightIsWhite", title: "光是白色的", dvalue: false);
    darkIsTrueBlack = attributes.boolean(name: "darkIsTrueBlack", title: "黑暗是真正的黑色", dvalue: false);
    useDarkColorsForSeed = attributes.boolean(name: "useDarkColorsForSeed", title: "为种子使用深色", dvalue: false);
    useToDarkMethod = attributes.boolean(name: "useToDarkMethod", title: "使用 To Dark 方法", dvalue: false);
    toDarkSwapPrimaryAndContainer = attributes.boolean(name: "toDarkSwapPrimaryAndContainer", title: "到暗交换主要和容器", dvalue: true);
    darkMethodLevel = attributes.integer(name: "darkMethodLevel", title: "黑暗方法级别", dvalue: 10);
    blendLightOnColors = attributes.boolean(name: "blendLightOnColors", title: "混合灯光颜色", dvalue: false);
    blendDarkOnColors = attributes.boolean(name: "blendDarkOnColors", title: "混合深色", dvalue: true);
    blendLightTextTheme = attributes.boolean(name: "blendLightTextTheme", title: "混合轻文本主题", dvalue: true);
    blendDarkTextTheme = attributes.boolean(name: "blendDarkTextTheme", title: "混合深色文本主题", dvalue: true);

    useMaterial3 = attributes.boolean(name: "useMaterial3", title: "使用材料 3", dvalue: true);
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
    useM3ErrorColors = attributes.boolean(name: "useM3ErrorColors", title: "使用 M 3 错误颜色", dvalue: false);

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

    fabUseShape = attributes.boolean(name: "fabUseShape", title: "晶圆厂使用形状", dvalue: true);
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

    primaryLight = attributes.custom(name: "primaryLight", title: "主要色彩", dvalue: ColorValue(color: AppColor.customPrimaryLight));
    primaryContainerLight = attributes.custom(name: "primaryContainerLight", title: "主要容器色彩", dvalue: ColorValue(color: AppColor.customPrimaryContainerLight));
    secondaryLight = attributes.custom(name: "secondaryLight", title: "二级色彩", dvalue: ColorValue(color: AppColor.customSecondaryLight));
    secondaryContainerLight =
        attributes.custom(name: "secondaryContainerLight", title: "二级容器色彩", dvalue: ColorValue(color: AppColor.customSecondaryContainerLight));
    tertiaryLight = attributes.custom(name: "tertiaryLight", title: "三级色彩", dvalue: ColorValue(color: AppColor.customTertiaryLight));
    tertiaryContainerLight =
        attributes.custom(name: "tertiaryContainerLight", title: "三级容器色彩", dvalue: ColorValue(color: AppColor.customTertiaryContainerLight));
    primaryDark = attributes.custom(name: "primaryDark", title: "主要暗色", dvalue: ColorValue(color: AppColor.customPrimaryDark));
    primaryContainerDark = attributes.custom(name: "primaryContainerDark", title: "主要暗色容器", dvalue: ColorValue(color: AppColor.customPrimaryContainerDark));
    secondaryDark = attributes.custom(name: "secondaryDark", title: "二级暗色", dvalue: ColorValue(color: AppColor.customSecondaryDark));
    secondaryContainerDark =
        attributes.custom(name: "secondaryContainerDark", title: "二级暗色容器", dvalue: ColorValue(color: AppColor.customSecondaryContainerDark));
    tertiaryDark = attributes.custom(name: "tertiaryDark", title: "三级暗色", dvalue: ColorValue(color: AppColor.customTertiaryDark));
    tertiaryContainerDark = attributes.custom(name: "tertiaryContainerDark", title: "三级暗色容器", dvalue: ColorValue(color: AppColor.customTertiaryContainerDark));
  }
}
