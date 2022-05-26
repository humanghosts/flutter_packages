import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:hg_framework/hg_framework.dart';
import 'shared/panel.dart';

import 'shared/color_scheme_popup_menu.dart';

/// 外部参数
@immutable
class BottomNavBarArgs extends PanelArgs {
  const BottomNavBarArgs({required super.onTemplateChange});
}

/// 外部数据
@immutable
class BottomNavBarDataSource extends PanelDataSource {
  const BottomNavBarDataSource(super.template);
}

/// 逻辑
class BottomNavBarLogic extends PanelLogic<BottomNavBarArgs, BottomNavBarDataSource> {
  void setBottomNavBarBackgroundSchemeColor(SchemeColor? value) {
    template.bottomNavBarBackgroundSchemeColor.value.scheme = value;
    args.onTemplateChange();
  }

  void setBottomNavigationBarOpacity(double d) {
    template.bottomNavigationBarOpacity.value = d;
    args.onTemplateChange();
  }

  void setBottomNavigationBarElevation(double value) {
    template.bottomNavigationBarElevation.value = value;
    args.onTemplateChange();
  }

  void setBottomNavBarSelectedSchemeColor(SchemeColor? value) {
    template.bottomNavBarSelectedSchemeColor.value.scheme = value;
    args.onTemplateChange();
  }

  void setBottomNavBarUnselectedSchemeColor(SchemeColor? value) {
    template.bottomNavBarUnselectedSchemeColor.value.scheme = value;
    args.onTemplateChange();
  }

  void setBottomNavBarMuteUnselected(bool value) {
    template.bottomNavBarMuteUnselected.value = value;
    args.onTemplateChange();
  }

  void setBottomNavShowSelectedLabels(bool value) {
    template.bottomNavShowSelectedLabels.value = value;
    args.onTemplateChange();
  }

  void setBottomNavShowUnselectedLabels(bool value) {
    template.bottomNavShowUnselectedLabels.value = value;
    args.onTemplateChange();
  }
}

/// 页面
class BottomNavBarView extends PanelView<BottomNavBarLogic> {
  BottomNavBarView({
    required String key,
    required BottomNavBarArgs args,
    required BottomNavBarDataSource dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, logic: BottomNavBarLogic());

  @override
  Widget buildView(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle denseHeader = theme.textTheme.titleMedium!.copyWith(fontSize: 13);
    final TextStyle denseBody = theme.textTheme.bodyMedium!.copyWith(fontSize: 12, color: theme.textTheme.bodySmall!.color);
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    SchemeColor? bottomNavBarSelectedSchemeColor = logic.template.bottomNavBarSelectedSchemeColor.value.scheme;
    SchemeColor? bottomNavBarUnselectedSchemeColor = logic.template.bottomNavBarUnselectedSchemeColor.value.scheme;
    SchemeColor? bottomNavBarBackgroundSchemeColor = logic.template.bottomNavBarBackgroundSchemeColor.value.scheme;
    bool bottomNavBarMuteUnselected = logic.template.bottomNavBarMuteUnselected.value;
    double bottomNavigationBarElevation = logic.template.bottomNavigationBarElevation.value;
    double bottomNavigationBarOpacity = logic.template.bottomNavigationBarOpacity.value;

    bool bottomNavShowSelectedLabels = logic.template.bottomNavShowSelectedLabels.value;
    bool bottomNavShowUnselectedLabels = logic.template.bottomNavShowUnselectedLabels.value;

    final String labelForDefaultUnelectedItem = bottomNavBarMuteUnselected
        ? 'default (onSurface, blend & opacity)'
        : isDark
            ? 'default (white70)'
            : 'default (black54)';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 8),
        ColorSchemePopupMenu(
          title: const Text('背景色'),
          labelForDefault: '默认',
          index: bottomNavBarBackgroundSchemeColor?.index ?? -1,
          onChanged: (int index) {
            if (index < 0 || index >= SchemeColor.values.length) {
              logic.setBottomNavBarBackgroundSchemeColor(null);
            } else {
              logic.setBottomNavBarBackgroundSchemeColor(SchemeColor.values[index]);
            }
          },
        ),
        ListTile(
          title: const Text('背景不透明度'),
          subtitle: Slider.adaptive(
            max: 100,
            divisions: 100,
            label: (bottomNavigationBarOpacity * 100).toStringAsFixed(0),
            value: bottomNavigationBarOpacity * 100,
            onChanged: (double value) {
              logic.setBottomNavigationBarOpacity(value / 100);
            },
          ),
          trailing: Padding(
            padding: const EdgeInsetsDirectional.only(end: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text('不透明度', style: Theme.of(context).textTheme.bodySmall),
                Text(
                  '${(bottomNavigationBarOpacity * 100).toStringAsFixed(0)} %',
                  style: Theme.of(context).textTheme.caption!.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        ListTile(
          title: const Text('高度'),
          subtitle: Slider.adaptive(
            max: 24,
            divisions: 48,
            label: bottomNavigationBarElevation.toStringAsFixed(1),
            value: bottomNavigationBarElevation,
            onChanged: logic.setBottomNavigationBarElevation,
          ),
          trailing: Padding(
            padding: const EdgeInsetsDirectional.only(end: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text('高度', style: Theme.of(context).textTheme.bodySmall),
                Text(
                  bottomNavigationBarElevation.toStringAsFixed(1),
                  style: Theme.of(context).textTheme.caption!.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        ColorSchemePopupMenu(
          title: const Text('选中栏目色彩'),
          subtitle: const Text('文本和图标'),
          labelForDefault: '默认',
          index: bottomNavBarSelectedSchemeColor?.index ?? -1,
          onChanged: (int index) {
            if (index < 0 || index >= SchemeColor.values.length) {
              logic.setBottomNavBarSelectedSchemeColor(null);
            } else {
              logic.setBottomNavBarSelectedSchemeColor(SchemeColor.values[index]);
            }
          },
        ),
        ColorSchemePopupMenu(
          title: const Text('未选中栏目色彩'),
          subtitle: const Text('文本和图标'),
          labelForDefault: labelForDefaultUnelectedItem,
          index: bottomNavBarUnselectedSchemeColor?.index ?? -1,
          onChanged: (int index) {
            if (index < 0 || index >= SchemeColor.values.length) {
              logic.setBottomNavBarUnselectedSchemeColor(null);
            } else {
              logic.setBottomNavBarUnselectedSchemeColor(SchemeColor.values[index]);
            }
          },
        ),
        SwitchListTileAdaptive(
          title: const Text('暗化未选中栏目'),
          subtitle: const Text('未选中栏目的文本和图标将会变暗'),
          value: bottomNavBarMuteUnselected,
          onChanged: logic.setBottomNavBarMuteUnselected,
        ),
        SwitchListTileAdaptive(
          title: const Text('显示选中栏目的文本'),
          value: bottomNavShowSelectedLabels,
          onChanged: logic.setBottomNavShowSelectedLabels,
        ),
        SwitchListTileAdaptive(
          title: const Text('显示未选中栏目的文本'),
          value: bottomNavShowUnselectedLabels,
          onChanged: logic.setBottomNavShowUnselectedLabels,
        ),
        const SizedBox(height: 8),
        const BottomNavigationBarShowcase(),
      ],
    );
  }
}
