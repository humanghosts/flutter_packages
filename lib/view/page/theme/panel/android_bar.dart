import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

import 'shared/panel.dart';

/// 外部参数
@immutable
class AndroidBarArgs extends PanelArgs {
  const AndroidBarArgs({required super.onTemplateChange});
}

/// 外部数据
@immutable
class AndroidBarDataSource extends PanelDataSource {
  const AndroidBarDataSource(super.template);
}

/// 逻辑
class AndroidBarLogic extends PanelLogic<AndroidBarArgs, AndroidBarDataSource> {
  void setSysNavBarStyle(FlexSystemNavBarStyle value) {
    template.sysNavBarStyle.value.style = value;
    args.onTemplateChange();
  }

  void setSysNavBarOpacity(double value) {
    template.sysNavBarOpacity.value = value;
    args.onTemplateChange();
  }

  void setUseSysNavDivider(bool value) {
    template.useSysNavDivider.value = value;
    args.onTemplateChange();
  }
}

/// 页面
class AndroidBarView extends PanelView<AndroidBarLogic> {
  AndroidBarView({
    required String key,
    required AndroidBarArgs args,
    required AndroidBarDataSource dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, logic: AndroidBarLogic());

  @override
  Widget buildView(BuildContext context) {
    final bool isLight = Theme.of(context).brightness == Brightness.light;
    FlexSystemNavBarStyle sysNavBarStyle = logic.template.sysNavBarStyle.value.style;
    double sysNavBarOpacity = logic.template.sysNavBarOpacity.value;
    // bool useSysNavDivider = logic.template.useSysNavDivider.value;
    final double navBarOpacity = sysNavBarOpacity;

    return Column(
      children: <Widget>[
        const SizedBox(height: 8),
        const ListTile(
          title: Text('Themed Android system navigation bar'),
          subtitle: Text('This feature only has any effect if you '
              'build this application for an Android device. It '
              'demonstrates the usage of the AnnotatedRegion helper '
              'FlexColorScheme themedSystemNavigationBar. These '
              'settings do not have any impact on generated theme setup code. '
              'You have to implement the AnnotatedRegion with the helper '
              'separately.'),
        ),
        const ListTile(
          title: Text('Background opacity'),
          subtitle: Text('System navigation bar opacity'),
        ),
        ListTile(
          title: Slider.adaptive(
            max: 100,
            divisions: 100,
            label: (navBarOpacity * 100).toStringAsFixed(0),
            value: navBarOpacity * 100,
            onChanged: (double value) {
              logic.setSysNavBarOpacity(value / 100);
            },
          ),
          trailing: Padding(
            padding: const EdgeInsetsDirectional.only(end: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  'OPACITY',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  // ignore: lines_longer_than_80_chars
                  '${(navBarOpacity * 100).toStringAsFixed(0)} %',
                  style: Theme.of(context).textTheme.caption!.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        ListTile(
          title: const Text('Android system navigation bar style'),
          subtitle: Text('Using themedSystemNavigationBar\n'
              '${explainStyle(sysNavBarStyle, isLight)}'),
        ),
        ListTile(
          trailing: SystemNavBarStyleButtons(
            style: sysNavBarStyle,
            onChanged: logic.setSysNavBarStyle,
          ),
        ),
        // TODO(rydmike): Put back when issue #100027 is resolved.
        // This switch is removed from demo until issue:
        // https://github.com/flutter/flutter/issues/100027
        // Has been resolved and landed in Flutter stable.
        //
        // SwitchListTileAdaptive(
        //   title: const Text('Android navigation bar divider'),
        //   subtitle: const Text('There is also an extra system built-in '
        //       'scrim on the nav bar when it is enabled. Recommend not '
        //       'enabling it '
        //       'if using opacity or fully transparent version.'),
        //   value: useNavDivider,
        //   onChanged: logic.setUseNavDivider,
        // ),
      ],
    );
  }

  String explainStyle(final FlexSystemNavBarStyle style, final bool isLight) {
    switch (style) {
      case FlexSystemNavBarStyle.system:
        return isLight ? 'System, white with opacity in light mode' : 'System, black with opacity in dark mode';
      case FlexSystemNavBarStyle.surface:
        return 'Surface color, with opacity & alpha blend';
      case FlexSystemNavBarStyle.background:
        return 'Background color, with opacity & alpha blend';
      case FlexSystemNavBarStyle.scaffoldBackground:
        return 'Scaffold background, with opacity & alpha blend';
      case FlexSystemNavBarStyle.transparent:
        return 'Fully transparent regardless of opacity value';
    }
  }
}

class SystemNavBarStyleButtons extends StatelessWidget {
  const SystemNavBarStyleButtons({
    Key? key,
    required this.style,
    required this.onChanged,
  }) : super(key: key);
  final FlexSystemNavBarStyle style;
  final ValueChanged<FlexSystemNavBarStyle> onChanged;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final bool isLight = Theme.of(context).brightness == Brightness.light;

    final List<bool> isSelected = <bool>[
      style == FlexSystemNavBarStyle.system,
      style == FlexSystemNavBarStyle.surface,
      style == FlexSystemNavBarStyle.background,
      style == FlexSystemNavBarStyle.scaffoldBackground,
      style == FlexSystemNavBarStyle.transparent,
    ];
    return ToggleButtons(
      isSelected: isSelected,
      onPressed: (int newIndex) {
        onChanged(FlexSystemNavBarStyle.values[newIndex]);
      },
      children: <Widget>[
        Tooltip(
          message: isLight ? 'Android default\n(White)' : 'Android default\n(Black)',
          child: Icon(Icons.lens, color: isLight ? Colors.white : Colors.black),
        ),
        Tooltip(
          message: 'Themed surface color',
          child: Icon(Icons.lens, color: scheme.surface.darken(5)),
        ),
        Tooltip(
          message: 'Themed background color',
          child: Icon(Icons.lens, color: scheme.background.darken(5)),
        ),
        Tooltip(
          message: 'Themed scaffold background color',
          child: Icon(
            Icons.lens,
            color: Theme.of(context).scaffoldBackgroundColor.darken(5),
          ),
        ),
        const Tooltip(
          message: 'Fully transparent',
          child: Icon(Icons.lens_outlined),
        ),
      ],
    );
  }
}
