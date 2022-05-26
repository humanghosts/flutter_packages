import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:hg_framework/hg_framework.dart';
import 'shared/panel.dart';

import 'shared/color_scheme_popup_menu.dart';

/// 外部参数
@immutable
class TabBarArgs extends PanelArgs {
  const TabBarArgs({required super.onTemplateChange});
}

/// 外部数据
@immutable
class TabBarDataSource extends PanelDataSource {
  const TabBarDataSource(super.template);
}

/// 逻辑
class TabBarLogic extends PanelLogic<TabBarArgs, TabBarDataSource> {
  void setTabBarStyle(FlexTabBarStyle value) {
    template.tabBarStyle.value.style = value;
    args.onTemplateChange();
  }

  void setTabBarItemSchemeColor(SchemeColor? value, bool isLight) {
    if (isLight) {
      template.tabBarItemSchemeColorLight.value.scheme = value;
    } else {
      template.tabBarItemSchemeColorDark.value.scheme = value;
    }
    args.onTemplateChange();
  }

  void setTabBarIndicator(SchemeColor? value, bool isLight) {
    if (isLight) {
      template.tabBarIndicatorLight.value.scheme = value;
    } else {
      template.tabBarIndicatorDark.value.scheme = value;
    }
    args.onTemplateChange();
  }
}

/// 页面
class TabBarView extends PanelView<TabBarLogic> {
  TabBarView({
    required String key,
    required TabBarArgs args,
    required TabBarDataSource dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, logic: TabBarLogic());

  @override
  Widget buildView(BuildContext context) {
    final bool isLight = logic.isLight(context);
    FlexTabBarStyle tabBarStyle = logic.template.tabBarStyle.value.style;
    SchemeColor? tabBarItemSchemeColor =
        isLight ? logic.template.tabBarItemSchemeColorLight.value.scheme : logic.template.tabBarItemSchemeColorDark.value.scheme;

    SchemeColor? tabBarIndicator = isLight ? logic.template.tabBarIndicatorLight.value.scheme : logic.template.tabBarIndicatorDark.value.scheme;
    return Column(
      children: <Widget>[
        ListTile(
          title: const Text('标签栏样式'),
          subtitle: Text(explainTabStyle(tabBarStyle)),
        ),
        ListTile(
          title: Center(
            child: TabBarStyleButtons(
              style: tabBarStyle,
              onChanged: logic.setTabBarStyle,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: TabBarForAppBarShowcase(),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: TabBarForBackgroundShowcase(),
        ),
        ColorSchemePopupMenu(
          title: const Text('标签栏目色彩'),
          labelForDefault: '默认',
          index: tabBarItemSchemeColor?.index ?? -1,
          onChanged: (int index) {
            if (index < 0 || index >= SchemeColor.values.length) {
              logic.setTabBarItemSchemeColor(null, isLight);
            } else {
              logic.setTabBarItemSchemeColor(SchemeColor.values[index], isLight);
            }
          },
        ),
        ColorSchemePopupMenu(
          title: const Text('标签栏指示器色彩'),
          labelForDefault: '默认',
          index: tabBarIndicator?.index ?? -1,
          onChanged: (int index) {
            if (index < 0 || index >= SchemeColor.values.length) {
              logic.setTabBarIndicator(null, isLight);
            } else {
              logic.setTabBarIndicator(SchemeColor.values[index], isLight);
            }
          },
        )
      ],
    );
  }

  String explainTabStyle(final FlexTabBarStyle style) {
    switch (style) {
      case FlexTabBarStyle.forAppBar:
        return 'Style: forAppbar\n'
            'Works with used app bar style, usually the one you want (Default)';
      case FlexTabBarStyle.forBackground:
        return 'Style: forBackground\n'
            'Works on surface colors, like Scaffold, but '
            'also works on surface colored app bars';
      case FlexTabBarStyle.flutterDefault:
        return 'Style: flutterDefault\n'
            'SDK default. Works on primary color in light mode, and '
            'background color in dark mode';
      case FlexTabBarStyle.universal:
        return 'Style: universal\n'
            'Experimental universal style, has '
            'low contrast. May change in future versions';
    }
  }
}

class TabBarStyleButtons extends StatelessWidget {
  const TabBarStyleButtons({
    Key? key,
    this.style,
    this.onChanged,
  }) : super(key: key);
  final FlexTabBarStyle? style;
  final ValueChanged<FlexTabBarStyle>? onChanged;

  @override
  Widget build(BuildContext context) {
    final List<bool> isSelected = <bool>[
      style == FlexTabBarStyle.forAppBar,
      style == FlexTabBarStyle.forBackground,
      style == FlexTabBarStyle.flutterDefault,
      style == FlexTabBarStyle.universal,
    ];
    return ToggleButtons(
      isSelected: isSelected,
      onPressed: onChanged == null
          ? null
          : (int newIndex) {
              onChanged?.call(FlexTabBarStyle.values[newIndex]);
            },
      children: const <Widget>[
        Tooltip(
          message: 'To use in AppBar',
          child: Icon(Icons.tab),
        ),
        Tooltip(
          message: 'To use on background color',
          child: Icon(Icons.tab_unselected),
        ),
        Tooltip(
          message: 'Flutter SDK default',
          child: Icon(Icons.web_asset_outlined),
        ),
        Tooltip(
          message: 'Universal style',
          child: Icon(Icons.crop_3_2),
        ),
      ],
    );
  }
}
