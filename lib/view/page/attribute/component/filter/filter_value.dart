import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hg_logger/ability/export.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/view/export.dart';
import 'package:hg_orm/hg_orm.dart';

import 'filter_value_datetime.dart';
import 'filter_value_input.dart';
import 'filter_value_model.dart';

/// 参数
@immutable
class FilterValueEditorArgs extends ViewArgs {
  /// 导航id
  final int navigatorId;

  /// 返回回调
  final VoidCallback? onBack;

  const FilterValueEditorArgs({
    required this.navigatorId,
    this.onBack,
  });
}

/// 数据源
@immutable
class FilterValueEditorDataSource extends ViewDataSource {
  final SingleFilter singleFilter;

  const FilterValueEditorDataSource({required this.singleFilter});
}

class FilterValueEditorLogic extends ViewLogic<FilterValueEditorArgs, FilterValueEditorDataSource> {
  /// 返回
  void back() {
    RouteHelper.back(id: args.navigatorId);
  }

  /// 页面退出时调用
  void onBack() {
    args.onBack?.call();
  }
}

class FilterValueEditor extends View<FilterValueEditorLogic> with ObserverWidget {
  FilterValueEditor({
    required String key,
    required FilterValueEditorArgs args,
    required FilterValueEditorDataSource dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, newLogic: FilterValueEditorLogic());

  @override
  void observe(ObserverRouting? routing) {
    if (routing?.isBack == true) {
      logic.onBack();
    }
  }

  @override
  Widget buildView(BuildContext context) {
    SingleFilter filter = logic.dataSource.singleFilter;
    EventFilterField field = EventFilterField.map[filter.field]!;
    return HgNeumorphicScaffold(
      leading: HgNeumorphicBackButton(onPressed: logic.back),
      title: HgNeumorphicText(field.title + filter.op.name),
      bodyPadding: const EdgeInsets.symmetric(horizontal: 12),
      body: buildValue(),
    );
  }

  /// 构建值
  Widget buildValue() {
    SingleFilter filter = logic.dataSource.singleFilter;
    int valueNumbers = filter.op.valueNumbers;
    // 不需要值的操作符，不渲染
    if (valueNumbers <= 0) return Container();
    EventFilterField field = EventFilterField.map[filter.field]!;
    // 时间类型值
    if (field.valueType == EventFilterValueType.datetime) {
      return FilterValueDateTimeEditor(
        key: logic.key,
        args: FilterValueDateTimeEditorArgs(navigatorId: logic.args.navigatorId),
        dataSource: FilterValueDateTimeEditorDataSource(singleFilter: logic.dataSource.singleFilter),
      );
    }
    // 实体类型值
    else if (field.valueType == EventFilterValueType.modelList) {
      return FilterValueModelEditor(
        key: logic.key,
        args: FilterValueModelEditorArgs(),
        dataSource: FilterValueModelEditorDataSource(singleFilter: logic.dataSource.singleFilter),
      );
    }
    // 字符串类型值
    else {
      return FilterValueInputEditor(
        key: logic.key,
        args: FilterValueInputEditorArgs(),
        dataSource: FilterValueInputEditorDataSource(singleFilter: logic.dataSource.singleFilter),
      );
    }
  }
}
