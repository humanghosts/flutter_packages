import 'dart:io';

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:hg_framework/hg_framework.dart';
import 'shared/panel.dart';

import 'shared/color_scheme_popup_menu.dart';

/// 外部参数
@immutable
class AppBarArgs extends PanelArgs {
  const AppBarArgs({required super.onTemplateChange});
}

/// 外部数据
@immutable
class AppBarDataSource extends PanelDataSource {
  const AppBarDataSource(super.template);
}

/// 逻辑
class AppBarLogic extends PanelLogic<AppBarArgs, AppBarDataSource> {
  void setAppBarStyle(FlexAppBarStyle style, bool isLight) {
    if (isLight) {
      template.appBarStyleLight.value.style = style;
    } else {
      template.appBarStyleDark.value.style = style;
    }
    args.onTemplateChange();
  }

  void setTransparentStatusBar(bool value) {
    template.transparentStatusBar.value = value;
    args.onTemplateChange();
  }

  void setAppBarElevation(double value, bool isLight) {
    if (isLight) {
      template.appBarElevationLight.value = value;
    } else {
      template.appBarElevationDark.value = value;
    }
    args.onTemplateChange();
  }

  void setAppBarOpacity(double d, bool isLight) {
    if (isLight) {
      template.appBarOpacityLight.value = d;
    } else {
      template.appBarOpacityDark.value = d;
    }
    args.onTemplateChange();
  }

  void setAppBarBackgroundSchemeColor(SchemeColor? value, bool isLight) {
    if (isLight) {
      template.appBarBackgroundSchemeColorLight.value.scheme = value;
    } else {
      template.appBarBackgroundSchemeColorDark.value.scheme = value;
    }
    args.onTemplateChange();
  }
}

/// 页面
class AppBarView extends PanelView<AppBarLogic> {
  AppBarView({
    required String key,
    required AppBarArgs args,
    required AppBarDataSource dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, logic: AppBarLogic());

  @override
  Widget buildView(BuildContext context) {
    final ThemeData theme = logic.theme(context);
    final bool isLight = logic.isLight(context);
    SchemeColor? appBarBackgroundSchemeColor =
        isLight ? logic.template.appBarBackgroundSchemeColorLight.value.scheme : logic.template.appBarBackgroundSchemeColorDark.value.scheme;
    Color? customAppBarColor = isLight ? logic.template.toFlexSchemeColorLight().appBarColor : logic.template.toFlexSchemeColorDark().appBarColor;
    FlexAppBarStyle appBarStyle = isLight ? logic.template.appBarStyleLight.value.style : logic.template.appBarStyleDark.value.style;
    bool transparentStatusBar = logic.template.transparentStatusBar.value;
    double appBarElevation = isLight ? logic.template.appBarElevationLight.value : logic.template.appBarElevationDark.value;
    double appBarOpacity = isLight ? logic.template.appBarOpacityLight.value : logic.template.appBarOpacityDark.value;

    return Column(
      children: <Widget>[
        const SizedBox(height: 8),
        ListTile(
          enabled: appBarBackgroundSchemeColor == null,
          title: const Text('应用栏样式'),
          subtitle: Text(
            explainAppBarStyle(
              appBarBackgroundSchemeColor == null ? logic.template.appBarStyleLight.value.style : FlexAppBarStyle.primary,
              isLight,
            ),
          ),
        ),
        ListTile(
          enabled: appBarBackgroundSchemeColor == null,
          title: Center(
            child: AppBarStyleButtons(
              style: appBarBackgroundSchemeColor == null ? appBarStyle : FlexAppBarStyle.primary,
              onChanged: appBarBackgroundSchemeColor == null ? (style) => logic.setAppBarStyle(style, isLight) : null,
              customAppBarColor: customAppBarColor,
            ),
          ),
        ),
        Visibility(
          visible: Platform.isAndroid,
          child: SwitchListTileAdaptive(
            title: const Text('单色应用栏'),
            subtitle: const Text('开启使用一种颜色，关闭使用两种颜色'),
            value: transparentStatusBar,
            onChanged: logic.setTransparentStatusBar,
          ),
        ),
        ListTile(
          title: const Text('高度'),
          subtitle: Slider.adaptive(
            max: 24,
            divisions: 48,
            label: appBarElevation.toStringAsFixed(1),
            value: appBarElevation,
            onChanged: (value) => logic.setAppBarElevation(value, isLight),
          ),
          trailing: Padding(
            padding: const EdgeInsetsDirectional.only(end: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('高度', style: theme.textTheme.bodySmall),
                Text(
                  appBarElevation.toStringAsFixed(1),
                  style: theme.textTheme.caption!.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        const ListTile(title: Text('不透明度'), subtitle: Text('建议在85%到98%之间')),
        ListTile(
          title: Slider.adaptive(
            max: 100,
            divisions: 100,
            label: (appBarOpacity * 100).toStringAsFixed(0),
            value: appBarOpacity * 100,
            onChanged: (double value) {
              logic.setAppBarOpacity(value / 100, isLight);
            },
          ),
          trailing: Padding(
            padding: const EdgeInsetsDirectional.only(end: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text('不透明度', style: theme.textTheme.bodySmall),
                Text(
                  '${(appBarOpacity * 100).toStringAsFixed(0)} %',
                  style: theme.textTheme.caption!.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        ColorSchemePopupMenu(
          title: const Text('应用栏背景色'),
          labelForDefault: '默认',
          index: appBarBackgroundSchemeColor?.index ?? -1,
          onChanged: (int index) {
            if (index < 0 || index >= SchemeColor.values.length) {
              logic.setAppBarBackgroundSchemeColor(null, isLight);
            } else {
              logic.setAppBarBackgroundSchemeColor(SchemeColor.values[index], isLight);
            }
          },
        ),
      ],
    );
  }

  String explainAppBarStyle(final FlexAppBarStyle style, final bool isLight) {
    switch (style) {
      case FlexAppBarStyle.primary:
        return isLight ? '主色' : '主色';
      case FlexAppBarStyle.material:
        return isLight ? '白色' : '黑色(#121212)';
      case FlexAppBarStyle.surface:
        return '前景色混合主色';
      case FlexAppBarStyle.background:
        return '背景色混合主色';
      case FlexAppBarStyle.custom:
        return '使用辅色';
    }
  }
}

class AppBarStyleButtons extends StatelessWidget {
  const AppBarStyleButtons({
    Key? key,
    this.style,
    this.onChanged,
    this.customAppBarColor,
  }) : super(key: key);
  final FlexAppBarStyle? style;
  final ValueChanged<FlexAppBarStyle>? onChanged;
  final Color? customAppBarColor;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final bool isLight = Theme.of(context).brightness == Brightness.light;
    final List<bool> isSelected = <bool>[
      style == FlexAppBarStyle.primary,
      style == FlexAppBarStyle.material,
      style == FlexAppBarStyle.surface,
      style == FlexAppBarStyle.background,
      style == FlexAppBarStyle.custom,
    ];
    return ToggleButtons(
      isSelected: isSelected,
      onPressed: onChanged == null
          ? null
          : (int newIndex) {
              onChanged?.call(FlexAppBarStyle.values[newIndex]);
            },
      children: <Widget>[
        Tooltip(
          message: '主色',
          child: Icon(Icons.panorama_wide_angle_select, color: scheme.primary),
        ),
        Tooltip(
          message: isLight ? '白色' : "黑色",
          child: Icon(
            Icons.panorama_wide_angle_select,
            color: isLight
                ? FlexColor.materialLightSurface // Colors.white
                : FlexColor.materialDarkSurface, // Color(0xFF121212)
          ),
        ),
        Tooltip(
          message: '前景色混合主色',
          child: Icon(Icons.panorama_wide_angle_select, color: scheme.surface.darken(5)),
        ),
        Tooltip(
          message: '背景色混合主色',
          child: Icon(Icons.panorama_wide_angle_select, color: scheme.background.darken(5)),
        ),
        Tooltip(
          message: '辅色',
          child: Icon(Icons.panorama_wide_angle_select, color: customAppBarColor ?? scheme.secondaryContainer),
        ),
      ],
    );
  }
}
