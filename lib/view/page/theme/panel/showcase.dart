import 'package:flutter/material.dart';
import 'package:hg_framework/hg_framework.dart';
import 'shared/panel.dart';

import 'shared/show_color_scheme_colors.dart';
import 'shared/show_sub_theme_colors.dart';
import 'shared/show_theme_data_colors.dart';

/// 外部参数
@immutable
class ShowcaseArgs extends PanelArgs {
  const ShowcaseArgs({required super.onTemplateChange});
}

/// 外部数据
@immutable
class ShowcaseDataSource extends PanelDataSource {
  const ShowcaseDataSource(super.template);
}

/// 逻辑
class ShowcaseLogic extends PanelLogic<ShowcaseArgs, ShowcaseDataSource> {}

/// 页面
class ShowcaseView extends PanelView<ShowcaseLogic> {
  ShowcaseView({
    required String key,
    required ShowcaseArgs args,
    required ShowcaseDataSource dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, logic: ShowcaseLogic());

  @override
  Widget buildView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 8),
          const ShowColorSchemeColors(),
          const SizedBox(height: 8),
          const ShowThemeDataColors(),
          const SizedBox(height: 8),
          const ShowSubThemeColors(),
          const Divider(),
          Text('Widgets', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 16),
          const ThemeShowcase(),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
