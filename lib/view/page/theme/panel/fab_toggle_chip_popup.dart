import 'dart:math' as math;

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:hg_framework/hg_framework.dart';
import 'shared/panel.dart';

import 'shared/color_scheme_popup_menu.dart';

/// 外部参数
@immutable
class FabToggleChipPopupArgs extends PanelArgs {
  const FabToggleChipPopupArgs({required super.onTemplateChange});
}

/// 外部数据
@immutable
class FabToggleChipPopupDataSource extends PanelDataSource {
  const FabToggleChipPopupDataSource(super.template);
}

/// 逻辑
class FabToggleChipPopupLogic extends PanelLogic<FabToggleChipPopupArgs, FabToggleChipPopupDataSource> {
  void setFabBorderRadius(double? value) {
    template.fabBorderRadius.value = value;
    args.onTemplateChange();
  }

  void setFabSchemeColor(SchemeColor? value) {
    template.fabSchemeColor.value.scheme = value;
    args.onTemplateChange();
  }

  void setChipSchemeColor(SchemeColor? value) {
    template.chipSchemeColor.value.scheme = value;
    args.onTemplateChange();
  }

  void setChipBorderRadius(double? value) {
    template.chipBorderRadius.value = value;
    args.onTemplateChange();
  }

  void setPopupMenuOpacity(double value) {
    template.popupMenuOpacity.value = value;
    args.onTemplateChange();
  }

  void setPopupMenuBorderRadius(double? value) {
    template.popupMenuBorderRadius.value = value;
    args.onTemplateChange();
  }

  void setToggleButtonsSchemeColor(SchemeColor? value) {
    template.toggleButtonsSchemeColor.value.scheme = value;
    args.onTemplateChange();
  }

  void setToggleButtonsBorderRadius(double? value) {
    template.toggleButtonsBorderRadius.value = value;
    args.onTemplateChange();
  }

  void setTooltipsMatchBackground(bool value) {
    template.tooltipsMatchBackground.value = value;
    args.onTemplateChange();
  }
}

/// 页面
class FabToggleChipPopupView extends PanelView<FabToggleChipPopupLogic> {
  FabToggleChipPopupView({
    required String key,
    required FabToggleChipPopupArgs args,
    required FabToggleChipPopupDataSource dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, logic: FabToggleChipPopupLogic());

  @override
  Widget buildView(BuildContext context) {
    double? fabBorderRadius = logic.template.fabBorderRadius.value;
    SchemeColor? fabSchemeColor = logic.template.fabSchemeColor.value.scheme;
    SchemeColor? chipSchemeColor = logic.template.chipSchemeColor.value.scheme;
    double? chipBorderRadius = logic.template.chipBorderRadius.value;
    double popupMenuOpacity = logic.template.popupMenuOpacity.value;
    double? popupMenuBorderRadius = logic.template.popupMenuBorderRadius.value;
    double? defaultRadius = logic.template.defaultRadius.value;
    SchemeColor? toggleButtonsSchemeColor = logic.template.toggleButtonsSchemeColor.value.scheme;
    double? toggleButtonsBorderRadius = logic.template.toggleButtonsBorderRadius.value;
    bool tooltipsMatchBackground = logic.template.tooltipsMatchBackground.value;
    final String fabRadiusDefaultLabel = fabBorderRadius == null && defaultRadius == null
        ? '默认 16'
        : fabBorderRadius == null && defaultRadius != null
            ? '全局 ${defaultRadius.toStringAsFixed(0)}'
            : '';
    final String toggleButtonRadiusDefaultLabel = toggleButtonsBorderRadius == null && defaultRadius == null
        ? '默认 20'
        : toggleButtonsBorderRadius == null && defaultRadius != null
            ? '全局 ${defaultRadius.toStringAsFixed(0)}'
            : '';
    final String chipRadiusDefaultLabel = chipBorderRadius == null && defaultRadius == null
        ? '默认 8'
        : chipBorderRadius == null && defaultRadius != null
            ? '全局 ${defaultRadius.toStringAsFixed(0)}'
            : '';

    final double popupEffectiveRadius = popupMenuBorderRadius ?? math.min(defaultRadius ?? 4.0, 10.0);
    final String popupMenuDefaultLabel = popupMenuBorderRadius == null && defaultRadius == null
        ? '默认 4'
        : popupMenuBorderRadius == null && defaultRadius != null
            ? '全局 ${popupEffectiveRadius.toStringAsFixed(0)}'
            : '';
    final double popupOpacity = popupMenuOpacity;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 8),
        ColorSchemePopupMenu(
          title: const Text('浮动操作按钮颜色'),
          labelForDefault: '默认 (secondary)',
          index: fabSchemeColor?.index ?? -1,
          onChanged: (int index) {
            if (index < 0 || index >= SchemeColor.values.length) {
              logic.setFabSchemeColor(null);
            } else {
              logic.setFabSchemeColor(SchemeColor.values[index]);
            }
          },
        ),
        ListTile(
          enabled: true && true,
          title: const Text('边框圆角'),
          subtitle: Slider.adaptive(
            min: -1,
            max: 40,
            divisions: 41,
            label: fabBorderRadius == null || fabBorderRadius < 0 ? fabRadiusDefaultLabel : fabBorderRadius.toStringAsFixed(0),
            value: fabBorderRadius ?? -1,
            onChanged: (double value) {
              logic.setFabBorderRadius(value < 0 ? null : value);
            },
          ),
          trailing: Padding(
            padding: const EdgeInsetsDirectional.only(end: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('圆角半径', style: Theme.of(context).textTheme.bodySmall),
                Text(
                  fabBorderRadius == null || fabBorderRadius < 0 ? fabRadiusDefaultLabel : fabBorderRadius.toStringAsFixed(0),
                  style: Theme.of(context).textTheme.caption!.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: FabShowcase(),
        ),
        const Divider(),
        ColorSchemePopupMenu(
          title: const Text('切换按钮颜色'),
          index: toggleButtonsSchemeColor?.index ?? -1,
          onChanged: (int index) {
            if (index < 0 || index >= SchemeColor.values.length) {
              logic.setToggleButtonsSchemeColor(null);
            } else {
              logic.setToggleButtonsSchemeColor(SchemeColor.values[index]);
            }
          },
        ),
        ListTile(
          title: const Text('边框圆角'),
          subtitle: Slider.adaptive(
            min: -1,
            max: 40,
            divisions: 41,
            label: toggleButtonsBorderRadius == null || toggleButtonsBorderRadius < 0
                ? toggleButtonRadiusDefaultLabel
                : toggleButtonsBorderRadius.toStringAsFixed(0),
            value: toggleButtonsBorderRadius ?? -1,
            onChanged: (double value) {
              logic.setToggleButtonsBorderRadius(value < 0 ? null : value);
            },
          ),
          trailing: Padding(
            padding: const EdgeInsetsDirectional.only(end: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('圆角半径', style: Theme.of(context).textTheme.bodySmall),
                Text(
                  toggleButtonsBorderRadius == null || toggleButtonsBorderRadius < 0
                      ? toggleButtonRadiusDefaultLabel
                      : toggleButtonsBorderRadius.toStringAsFixed(0),
                  style: Theme.of(context).textTheme.caption!.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: ToggleButtonsShowcase(),
        ),
        const Divider(),
        ColorSchemePopupMenu(
          title: const Text('标签基础颜色'),
          index: chipSchemeColor?.index ?? -1,
          onChanged: (int index) {
            if (index < 0 || index >= SchemeColor.values.length) {
              logic.setChipSchemeColor(null);
            } else {
              logic.setChipSchemeColor(SchemeColor.values[index]);
            }
          },
        ),
        ListTile(
          title: const Text('标签边框圆角'),
          subtitle: Slider.adaptive(
            min: -1,
            max: 40,
            divisions: 41,
            label: chipBorderRadius == null || chipBorderRadius < 0 ? chipRadiusDefaultLabel : chipBorderRadius.toStringAsFixed(0),
            value: chipBorderRadius ?? -1,
            onChanged: (double value) {
              logic.setChipBorderRadius(value < 0 ? null : value);
            },
          ),
          trailing: Padding(
            padding: const EdgeInsetsDirectional.only(end: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('圆角半径', style: Theme.of(context).textTheme.bodySmall),
                Text(
                  chipBorderRadius == null || chipBorderRadius < 0 ? chipRadiusDefaultLabel : chipBorderRadius.toStringAsFixed(0),
                  style: Theme.of(context).textTheme.caption!.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: ChipShowcase(),
        ),
        const Divider(),
        ListTile(
          title: const Text('弹出菜单不透明度'),
          subtitle: Slider.adaptive(
            max: 100,
            divisions: 100,
            label: (popupOpacity * 100).toStringAsFixed(0),
            value: popupOpacity * 100,
            onChanged: (double value) {
              logic.setPopupMenuOpacity(value / 100);
            },
          ),
          trailing: Padding(
            padding: const EdgeInsetsDirectional.only(end: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text('不透明度', style: Theme.of(context).textTheme.bodySmall),
                Text(
                  '${(popupOpacity * 100).toStringAsFixed(0)} %',
                  style: Theme.of(context).textTheme.caption!.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        ListTile(
          title: const Text('边框圆角'),
          subtitle: Slider.adaptive(
            min: -1,
            max: 12,
            divisions: 13,
            label: popupMenuBorderRadius == null || popupMenuBorderRadius < 0 ? popupMenuDefaultLabel : popupMenuBorderRadius.toStringAsFixed(0),
            value: popupMenuBorderRadius ?? -1,
            onChanged: (double value) {
              logic.setPopupMenuBorderRadius(value < 0 ? null : value);
            },
          ),
          trailing: Padding(
            padding: const EdgeInsetsDirectional.only(end: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('圆角半径', style: Theme.of(context).textTheme.bodySmall),
                Text(
                  popupMenuBorderRadius == null || popupMenuBorderRadius < 0 ? popupMenuDefaultLabel : popupMenuBorderRadius.toStringAsFixed(0),
                  style: Theme.of(context).textTheme.caption!.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: PopupMenuShowcase(popupRadius: popupEffectiveRadius)),
        const Divider(),
        const ListTile(title: Text('图标按钮, 圆形头像, 下拉按钮 和 提示')),
        SwitchListTileAdaptive(
          title: const Text('提示背景色'),
          subtitle: const Text('关闭使用反色，打开使用主色'),
          value: tooltipsMatchBackground,
          onChanged: logic.setTooltipsMatchBackground,
        ),
        const Padding(
          padding: EdgeInsets.all(16),
          child: IconButtonCircleAvatarDropdownTooltipShowcase(),
        ),
      ],
    );
  }
}
