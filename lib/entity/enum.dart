import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:hg_entity/hg_entity.dart';
import 'package:hg_framework/hg_framework.dart';

extension FlexSchemeEx on FlexScheme {
  String get title {
    switch (this) {
      case FlexScheme.material:
        return "材质";
      case FlexScheme.materialHc:
        return "材质高对比";
      case FlexScheme.blue:
        return "蓝";
      case FlexScheme.indigo:
        return "青";
      case FlexScheme.hippieBlue:
        return "嬉皮蓝";
      case FlexScheme.aquaBlue:
        return "水蓝";
      case FlexScheme.brandBlue:
        return "品牌蓝";
      case FlexScheme.deepBlue:
        return "深蓝";
      case FlexScheme.sakura:
        return "樱";
      case FlexScheme.mandyRed:
        return "曼迪红";
      case FlexScheme.red:
        return "红";
      case FlexScheme.redWine:
        return "红酒";
      case FlexScheme.purpleBrown:
        return "紫棕";
      case FlexScheme.green:
        return "绿";
      case FlexScheme.money:
        return "美元";
      case FlexScheme.jungle:
        return "丛林";
      case FlexScheme.greyLaw:
        return "灰";
      case FlexScheme.wasabi:
        return "芥末";
      case FlexScheme.gold:
        return "金";
      case FlexScheme.mango:
        return "芒果";
      case FlexScheme.amber:
        return "琥珀";
      case FlexScheme.vesuviusBurn:
        return "维苏威";
      case FlexScheme.deepPurple:
        return "深紫";
      case FlexScheme.ebonyClay:
        return "乌木粘土";
      case FlexScheme.barossa:
        return "巴罗莎";
      case FlexScheme.shark:
        return "鲨";
      case FlexScheme.bigStone:
        return "石";
      case FlexScheme.damask:
        return "锦";
      case FlexScheme.bahamaBlue:
        return "巴哈马蓝";
      case FlexScheme.mallardGreen:
        return "绿头鸭";
      case FlexScheme.espresso:
        return "浓咖啡";
      case FlexScheme.outerSpace:
        return "外太空";
      case FlexScheme.blueWhale:
        return "蓝鲸";
      case FlexScheme.sanJuanBlue:
        return "圣胡安蓝";
      case FlexScheme.rosewood:
        return "红木";
      case FlexScheme.blumineBlue:
        return "蓝铜矿";
      case FlexScheme.flutterDash:
        return "flutter";
      case FlexScheme.materialBaseline:
        return "材质基线";
      case FlexScheme.verdunHemlock:
        return "凡尔登铁杉";
      case FlexScheme.dellGenoa:
        return "热那亚";
      case FlexScheme.custom:
        return "自定义";
    }
  }
}

extension FlexSurfaceModeEx on FlexSurfaceMode {
  String get title {
    switch (this) {
      case FlexSurfaceMode.level:
        return "水平";
      case FlexSurfaceMode.highBackgroundLowScaffold:
        return "背景高脚手架低";
      case FlexSurfaceMode.highSurfaceLowScaffold:
        return "表面高脚手架低";
      case FlexSurfaceMode.highScaffoldLowSurface:
        return "脚手架高表面低";
      case FlexSurfaceMode.highScaffoldLevelSurface:
        return "高脚手架表面水平";
      case FlexSurfaceMode.levelSurfacesLowScaffold:
        return "表面水平低脚手架";
      case FlexSurfaceMode.highScaffoldLowSurfaces:
        return "脚手架高表面低";
      case FlexSurfaceMode.levelSurfacesLowScaffoldVariantDialog:
        return "表面水平脚手架低对话框变体";
      case FlexSurfaceMode.highScaffoldLowSurfacesVariantDialog:
        return "脚手架高表面低对话框变体";
      case FlexSurfaceMode.custom:
        return "自定义";
    }
  }
}

extension FlexAppBatStyleEx on FlexAppBarStyle {
  String get title {
    switch (this) {
      case FlexAppBarStyle.primary:
        return '主色';
      case FlexAppBarStyle.material:
        return "浅色模式：白色 深色模式 黑色(#121212)";
      case FlexAppBarStyle.surface:
        return '前景色';
      case FlexAppBarStyle.background:
        return '背景色';
      case FlexAppBarStyle.custom:
        return '自定义';
    }
  }
}

extension FlexTabBarStyleEx on FlexTabBarStyle {
  String get title {
    switch (this) {
      case FlexTabBarStyle.forAppBar:
        return '应用栏 使用应用栏样式';
      case FlexTabBarStyle.forBackground:
        return '背景色 使用背景色';
      case FlexTabBarStyle.flutterDefault:
        return '默认 浅色模式下使用主色, 深色模式下使用背景色';
      case FlexTabBarStyle.universal:
        return '通用 低对比度样式';
    }
  }
}

extension FlexInputBorderTypeEx on FlexInputBorderType {
  String get title {
    switch (this) {
      case FlexInputBorderType.outline:
        return '轮廓';
      case FlexInputBorderType.underline:
        return '下划线';
    }
  }
}

extension FlexSystemNavBarStyleEx on FlexSystemNavBarStyle {
  String get title {
    switch (this) {
      case FlexSystemNavBarStyle.system:
        return "系统";
      case FlexSystemNavBarStyle.surface:
        return "前景色";
      case FlexSystemNavBarStyle.background:
        return "背景色";
      case FlexSystemNavBarStyle.scaffoldBackground:
        return "脚手架背景色";
      case FlexSystemNavBarStyle.transparent:
        return "透明";
    }
  }
}

extension NavigationDestinationLabelBehaviorEx on NavigationDestinationLabelBehavior {
  String get title {
    switch (this) {
      case NavigationDestinationLabelBehavior.alwaysHide:
        return '不显示文本';
      case NavigationDestinationLabelBehavior.onlyShowSelected:
        return '只有选中栏目显示文本';
      case NavigationDestinationLabelBehavior.alwaysShow:
        return '显示文本';
    }
  }
}

extension NavigationRailLabelTypeEx on NavigationRailLabelType {
  String get title {
    switch (this) {
      case NavigationRailLabelType.none:
        return '不显示文本';
      case NavigationRailLabelType.selected:
        return '只有选中栏目显示文本';
      case NavigationRailLabelType.all:
        return '显示文本';
    }
  }
}

enum TonalPalettes {
  primary,
  secondary,
  tertiary,
  error,
  neutral,
  neutralVariant,
}

enum ColorType {
  primary,
  onPrimary,
  primaryContainer,
  onPrimaryContainer,
  secondary,
  onSecondary,
  secondaryContainer,
  onSecondaryContainer,
  tertiary,
  onTertiary,
  tertiaryContainer,
  onTertiaryContainer,
  error,
  onError,
  errorContainer,
  onErrorContainer,
  background,
  onBackground,
  surface,
  onSurface,
  surfaceVariant,
  onSurfaceVariant,
  outline,
  shadow,
  inverseSurface,
  onInverseSurface,
  inversePrimary,
}

extension ColorTypeEx on ColorType {
  String get title {
    switch (this) {
      case ColorType.primary:
        return '主色';
      case ColorType.onPrimary:
        return '主文本色';
      case ColorType.primaryContainer:
        return '主背景色';
      case ColorType.onPrimaryContainer:
        return '主背景文本色';
      case ColorType.secondary:
        return '次色';
      case ColorType.onSecondary:
        return '次文本色';
      case ColorType.secondaryContainer:
        return '次背景色';
      case ColorType.onSecondaryContainer:
        return '次背景文本色';
      case ColorType.tertiary:
        return '辅色';
      case ColorType.onTertiary:
        return '辅文本色';
      case ColorType.tertiaryContainer:
        return '辅背景色';
      case ColorType.onTertiaryContainer:
        return '辅背景文本色';
      case ColorType.error:
        return '错误色';
      case ColorType.onError:
        return '错误文本色';
      case ColorType.errorContainer:
        return '错误背景色';
      case ColorType.onErrorContainer:
        return '错误背景文本色';
      case ColorType.background:
        return '背景色';
      case ColorType.onBackground:
        return '背景文本色';
      case ColorType.surface:
        return '前景色';
      case ColorType.onSurface:
        return '前景文本色';
      case ColorType.surfaceVariant:
        return '前景色变体';
      case ColorType.onSurfaceVariant:
        return '前景文本色变体';
      case ColorType.outline:
        return '轮廓色';
      case ColorType.shadow:
        return '阴影色';
      case ColorType.inverseSurface:
        return '前景色反色';
      case ColorType.onInverseSurface:
        return '前景文本色反色';
      case ColorType.inversePrimary:
        return '主色反色';
    }
  }

  Color getColor(ColorScheme colorScheme) {
    switch (this) {
      case ColorType.primary:
        return colorScheme.primary;
      case ColorType.onPrimary:
        return colorScheme.onPrimary;
      case ColorType.primaryContainer:
        return colorScheme.primaryContainer;
      case ColorType.onPrimaryContainer:
        return colorScheme.onPrimaryContainer;
      case ColorType.secondary:
        return colorScheme.secondary;
      case ColorType.onSecondary:
        return colorScheme.onSecondary;
      case ColorType.secondaryContainer:
        return colorScheme.secondaryContainer;
      case ColorType.onSecondaryContainer:
        return colorScheme.onSecondaryContainer;
      case ColorType.tertiary:
        return colorScheme.tertiary;
      case ColorType.onTertiary:
        return colorScheme.onTertiary;
      case ColorType.tertiaryContainer:
        return colorScheme.tertiaryContainer;
      case ColorType.onTertiaryContainer:
        return colorScheme.onTertiaryContainer;
      case ColorType.error:
        return colorScheme.error;
      case ColorType.onError:
        return colorScheme.onError;
      case ColorType.errorContainer:
        return colorScheme.errorContainer;
      case ColorType.onErrorContainer:
        return colorScheme.onErrorContainer;
      case ColorType.background:
        return colorScheme.background;
      case ColorType.onBackground:
        return colorScheme.onBackground;
      case ColorType.surface:
        return colorScheme.surface;
      case ColorType.onSurface:
        return colorScheme.onSurface;
      case ColorType.surfaceVariant:
        return colorScheme.surfaceVariant;
      case ColorType.onSurfaceVariant:
        return colorScheme.onSurfaceVariant;
      case ColorType.outline:
        return colorScheme.outline;
      case ColorType.shadow:
        return colorScheme.shadow;
      case ColorType.inverseSurface:
        return colorScheme.inverseSurface;
      case ColorType.onInverseSurface:
        return colorScheme.onInverseSurface;
      case ColorType.inversePrimary:
        return colorScheme.inversePrimary;
    }
  }

  Color getOnColor(ColorScheme colorScheme) {
    switch (this) {
      case ColorType.primary:
        return colorScheme.onPrimary;
      case ColorType.onPrimary:
        return colorScheme.primary;
      case ColorType.primaryContainer:
        return colorScheme.onPrimaryContainer;
      case ColorType.onPrimaryContainer:
        return colorScheme.primaryContainer;
      case ColorType.secondary:
        return colorScheme.onSecondary;
      case ColorType.onSecondary:
        return colorScheme.secondary;
      case ColorType.secondaryContainer:
        return colorScheme.onSecondaryContainer;
      case ColorType.onSecondaryContainer:
        return colorScheme.secondaryContainer;
      case ColorType.tertiary:
        return colorScheme.onTertiary;
      case ColorType.onTertiary:
        return colorScheme.tertiary;
      case ColorType.tertiaryContainer:
        return colorScheme.onTertiaryContainer;
      case ColorType.onTertiaryContainer:
        return colorScheme.tertiaryContainer;
      case ColorType.error:
        return colorScheme.onError;
      case ColorType.onError:
        return colorScheme.error;
      case ColorType.errorContainer:
        return colorScheme.onErrorContainer;
      case ColorType.onErrorContainer:
        return colorScheme.errorContainer;
      case ColorType.background:
        return colorScheme.onBackground;
      case ColorType.onBackground:
        return colorScheme.background;
      case ColorType.surface:
        return colorScheme.onSurface;
      case ColorType.onSurface:
        return colorScheme.surface;
      case ColorType.surfaceVariant:
        return colorScheme.onSurfaceVariant;
      case ColorType.onSurfaceVariant:
        return colorScheme.surfaceVariant;
      case ColorType.outline:
        return colorScheme.shadow;
      case ColorType.shadow:
        return colorScheme.outline;
      case ColorType.inverseSurface:
        return colorScheme.onInverseSurface;
      case ColorType.onInverseSurface:
        return colorScheme.inverseSurface;
      case ColorType.inversePrimary:
        return colorScheme.primary;
    }
  }

  Attribute<ColorValue>? getColorAttribute(ThemeTemplate template, bool isLight) {
    switch (this) {
      case ColorType.primary:
        return isLight ? template.primaryLight : template.primaryDark;
      case ColorType.primaryContainer:
        return isLight ? template.primaryContainerLight : template.primaryContainerDark;
      case ColorType.secondary:
        return isLight ? template.secondaryLight : template.secondaryDark;
      case ColorType.secondaryContainer:
        return isLight ? template.secondaryContainerLight : template.secondaryContainerDark;
      case ColorType.tertiary:
        return isLight ? template.tertiaryLight : template.tertiaryDark;
      case ColorType.tertiaryContainer:
        return isLight ? template.tertiaryContainerLight : template.tertiaryContainerDark;
      case ColorType.onPrimary:
      case ColorType.onPrimaryContainer:
      case ColorType.onSecondary:
      case ColorType.onSecondaryContainer:
      case ColorType.onTertiary:
      case ColorType.onTertiaryContainer:
      case ColorType.error:
      case ColorType.onError:
      case ColorType.errorContainer:
      case ColorType.onErrorContainer:
      case ColorType.background:
      case ColorType.onBackground:
      case ColorType.surface:
      case ColorType.onSurface:
      case ColorType.surfaceVariant:
      case ColorType.onSurfaceVariant:
      case ColorType.outline:
      case ColorType.shadow:
      case ColorType.inverseSurface:
      case ColorType.onInverseSurface:
      case ColorType.inversePrimary:
        return null;
    }
  }

  Attribute<bool>? getKeepAttribute(ThemeTemplate template, bool isLight) {
    switch (this) {
      case ColorType.primary:
        return isLight ? template.keepPrimary : template.keepDarkPrimary;
      case ColorType.primaryContainer:
        return isLight ? template.keepPrimaryContainer : template.keepDarkPrimaryContainer;
      case ColorType.secondary:
        return isLight ? template.keepSecondary : template.keepDarkSecondary;
      case ColorType.secondaryContainer:
        return isLight ? template.keepSecondaryContainer : template.keepDarkSecondaryContainer;
      case ColorType.tertiary:
        return isLight ? template.keepTertiary : template.keepDarkTertiary;
      case ColorType.tertiaryContainer:
        return isLight ? template.keepTertiaryContainer : template.keepDarkTertiaryContainer;
      case ColorType.onPrimary:
      case ColorType.onPrimaryContainer:
      case ColorType.onSecondary:
      case ColorType.onSecondaryContainer:
      case ColorType.onTertiary:
      case ColorType.onTertiaryContainer:
      case ColorType.error:
      case ColorType.onError:
      case ColorType.errorContainer:
      case ColorType.onErrorContainer:
      case ColorType.background:
      case ColorType.onBackground:
      case ColorType.surface:
      case ColorType.onSurface:
      case ColorType.surfaceVariant:
      case ColorType.onSurfaceVariant:
      case ColorType.outline:
      case ColorType.shadow:
      case ColorType.inverseSurface:
      case ColorType.onInverseSurface:
      case ColorType.inversePrimary:
        return null;
    }
  }

  SchemeColor get schemeColor {
    switch (this) {
      case ColorType.primary:
        return SchemeColor.primary;
      case ColorType.onPrimary:
        return SchemeColor.onPrimary;
      case ColorType.primaryContainer:
        return SchemeColor.primaryContainer;
      case ColorType.onPrimaryContainer:
        return SchemeColor.onPrimaryContainer;
      case ColorType.secondary:
        return SchemeColor.secondary;
      case ColorType.onSecondary:
        return SchemeColor.onSecondary;
      case ColorType.secondaryContainer:
        return SchemeColor.secondaryContainer;
      case ColorType.onSecondaryContainer:
        return SchemeColor.onSecondaryContainer;
      case ColorType.tertiary:
        return SchemeColor.tertiary;
      case ColorType.onTertiary:
        return SchemeColor.onTertiary;
      case ColorType.tertiaryContainer:
        return SchemeColor.tertiaryContainer;
      case ColorType.onTertiaryContainer:
        return SchemeColor.onTertiaryContainer;
      case ColorType.error:
        return SchemeColor.error;
      case ColorType.onError:
        return SchemeColor.onError;
      case ColorType.errorContainer:
        return SchemeColor.errorContainer;
      case ColorType.onErrorContainer:
        return SchemeColor.onErrorContainer;
      case ColorType.background:
        return SchemeColor.background;
      case ColorType.onBackground:
        return SchemeColor.onBackground;
      case ColorType.surface:
        return SchemeColor.surface;
      case ColorType.onSurface:
        return SchemeColor.onSurface;
      case ColorType.surfaceVariant:
        return SchemeColor.surfaceVariant;
      case ColorType.onSurfaceVariant:
        return SchemeColor.onSurfaceVariant;
      case ColorType.outline:
        return SchemeColor.outline;
      case ColorType.shadow:
        return SchemeColor.shadow;
      case ColorType.inverseSurface:
        return SchemeColor.inverseSurface;
      case ColorType.onInverseSurface:
        return SchemeColor.onInverseSurface;
      case ColorType.inversePrimary:
        return SchemeColor.inversePrimary;
    }
  }
}

extension SchemeColorEx on SchemeColor {
  ColorType? get colorType {
    switch (this) {
      case SchemeColor.primary:
        return ColorType.primary;
      case SchemeColor.onPrimary:
        return ColorType.onPrimary;
      case SchemeColor.primaryContainer:
        return ColorType.primaryContainer;
      case SchemeColor.onPrimaryContainer:
        return ColorType.onPrimaryContainer;
      case SchemeColor.secondary:
        return ColorType.secondary;
      case SchemeColor.onSecondary:
        return ColorType.onSecondary;
      case SchemeColor.secondaryContainer:
        return ColorType.secondaryContainer;
      case SchemeColor.onSecondaryContainer:
        return ColorType.onSecondaryContainer;
      case SchemeColor.tertiary:
        return ColorType.tertiary;
      case SchemeColor.onTertiary:
        return ColorType.onTertiary;
      case SchemeColor.tertiaryContainer:
        return ColorType.tertiaryContainer;
      case SchemeColor.onTertiaryContainer:
        return ColorType.onTertiaryContainer;
      case SchemeColor.error:
        return ColorType.error;
      case SchemeColor.onError:
        return ColorType.onError;
      case SchemeColor.errorContainer:
        return ColorType.errorContainer;
      case SchemeColor.onErrorContainer:
        return ColorType.onErrorContainer;
      case SchemeColor.background:
        return ColorType.background;
      case SchemeColor.onBackground:
        return ColorType.onBackground;
      case SchemeColor.surface:
        return ColorType.surface;
      case SchemeColor.onSurface:
        return ColorType.onSurface;
      case SchemeColor.surfaceVariant:
        return ColorType.surfaceVariant;
      case SchemeColor.onSurfaceVariant:
        return ColorType.onSurfaceVariant;
      case SchemeColor.outline:
        return ColorType.outline;
      case SchemeColor.shadow:
        return ColorType.shadow;
      case SchemeColor.inverseSurface:
        return ColorType.inverseSurface;
      case SchemeColor.onInverseSurface:
        return ColorType.onInverseSurface;
      case SchemeColor.inversePrimary:
        return ColorType.inversePrimary;
      default:
        return null;
    }
  }
}
