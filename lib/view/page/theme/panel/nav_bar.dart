import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:hg_framework/hg_framework.dart';
import 'shared/panel.dart';

import 'shared/color_scheme_popup_menu.dart';

/// 外部参数
@immutable
class NavBarArgs extends PanelArgs {
  const NavBarArgs({required super.onTemplateChange});
}

/// 外部数据
@immutable
class NavBarDataSource extends PanelDataSource {
  const NavBarDataSource(super.template);
}

/// 逻辑
class NavBarLogic extends PanelLogic<NavBarArgs, NavBarDataSource> {
  void setNavBarBackgroundSchemeColor(SchemeColor? value) {
    template.navBarBackgroundSchemeColor.value.scheme = value;
    args.onTemplateChange();
  }

  void setNavBarOpacity(double value) {
    template.navBarOpacity.value = value;
    args.onTemplateChange();
  }

  void setNavBarHeight(double? value) {
    template.navBarHeight.value = value;
    args.onTemplateChange();
  }

  void setNavBarSelectedSchemeColor(SchemeColor? value) {
    template.navBarSelectedSchemeColor.value.scheme = value;
    args.onTemplateChange();
  }

  void setNavBarUnselectedSchemeColor(SchemeColor? value) {
    template.navBarUnselectedSchemeColor.value.scheme = value;
    args.onTemplateChange();
  }

  void setNavBarMuteUnselected(bool value) {
    template.navBarMuteUnselected.value = value;
    args.onTemplateChange();
  }

  void setNavBarIndicatorSchemeColor(SchemeColor? value) {
    template.navBarIndicatorSchemeColor.value.scheme = value;
    args.onTemplateChange();
  }

  void setNavBarIndicatorOpacity(double? value) {
    template.navBarIndicatorOpacity.value = value;
    args.onTemplateChange();
  }

  void setNavBarLabelBehavior(NavigationDestinationLabelBehavior value) {
    template.navBarLabelBehavior.value.behavior = value;
    args.onTemplateChange();
  }
}

/// 页面
class NavBarView extends PanelView<NavBarLogic> {
  NavBarView({
    required String key,
    required NavBarArgs args,
    required NavBarDataSource dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, logic: NavBarLogic());

  @override
  Widget buildView(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle denseHeader = theme.textTheme.titleMedium!.copyWith(
      fontSize: 13,
    );
    final TextStyle denseBody = theme.textTheme.bodyMedium!.copyWith(fontSize: 12, color: theme.textTheme.bodySmall!.color);

    SchemeColor? navBarBackgroundSchemeColor = logic.template.navBarBackgroundSchemeColor.value.scheme;
    double navBarOpacity = logic.template.navBarOpacity.value;
    double? navBarHeight = logic.template.navBarHeight.value;
    SchemeColor? navBarSelectedSchemeColor = logic.template.navBarSelectedSchemeColor.value.scheme;
    SchemeColor? navBarUnselectedSchemeColor = logic.template.navBarSelectedSchemeColor.value.scheme;
    bool navBarMuteUnselected = logic.template.navBarMuteUnselected.value;
    SchemeColor? navBarIndicatorSchemeColor = logic.template.navBarIndicatorSchemeColor.value.scheme;
    double? navBarIndicatorOpacity = logic.template.navBarIndicatorOpacity.value;
    NavigationDestinationLabelBehavior navBarLabelBehavior = logic.template.navBarLabelBehavior.value.behavior;

    const String labelForDefaultIndicator = '默认 (主色)';
    const String labelForDefaultSelectedItem = '默认 (主色)';
    final String labelForDefaultUnelectedItem = navBarMuteUnselected ? 'default (onSurface, blend & opacity)' : 'default (onSurface)';

    final double navBarHighlightOpacity = navBarIndicatorOpacity ?? -0.01;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 8),
        ColorSchemePopupMenu(
          title: const Text('背景色'),
          labelForDefault: '默认 (背景色)',
          index: navBarBackgroundSchemeColor?.index ?? -1,
          onChanged: (int index) {
            if (index < 0 || index >= SchemeColor.values.length) {
              logic.setNavBarBackgroundSchemeColor(null);
            } else {
              logic.setNavBarBackgroundSchemeColor(SchemeColor.values[index]);
            }
          },
        ),
        ListTile(
          title: const Text('背景不透明度'),
          subtitle: Slider.adaptive(
            max: 100,
            divisions: 100,
            label: (navBarOpacity * 100).toStringAsFixed(0),
            value: navBarOpacity * 100,
            onChanged: (double value) {
              logic.setNavBarOpacity(value / 100);
            },
          ),
          trailing: Padding(
            padding: const EdgeInsetsDirectional.only(end: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text('不透明度', style: theme.textTheme.bodySmall),
                Text(
                  '${(navBarOpacity * 100).toStringAsFixed(0)} %',
                  style: theme.textTheme.caption!.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        ListTile(
          enabled: true && true,
          title: const Text('长度'),
          subtitle: Slider.adaptive(
            min: 54,
            max: 100,
            divisions: 46,
            label: navBarHeight == null || navBarHeight < 55 ? '默认 62' : navBarHeight.toStringAsFixed(0),
            value: navBarHeight ?? 54,
            onChanged: (double value) {
              logic.setNavBarHeight(value < 55 ? null : value);
            },
          ),
          trailing: Padding(
            padding: const EdgeInsetsDirectional.only(end: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('长度', style: theme.textTheme.bodySmall),
                Text(
                  navBarHeight == null || navBarHeight < 55 ? '默认 62' : navBarHeight.toStringAsFixed(0),
                  style: theme.textTheme.caption!.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        ColorSchemePopupMenu(
          title: const Text('选择指示器色彩'),
          labelForDefault: labelForDefaultIndicator,
          index: navBarIndicatorSchemeColor?.index ?? -1,
          onChanged: (int index) {
            if (index < 0 || index >= SchemeColor.values.length) {
              logic.setNavBarIndicatorSchemeColor(null);
            } else {
              logic.setNavBarIndicatorSchemeColor(SchemeColor.values[index]);
            }
          },
        ),
        ListTile(
          title: const Text('选择指示器不透明度'),
          subtitle: Slider.adaptive(
            min: -1,
            max: 100,
            divisions: 101,
            label: navBarIndicatorOpacity == null || navBarIndicatorOpacity < 0 ? '默认 24%' : (navBarHighlightOpacity * 100).toStringAsFixed(0),
            value: navBarHighlightOpacity * 100,
            onChanged: (double value) {
              logic.setNavBarIndicatorOpacity(value < 0 ? null : value / 100);
            },
          ),
          trailing: Padding(
            padding: const EdgeInsetsDirectional.only(end: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('不透明度', style: theme.textTheme.bodySmall),
                Text(
                  navBarIndicatorOpacity == null || navBarIndicatorOpacity < 0 ? '默认 24%' : '${(navBarHighlightOpacity * 100).toStringAsFixed(0)} %',
                  style: theme.textTheme.caption!.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
        ColorSchemePopupMenu(
          title: const Text('选中栏目色彩'),
          subtitle: const Text('文本和图标'),
          labelForDefault: labelForDefaultSelectedItem,
          index: navBarSelectedSchemeColor?.index ?? -1,
          onChanged: (int index) {
            if (index < 0 || index >= SchemeColor.values.length) {
              logic.setNavBarSelectedSchemeColor(null);
            } else {
              logic.setNavBarSelectedSchemeColor(SchemeColor.values[index]);
            }
          },
        ),
        ColorSchemePopupMenu(
          title: const Text('未选中栏目色彩'),
          subtitle: const Text('文本和图标'),
          labelForDefault: labelForDefaultUnelectedItem,
          index: navBarUnselectedSchemeColor?.index ?? -1,
          onChanged: (int index) {
            if (index < 0 || index >= SchemeColor.values.length) {
              logic.setNavBarUnselectedSchemeColor(null);
            } else {
              logic.setNavBarUnselectedSchemeColor(SchemeColor.values[index]);
            }
          },
        ),
        SwitchListTileAdaptive(
          title: const Text('暗化未选中栏目'),
          subtitle: const Text('未选中的栏目将会变暗'),
          value: navBarMuteUnselected,
          onChanged: logic.setNavBarMuteUnselected,
        ),
        ListTile(
          enabled: true && true,
          title: const Text('文本行为'),
          subtitle: Text(explainLabelStyle(navBarLabelBehavior)),
          trailing: NavigationBarLabelBehaviorButtons(
            labelBehavior: navBarLabelBehavior,
            onChanged: logic.setNavBarLabelBehavior,
          ),
        ),
        const NavigationBarShowcase(),
      ],
    );
  }

  String explainLabelStyle(final NavigationDestinationLabelBehavior labelBehavior) {
    switch (labelBehavior) {
      case NavigationDestinationLabelBehavior.alwaysHide:
        return '栏目没有文本';
      case NavigationDestinationLabelBehavior.onlyShowSelected:
        return '只有选中栏目有文本';
      case NavigationDestinationLabelBehavior.alwaysShow:
        return '所有栏目都有文本';
    }
  }
}
