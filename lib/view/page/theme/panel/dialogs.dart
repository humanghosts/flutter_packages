import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:hg_framework/hg_framework.dart';
import 'shared/panel.dart';

import 'shared/color_scheme_popup_menu.dart';

/// 外部参数
@immutable
class DialogsArgs extends PanelArgs {
  const DialogsArgs({required super.onTemplateChange});
}

/// 外部数据
@immutable
class DialogsDataSource extends PanelDataSource {
  const DialogsDataSource(super.template);
}

/// 逻辑
class DialogsLogic extends PanelLogic<DialogsArgs, DialogsDataSource> {
  void setDialogBackgroundSchemeColor(SchemeColor? value) {
    template.dialogBackgroundSchemeColor.value.scheme = value;
    args.onTemplateChange();
  }

  void setDialogBorderRadius(double? value) {
    template.dialogBorderRadius.value = value;
    args.onTemplateChange();
  }
}

/// 页面
class DialogsView extends PanelView<DialogsLogic> {
  DialogsView({
    required String key,
    required DialogsArgs args,
    required DialogsDataSource dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, logic: DialogsLogic());

  @override
  Widget buildView(BuildContext context) {
    SchemeColor? dialogBackgroundSchemeColor = logic.template.dialogBackgroundSchemeColor.value.scheme;
    double? dialogBorderRadius = logic.template.dialogBorderRadius.value;
    double? defaultRadius = logic.template.defaultRadius.value;
    final String dialogRadiusDefaultLabel = dialogBorderRadius == null && defaultRadius == null
        ? '默认 28'
        : dialogBorderRadius == null && defaultRadius != null
            ? '全局 ${defaultRadius.toStringAsFixed(0)}'
            : '';
    return Column(
      children: <Widget>[
        ColorSchemePopupMenu(
          title: const Text('背景色'),
          labelForDefault: '默认 (surface)',
          index: dialogBackgroundSchemeColor?.index ?? -1,
          onChanged: (int index) {
            if (index < 0 || index >= SchemeColor.values.length) {
              logic.setDialogBackgroundSchemeColor(null);
            } else {
              logic.setDialogBackgroundSchemeColor(SchemeColor.values[index]);
            }
          },
        ),
        ListTile(
          title: const Text('边框圆角'),
          subtitle: Slider.adaptive(
            min: -1,
            max: 50,
            divisions: 51,
            label: dialogBorderRadius == null || dialogBorderRadius < 0 ? dialogRadiusDefaultLabel : dialogBorderRadius.toStringAsFixed(0),
            value: dialogBorderRadius ?? -1,
            onChanged: (double value) {
              logic.setDialogBorderRadius(value < 0 ? null : value);
            },
          ),
          trailing: Padding(
            padding: const EdgeInsetsDirectional.only(end: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('圆角半径', style: Theme.of(context).textTheme.bodySmall),
                Text(
                  dialogBorderRadius == null || dialogBorderRadius < 0 ? dialogRadiusDefaultLabel : dialogBorderRadius.toStringAsFixed(0),
                  style: Theme.of(context).textTheme.caption!.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        const AlertDialogShowcase(),
        const TimePickerDialogShowcase(),
        const DatePickerDialogShowcase(),
      ],
    );
  }
}
