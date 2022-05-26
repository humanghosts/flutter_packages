import 'package:flutter/material.dart';

import 'shared/panel.dart';
import 'shared/show_color_scheme_colors.dart';
import 'shared/show_sub_theme_colors.dart';
import 'shared/show_theme_data_colors.dart';

/// 外部参数
@immutable
class EffectiveColorsArgs extends PanelArgs {
  const EffectiveColorsArgs({required super.onTemplateChange});
}

/// 外部数据
@immutable
class EffectiveColorsDataSource extends PanelDataSource {
  const EffectiveColorsDataSource(super.template);
}

/// 逻辑
class EffectiveColorsLogic extends PanelLogic<EffectiveColorsArgs, EffectiveColorsDataSource> {}

/// 页面
class EffectiveColorsView extends PanelView<EffectiveColorsLogic> {
  EffectiveColorsView({
    required String key,
    required EffectiveColorsArgs args,
    required EffectiveColorsDataSource dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, logic: EffectiveColorsLogic());

  @override
  Widget buildView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: ShowColorSchemeColors(),
        ),
        SizedBox(height: 8),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: ShowThemeDataColors(),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: ShowSubThemeColors(showSubtitle: true),
        ),
      ],
    );
  }
}
