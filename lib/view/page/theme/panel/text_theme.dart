import 'package:flutter/material.dart';
import 'package:hg_framework/hg_framework.dart';
import 'shared/panel.dart';

/// 外部参数
@immutable
class TextThemeArgs extends PanelArgs {
  const TextThemeArgs({required super.onTemplateChange});
}

/// 外部数据
@immutable
class TextThemeDataSource extends PanelDataSource {
  const TextThemeDataSource(super.template);
}

/// 逻辑
class TextThemeLogic extends PanelLogic<TextThemeArgs, TextThemeDataSource> {
  void setBlendTextTheme(bool value, bool isLight) {
    if (isLight) {
      template.blendLightTextTheme.value = value;
    } else {
      template.blendDarkTextTheme.value = value;
    }
    args.onTemplateChange();
  }
}

/// 页面
class TextThemeView extends PanelView<TextThemeLogic> {
  TextThemeView({
    required String key,
    required TextThemeArgs args,
    required TextThemeDataSource dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, logic: TextThemeLogic());

  @override
  Widget buildView(BuildContext context) {
    final bool isLight = Theme.of(context).brightness == Brightness.light;

    bool blendLightTextTheme = logic.template.blendLightTextTheme.value;
    bool blendDarkTextTheme = logic.template.blendDarkTextTheme.value;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 8),
        SwitchListTileAdaptive(
          title: const Text('文本主题使用主色'),
          subtitle: const Text('文本颜色中混入一点主色'),
          value: blendLightTextTheme,
          onChanged: (value) => logic.setBlendTextTheme(value, isLight),
        ),
        const Padding(
          padding: EdgeInsets.all(16),
          child: TextThemeShowcase(),
        ),
        SizedBox(
          width: double.infinity,
          child: Material(
            type: MaterialType.card,
            color: Theme.of(context).colorScheme.primary,
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: PrimaryTextThemeShowcase(),
            ),
          ),
        )
      ],
    );
  }
}
