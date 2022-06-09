import 'package:flutter/material.dart';
import 'package:hg_framework/hg_framework.dart';

/// 外部参数
@immutable
class PanelArgs extends ViewArgs {
  final void Function() onTemplateChange;

  const PanelArgs({
    required this.onTemplateChange,
  });
}

/// 外部数据
@immutable
class PanelDataSource extends ViewDataSource {
  final ThemeTemplate template;

  const PanelDataSource(this.template);
}

/// 逻辑
class PanelLogic<A extends PanelArgs, D extends PanelDataSource> extends ViewLogic<A, D> {
  ThemeTemplate get template => dataSource.template;

  bool isLight(BuildContext context) => contextTheme(context).brightness == Brightness.light;

  bool isDark(BuildContext context) => contextTheme(context).brightness == Brightness.dark;

  ThemeData contextTheme(BuildContext context) => Theme.of(context);
}

/// 页面
abstract class PanelView<L extends PanelLogic> extends View<L> {
  PanelView({
    required String key,
    required PanelArgs args,
    required PanelDataSource dataSource,
    required L logic,
  }) : super(key: key, args: args, dataSource: dataSource, logic: logic);
}

/// 外部参数
@immutable
class PanelSampleArgs extends PanelArgs {
  const PanelSampleArgs({required super.onTemplateChange});
}

/// 外部数据
@immutable
class PanelSampleDataSource extends PanelDataSource {
  const PanelSampleDataSource(super.template);
}

/// 逻辑
class PanelSampleLogic extends PanelLogic<PanelSampleArgs, PanelSampleDataSource> {}

/// 页面
class PanelSampleView extends PanelView<PanelSampleLogic> {
  PanelSampleView({
    required String key,
    required PanelSampleArgs args,
    required PanelSampleDataSource dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, logic: PanelSampleLogic());

  @override
  Widget buildView(BuildContext context) {
    return Container();
  }
}
