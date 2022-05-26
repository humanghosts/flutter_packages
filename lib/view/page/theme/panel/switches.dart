import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:hg_framework/hg_framework.dart';
import 'shared/panel.dart';

import 'shared/color_scheme_popup_menu.dart';

/// 外部参数
@immutable
class SwitchesArgs extends PanelArgs {
  const SwitchesArgs({required super.onTemplateChange});
}

/// 外部数据
@immutable
class SwitchesDataSource extends PanelDataSource {
  const SwitchesDataSource(super.template);
}

/// 逻辑
class SwitchesLogic extends PanelLogic<SwitchesArgs, SwitchesDataSource> {
  void setUnselectedToggleIsColored(bool value) {
    template.unselectedToggleIsColored.value = value;
    args.onTemplateChange();
  }

  void setSwitchSchemeColor(SchemeColor? value) {
    template.switchSchemeColor.value.scheme = value;
    args.onTemplateChange();
  }

  void setCheckboxSchemeColor(SchemeColor? value) {
    template.checkboxSchemeColor.value.scheme = value;
    args.onTemplateChange();
  }

  void setRadioSchemeColor(SchemeColor? value) {
    template.radioSchemeColor.value.scheme = value;
    args.onTemplateChange();
  }
}

/// 页面
class SwitchesView extends PanelView<SwitchesLogic> {
  SwitchesView({
    required String key,
    required SwitchesArgs args,
    required SwitchesDataSource dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, logic: SwitchesLogic());

  @override
  Widget buildView(BuildContext context) {
    // final bool isDark = Theme.of(context).brightness == Brightness.dark;

    bool unselectedToggleIsColored = logic.template.unselectedToggleIsColored.value;
    SchemeColor? switchSchemeColor = logic.template.switchSchemeColor.value.scheme;
    SchemeColor? checkboxSchemeColor = logic.template.checkboxSchemeColor.value.scheme;
    SchemeColor? radioSchemeColor = logic.template.radioSchemeColor.value.scheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 8),
        SwitchListTileAdaptive(
          title: const Text('未选中的颜色'),
          value: unselectedToggleIsColored,
          onChanged: logic.setUnselectedToggleIsColored,
        ),
        const Divider(height: 1),
        ColorSchemePopupMenu(
          title: const Text('开关颜色'),
          labelForDefault: '默认 (secondary)',
          index: switchSchemeColor?.index ?? -1,
          onChanged: (int index) {
            if (index < 0 || index >= SchemeColor.values.length) {
              logic.setSwitchSchemeColor(null);
            } else {
              logic.setSwitchSchemeColor(SchemeColor.values[index]);
            }
          },
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: SwitchShowcase(),
        ),
        const Divider(height: 1),
        ColorSchemePopupMenu(
          title: const Text('复选框颜色'),
          labelForDefault: '默认 (secondary)',
          index: checkboxSchemeColor?.index ?? -1,
          onChanged: (int index) {
            if (index < 0 || index >= SchemeColor.values.length) {
              logic.setCheckboxSchemeColor(null);
            } else {
              logic.setCheckboxSchemeColor(SchemeColor.values[index]);
            }
          },
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: CheckboxShowcase(),
        ),
        const Divider(height: 1),
        ColorSchemePopupMenu(
          title: const Text('单选框颜色'),
          labelForDefault: '默认 (secondary)',
          index: radioSchemeColor?.index ?? -1,
          onChanged: (int index) {
            if (index < 0 || index >= SchemeColor.values.length) {
              logic.setRadioSchemeColor(null);
            } else {
              logic.setRadioSchemeColor(SchemeColor.values[index]);
            }
          },
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: RadioShowcase(),
        ),
      ],
    );
  }
}
