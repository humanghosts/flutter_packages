import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:hg_framework/hg_framework.dart';
import 'shared/panel.dart';

import 'shared/color_scheme_popup_menu.dart';

/// 外部参数
@immutable
class NavRailArgs extends PanelArgs {
  const NavRailArgs({required super.onTemplateChange});
}

/// 外部数据
@immutable
class NavRailDataSource extends PanelDataSource {
  const NavRailDataSource(super.template);
}

/// 逻辑
class NavRailLogic extends PanelLogic<NavRailArgs, NavRailDataSource> {
  void setNavRailBackgroundSchemeColor(SchemeColor? value) {
    template.navRailBackgroundSchemeColor.value.scheme = value;
    args.onTemplateChange();
  }

  void setNavRailOpacity(double value) {
    template.navRailOpacity.value = value;
    args.onTemplateChange();
  }

  void setNavigationRailElevation(double value) {
    template.navigationRailElevation.value = value;
    args.onTemplateChange();
  }

  void setNavRailSelectedSchemeColor(SchemeColor? value) {
    template.navRailSelectedSchemeColor.value.scheme = value;
    args.onTemplateChange();
  }

  void setNavRailUnselectedSchemeColor(SchemeColor? value) {
    template.navRailUnselectedSchemeColor.value.scheme = value;
    args.onTemplateChange();
  }

  void setNavRailMuteUnselected(bool value) {
    template.navRailMuteUnselected.value = value;
    args.onTemplateChange();
  }

  void setNavRailLabelType(NavigationRailLabelType value) {
    template.navRailLabelType.value.type = value;
    args.onTemplateChange();
  }

  void setNavRailUseIndicator(bool value) {
    template.navRailUseIndicator.value = value;
    args.onTemplateChange();
  }

  void setNavRailIndicatorSchemeColor(SchemeColor? value) {
    template.navRailIndicatorSchemeColor.value.scheme = value;
    args.onTemplateChange();
  }

  void setNavRailIndicatorOpacity(double? value) {
    template.navRailIndicatorOpacity.value = value;
    args.onTemplateChange();
  }
}

/// 页面
class NavRailView extends PanelView<NavRailLogic> {
  NavRailView({
    required String key,
    required NavRailArgs args,
    required NavRailDataSource dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, logic: NavRailLogic());

  @override
  Widget buildView(BuildContext context) {
    final ThemeData theme = logic.theme(context);
    final TextStyle denseHeader = theme.textTheme.titleMedium!.copyWith(
      fontSize: 13,
    );
    final TextStyle denseBody = theme.textTheme.bodyMedium!.copyWith(fontSize: 12, color: theme.textTheme.bodySmall!.color);

    SchemeColor? navRailBackgroundSchemeColor = logic.template.navRailBackgroundSchemeColor.value.scheme;
    double navRailOpacity = logic.template.navRailOpacity.value;
    var navigationRailElevation = logic.template.navigationRailElevation.value;
    SchemeColor? navRailSelectedSchemeColor = logic.template.navRailSelectedSchemeColor.value.scheme;
    SchemeColor? navRailUnselectedSchemeColor = logic.template.navRailUnselectedSchemeColor.value.scheme;
    var navRailMuteUnselected = logic.template.navRailMuteUnselected.value;
    NavigationRailLabelType navRailLabelType = logic.template.navRailLabelType.value.type;
    bool navRailUseIndicator = logic.template.navRailUseIndicator.value;
    SchemeColor? navRailIndicatorSchemeColor = logic.template.navRailIndicatorSchemeColor.value.scheme;
    double? navRailIndicatorOpacity = logic.template.navRailIndicatorOpacity.value;

    const String labelForDefaultIndicator = '默认 (primary)';
    const String labelForDefaultSelectedItem = '默认 (primary)';
    final String labelForDefaultUnelectedItem = navRailMuteUnselected ? '默认 (onSurface, blend & opacity)' : '默认 (onSurface)';

    final bool navRailIndicatorOpacityEnabled = navRailUseIndicator;
    final double navRailIndicatorOpacityNotNull = navRailIndicatorOpacityEnabled ? (navRailIndicatorOpacity ?? -0.01) : -0.01;
    final double navRailElevation = navigationRailElevation;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 8),
        ColorSchemePopupMenu(
          title: const Text('背景色'),
          labelForDefault: '默认 (background)',
          index: navRailBackgroundSchemeColor?.index ?? -1,
          onChanged: (int index) {
            if (index < 0 || index >= SchemeColor.values.length) {
              logic.setNavRailBackgroundSchemeColor(null);
            } else {
              logic.setNavRailBackgroundSchemeColor(SchemeColor.values[index]);
            }
          },
        ),
        ListTile(
          enabled: true,
          title: const Text('背景不透明度'),
          subtitle: Slider.adaptive(
            max: 100,
            divisions: 100,
            label: (navRailOpacity * 100).toStringAsFixed(0),
            value: navRailOpacity * 100,
            onChanged: (double value) {
              logic.setNavRailOpacity(value / 100);
            },
          ),
          trailing: Padding(
            padding: const EdgeInsetsDirectional.only(end: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text('不透明度', style: theme.textTheme.bodySmall),
                Text(
                  '${(navRailOpacity * 100).toStringAsFixed(0)} %',
                  style: theme.textTheme.caption!.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        // const Divider(),
        ListTile(
          title: const Text('海拔'),
          subtitle: Slider.adaptive(
            max: 24,
            divisions: 48,
            label: navRailElevation.toStringAsFixed(1),
            value: navRailElevation,
            onChanged: logic.setNavigationRailElevation,
          ),
          trailing: Padding(
            padding: const EdgeInsetsDirectional.only(end: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text('海拔', style: theme.textTheme.bodySmall),
                Text(
                  navRailElevation.toStringAsFixed(1),
                  style: theme.textTheme.caption!.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        SwitchListTileAdaptive(
          title: const Text('选中指示器'),
          subtitle: const Text('栏目选中后会高亮'),
          value: navRailUseIndicator,
          onChanged: logic.setNavRailUseIndicator,
        ),
        ColorSchemePopupMenu(
          title: const Text('选中指示器颜色'),
          labelForDefault: labelForDefaultIndicator,
          index: navRailIndicatorSchemeColor?.index ?? -1,
          onChanged: navRailUseIndicator
              ? (int index) {
                  if (index < 0 || index >= SchemeColor.values.length) {
                    logic.setNavRailIndicatorSchemeColor(null);
                  } else {
                    logic.setNavRailIndicatorSchemeColor(SchemeColor.values[index]);
                  }
                }
              : null,
        ),
        ListTile(
          enabled: navRailIndicatorOpacityEnabled,
          title: const Text('选中指示器不透明度'),
          subtitle: Slider.adaptive(
            min: -1,
            max: 100,
            divisions: 101,
            label: navRailIndicatorOpacityEnabled
                ? navRailIndicatorOpacity == null || navRailIndicatorOpacity < 0
                    ? '默认 24%'
                    : (navRailIndicatorOpacity * 100).toStringAsFixed(0)
                : '默认 24%',
            value: navRailIndicatorOpacityNotNull * 100,
            onChanged: navRailIndicatorOpacityEnabled
                ? (double value) {
                    logic.setNavRailIndicatorOpacity(value < 0 ? null : value / 100);
                  }
                : null,
          ),
          trailing: Padding(
            padding: const EdgeInsetsDirectional.only(end: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('不透明度', style: theme.textTheme.bodySmall),
                Text(
                  navRailIndicatorOpacityEnabled
                      ? navRailIndicatorOpacity == null || navRailIndicatorOpacity < 0
                          ? '默认 24%'
                          : '${(navRailIndicatorOpacity * 100).toStringAsFixed(0)} %'
                      : '默认 24%',
                  style: theme.textTheme.caption!.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
        ListTile(
          title: const Text('导航栏收缩时文本状态'),
          subtitle: Text(explainLabelStyle(navRailLabelType)),
          trailing: NavigationRailLabelTypeButtons(
            style: navRailLabelType,
            onChanged: logic.setNavRailLabelType,
          ),
        ),
        NavigationRailShowcase(
          height: 350,
          useAssertWorkAround: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ColorSchemePopupMenu(
                title: const Text('选中栏目颜色'),
                subtitle: const Text('文本和图标'),
                labelForDefault: labelForDefaultSelectedItem,
                index: navRailSelectedSchemeColor?.index ?? -1,
                onChanged: (int index) {
                  if (index < 0 || index >= SchemeColor.values.length) {
                    logic.setNavRailSelectedSchemeColor(null);
                  } else {
                    logic.setNavRailSelectedSchemeColor(SchemeColor.values[index]);
                  }
                },
              ),
              ColorSchemePopupMenu(
                title: const Text('未选中栏目颜色'),
                subtitle: const Text('文本和图标'),
                labelForDefault: labelForDefaultUnelectedItem,
                index: navRailUnselectedSchemeColor?.index ?? -1,
                onChanged: (int index) {
                  if (index < 0 || index >= SchemeColor.values.length) {
                    logic.setNavRailUnselectedSchemeColor(null);
                  } else {
                    logic.setNavRailUnselectedSchemeColor(SchemeColor.values[index]);
                  }
                },
              ),
              SwitchListTileAdaptive(
                title: const Text('暗化未选中栏目'),
                subtitle: const Text('未选中栏目的文本和图标会变暗'),
                value: navRailMuteUnselected,
                onChanged: logic.setNavRailMuteUnselected,
              ),
            ],
          ),
        ),
      ],
    );
  }

  String explainLabelStyle(final NavigationRailLabelType labelStyle) {
    switch (labelStyle) {
      case NavigationRailLabelType.none:
        return '不显示文本';
      case NavigationRailLabelType.selected:
        return '只有选中栏目显示文本';
      case NavigationRailLabelType.all:
        return '显示文本';
    }
  }
}
