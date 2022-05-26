import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:hg_framework/hg_framework.dart';

import 'shared/color_scheme_popup_menu.dart';
import 'shared/panel.dart';

/// 外部参数
@immutable
class TextFieldArgs extends PanelArgs {
  const TextFieldArgs({required super.onTemplateChange});
}

/// 外部数据
@immutable
class TextFieldDataSource extends PanelDataSource {
  const TextFieldDataSource(super.template);
}

/// 逻辑
class TextFieldLogic extends PanelLogic<TextFieldArgs, TextFieldDataSource> {
  void setInputDecoratorSchemeColor(SchemeColor? value, bool isLight) {
    if (isLight) {
      template.inputDecoratorSchemeColorLight.value.scheme = value;
    } else {
      template.inputDecoratorSchemeColorDark.value.scheme = value;
    }
    args.onTemplateChange();
  }

  void setInputDecoratorIsFilled(bool value) {
    template.inputDecoratorIsFilled.value = value;
    args.onTemplateChange();
  }

  void setInputDecoratorBorderType(FlexInputBorderType underline) {
    template.inputDecoratorBorderType.value.type = underline;
    args.onTemplateChange();
  }

  void setInputDecoratorBorderRadius(double? d) {
    template.inputDecoratorBorderRadius.value = d;
    args.onTemplateChange();
  }

  void setInputDecoratorUnfocusedHasBorder(bool value) {
    template.inputDecoratorUnfocusedHasBorder.value = value;
    args.onTemplateChange();
  }

  void setInputDecoratorUnfocusedBorderIsColored(bool value) {
    template.inputDecoratorUnfocusedBorderIsColored.value = value;
    args.onTemplateChange();
  }
}

/// 页面
class TextFieldView extends PanelView<TextFieldLogic> {
  TextFieldView({
    required String key,
    required TextFieldArgs args,
    required TextFieldDataSource dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, logic: TextFieldLogic());

  @override
  Widget buildView(BuildContext context) {
    double? defaultInputRadius = logic.template.inputDecoratorBorderRadius.value;
    double? defaultRadius = logic.template.defaultRadius.value;

    final bool isLight = logic.isLight(context);

    SchemeColor? inputDecoratorSchemeColor =
        isLight ? logic.template.inputDecoratorSchemeColorLight.value.scheme : logic.template.inputDecoratorSchemeColorDark.value.scheme;

    final String decoratorRadiusDefaultLabel = defaultInputRadius == null && defaultRadius == null
        ? '默认 20'
        : defaultInputRadius == null && defaultRadius != null
            ? '全局 ${defaultRadius.toStringAsFixed(0)}'
            : '';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 8),
        ColorSchemePopupMenu(
          title: const Text('文本输入框基础色'),
          index: inputDecoratorSchemeColor?.index ?? -1,
          onChanged: (int index) {
            if (index < 0 || index >= SchemeColor.values.length) {
              logic.setInputDecoratorSchemeColor(null, isLight);
            } else {
              logic.setInputDecoratorSchemeColor(SchemeColor.values[index], isLight);
            }
          },
        ),
        SwitchListTileAdaptive(
          title: const Text('填充文本框'),
          value: logic.template.inputDecoratorIsFilled.value,
          onChanged: logic.setInputDecoratorIsFilled,
        ),
        SwitchListTileAdaptive(
          title: const Text('边框样式'),
          subtitle: const Text('打开使用轮廓边框，关闭使用下划线边框'),
          value: logic.template.inputDecoratorBorderType.value.type == FlexInputBorderType.outline,
          onChanged: (bool isOn) {
            if (isOn) {
              logic.setInputDecoratorBorderType(FlexInputBorderType.outline);
            } else {
              logic.setInputDecoratorBorderType(FlexInputBorderType.underline);
            }
          },
        ),
        ListTile(
          title: const Text('边框圆角'),
          subtitle: Slider.adaptive(
            min: -1,
            max: 40,
            divisions: 41,
            label: defaultInputRadius == null || defaultInputRadius < 0 ? decoratorRadiusDefaultLabel : defaultInputRadius.toStringAsFixed(0),
            value: defaultInputRadius ?? -1,
            onChanged: (double value) {
              logic.setInputDecoratorBorderRadius(value < 0 ? null : value);
            },
          ),
          trailing: Padding(
            padding: const EdgeInsetsDirectional.only(end: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('圆角半径', style: Theme.of(context).textTheme.bodySmall),
                Text(
                  defaultInputRadius == null || defaultInputRadius < 0 ? decoratorRadiusDefaultLabel : defaultInputRadius.toStringAsFixed(0),
                  style: Theme.of(context).textTheme.caption!.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        SwitchListTileAdaptive(
          title: const Text('失焦状态是否有边框'),
          value: logic.template.inputDecoratorUnfocusedHasBorder.value,
          onChanged: logic.setInputDecoratorUnfocusedHasBorder,
        ),
        SwitchListTileAdaptive(
          title: const Text('失焦状态边框是否有颜色'),
          value: logic.template.inputDecoratorUnfocusedBorderIsColored.value && logic.template.inputDecoratorUnfocusedHasBorder.value,
          onChanged: logic.template.inputDecoratorUnfocusedHasBorder.value ? logic.setInputDecoratorUnfocusedBorderIsColored : null,
        ),
        const Padding(
          padding: EdgeInsets.all(16),
          child: TextInputField(),
        ),
      ],
    );
  }
}
