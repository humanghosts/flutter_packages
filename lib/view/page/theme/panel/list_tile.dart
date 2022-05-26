import 'package:flutter/material.dart';
import 'package:hg_framework/hg_framework.dart';
import 'shared/panel.dart';

/// 外部参数
@immutable
class ListTileArgs extends PanelArgs {
  const ListTileArgs({required super.onTemplateChange});
}

/// 外部数据
@immutable
class ListTileDataSource extends PanelDataSource {
  const ListTileDataSource(super.template);
}

/// 逻辑
class ListTileLogic extends PanelLogic<ListTileArgs, ListTileDataSource> {
  void setUnselectedToggleIsColored(bool value) {
    template.unselectedToggleIsColored.value = value;
    args.onTemplateChange();
  }
}

/// 页面
class ListTileView extends PanelView<ListTileLogic> {
  ListTileView({
    required String key,
    required ListTileArgs args,
    required ListTileDataSource dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, logic: ListTileLogic());

  @override
  Widget buildView(BuildContext context) {
    bool unselectedToggleIsColored = logic.template.unselectedToggleIsColored.value;

    return Column(
      children: <Widget>[
        SwitchListTileAdaptive(
          title: const Text('未选中的颜色'),
          value: unselectedToggleIsColored,
          onChanged: logic.setUnselectedToggleIsColored,
        ),
        const Divider(height: 1),
        const ListTileShowcase(),
      ],
    );
  }
}
