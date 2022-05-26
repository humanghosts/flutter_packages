import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:hg_framework/hg_framework.dart';
import 'shared/panel.dart';

import 'shared/color_scheme_popup_menu.dart';

/// 外部参数
@immutable
class ButtonsArgs extends PanelArgs {
  const ButtonsArgs({required super.onTemplateChange});
}

/// 外部数据
@immutable
class ButtonsDataSource extends PanelDataSource {
  const ButtonsDataSource(super.template);
}

/// 逻辑
class ButtonsLogic extends PanelLogic<ButtonsArgs, ButtonsDataSource> {
  void setTextButtonSchemeColor(SchemeColor? value) {
    template.textButtonSchemeColor.value.scheme = value;
    args.onTemplateChange();
  }

  void setTextButtonBorderRadius(double? value) {
    template.textButtonBorderRadius.value = value;
    args.onTemplateChange();
  }

  void setElevatedButtonSchemeColor(SchemeColor? value) {
    template.elevatedButtonSchemeColor.value.scheme = value;
    args.onTemplateChange();
  }

  void setElevatedButtonBorderRadius(double? value) {
    template.elevatedButtonBorderRadius.value = value;
    args.onTemplateChange();
  }

  void setOutlinedButtonSchemeColor(SchemeColor? value) {
    template.outlinedButtonSchemeColor.value.scheme = value;
    args.onTemplateChange();
  }

  void setOutlinedButtonBorderRadius(double? value) {
    template.outlinedButtonBorderRadius.value = value;
    args.onTemplateChange();
  }
}

/// 页面
class ButtonsView extends PanelView<ButtonsLogic> {
  ButtonsView({
    required String key,
    required ButtonsArgs args,
    required ButtonsDataSource dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, logic: ButtonsLogic());

  @override
  Widget buildView(BuildContext context) {
    ThemeData theme = logic.theme(context);
    SchemeColor? textButtonSchemeColor = logic.template.textButtonSchemeColor.value.scheme;
    double? textButtonBorderRadius = logic.template.textButtonBorderRadius.value;
    SchemeColor? elevatedButtonSchemeColor = logic.template.elevatedButtonSchemeColor.value.scheme;
    double? elevatedButtonBorderRadius = logic.template.elevatedButtonBorderRadius.value;
    SchemeColor? outlinedButtonSchemeColor = logic.template.outlinedButtonSchemeColor.value.scheme;
    double? outlinedButtonBorderRadius = logic.template.outlinedButtonBorderRadius.value;

    double? defaultRadius = logic.template.defaultRadius.value;

    final String elevatedButtonRadiusDefaultLabel = elevatedButtonBorderRadius == null && defaultRadius == null
        ? '默认 20'
        : elevatedButtonBorderRadius == null && defaultRadius != null
            ? '全局 ${defaultRadius.toStringAsFixed(0)}'
            : '';
    final String outlinedButtonRadiusDefaultLabel = outlinedButtonBorderRadius == null && defaultRadius == null
        ? '默认 20'
        : outlinedButtonBorderRadius == null && defaultRadius != null
            ? '全局 ${defaultRadius.toStringAsFixed(0)}'
            : '';
    final String textButtonRadiusDefaultLabel = textButtonBorderRadius == null && defaultRadius == null
        ? '默认 20'
        : textButtonBorderRadius == null && defaultRadius != null
            ? '全局 ${defaultRadius.toStringAsFixed(0)}'
            : '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ColorSchemePopupMenu(
          title: const Text('浮动按钮颜色'),
          index: elevatedButtonSchemeColor?.index ?? -1,
          onChanged: (int index) {
            if (index < 0 || index >= SchemeColor.values.length) {
              logic.setElevatedButtonSchemeColor(null);
            } else {
              logic.setElevatedButtonSchemeColor(SchemeColor.values[index]);
            }
          },
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ElevatedButtonShowcase(),
        ),
        ListTile(
          enabled: true && true,
          title: const Text('浮动按钮边框圆角'),
          subtitle: Slider.adaptive(
            min: -1,
            max: 40,
            divisions: 41,
            label: elevatedButtonBorderRadius == null || elevatedButtonBorderRadius < 0
                ? elevatedButtonRadiusDefaultLabel
                : elevatedButtonBorderRadius.toStringAsFixed(0),
            value: elevatedButtonBorderRadius ?? -1,
            onChanged: (double value) {
              logic.setElevatedButtonBorderRadius(value < 0 ? null : value);
            },
          ),
          trailing: Padding(
            padding: const EdgeInsetsDirectional.only(end: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('圆角半径', style: theme.textTheme.bodySmall),
                Text(
                  elevatedButtonBorderRadius == null || elevatedButtonBorderRadius < 0
                      ? elevatedButtonRadiusDefaultLabel
                      : elevatedButtonBorderRadius.toStringAsFixed(0),
                  style: theme.textTheme.caption!.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        ColorSchemePopupMenu(
          title: const Text('轮廓按钮颜色'),
          index: outlinedButtonSchemeColor?.index ?? -1,
          onChanged: (int index) {
            if (index < 0 || index >= SchemeColor.values.length) {
              logic.setOutlinedButtonSchemeColor(null);
            } else {
              logic.setOutlinedButtonSchemeColor(SchemeColor.values[index]);
            }
          },
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: OutlinedButtonShowcase(),
        ),
        ListTile(
          enabled: true && true,
          title: const Text('轮廓按钮边框圆角'),
          subtitle: Slider.adaptive(
            min: -1,
            max: 40,
            divisions: 41,
            label: outlinedButtonBorderRadius == null || outlinedButtonBorderRadius < 0
                ? outlinedButtonRadiusDefaultLabel
                : outlinedButtonBorderRadius.toStringAsFixed(0),
            value: outlinedButtonBorderRadius ?? -1,
            onChanged: (double value) {
              logic.setOutlinedButtonBorderRadius(value < 0 ? null : value);
            },
          ),
          trailing: Padding(
            padding: const EdgeInsetsDirectional.only(end: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('圆角半径', style: theme.textTheme.bodySmall),
                Text(
                  outlinedButtonBorderRadius == null || (outlinedButtonBorderRadius) < 0
                      ? outlinedButtonRadiusDefaultLabel
                      : outlinedButtonBorderRadius.toStringAsFixed(0),
                  style: theme.textTheme.caption!.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        ColorSchemePopupMenu(
          title: const Text('文本按钮颜色'),
          index: textButtonSchemeColor?.index ?? -1,
          onChanged: (int index) {
            if (index < 0 || index >= SchemeColor.values.length) {
              logic.setTextButtonSchemeColor(null);
            } else {
              logic.setTextButtonSchemeColor(SchemeColor.values[index]);
            }
          },
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: TextButtonShowcase(),
        ),
        ListTile(
          enabled: true && true,
          title: const Text('文本按钮边框圆角'),
          subtitle: Slider.adaptive(
            min: -1,
            max: 40,
            divisions: 41,
            label: textButtonBorderRadius == null || textButtonBorderRadius < 0 ? textButtonRadiusDefaultLabel : textButtonBorderRadius.toStringAsFixed(0),
            value: textButtonBorderRadius ?? -1,
            onChanged: (double value) {
              logic.setTextButtonBorderRadius(value < 0 ? null : value);
            },
          ),
          trailing: Padding(
            padding: const EdgeInsetsDirectional.only(end: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('圆角半径', style: theme.textTheme.bodySmall),
                Text(
                  textButtonBorderRadius == null || textButtonBorderRadius < 0 ? textButtonRadiusDefaultLabel : textButtonBorderRadius.toStringAsFixed(0),
                  style: theme.textTheme.caption!.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
