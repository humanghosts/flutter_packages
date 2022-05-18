import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/view/export.dart';
import 'package:hg_logger/view/page/attribute/component/filter_datetime/filter_datetime_picker.dart';
import 'package:hg_orm/hg_orm.dart';

@immutable
class FilterValueDateTimeEditorArgs extends ViewArgs {
  /// 导航id
  final int navigatorId;

  const FilterValueDateTimeEditorArgs({required this.navigatorId});
}

@immutable
class FilterValueDateTimeEditorDataSource extends ViewDataSource {
  /// 过滤器
  final SingleFilter singleFilter;

  const FilterValueDateTimeEditorDataSource({required this.singleFilter});
}

class FilterValueDateTimeEditorLogic extends ViewLogic<FilterValueDateTimeEditorArgs, FilterValueDateTimeEditorDataSource> {
  /// 设置自定义时间类型的值
  void setValue(int valueIndex, FilterDateTime filterDateTime) {
    dataSource.singleFilter.set(valueIndex, filterDateTime);
  }
}

/// 时间选择
class FilterValueDateTimeEditor extends View<FilterValueDateTimeEditorLogic> {
  FilterValueDateTimeEditor({
    required String key,
    required FilterValueDateTimeEditorArgs args,
    required FilterValueDateTimeEditorDataSource dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, newLogic: FilterValueDateTimeEditorLogic());

  @override
  Widget buildView(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(top: 12, bottom: Get.height * 0.5),
      clipBehavior: Clip.none,
      children: buildDatetimeValue(),
    );
  }

  ///  时间类型
  List<Widget> buildDatetimeValue() {
    SingleFilterOp op = logic.dataSource.singleFilter.op;
    if (op == SingleFilterOp.between) {
      return [
        buildDateTimeSelector(0, "开始"),
        const Padding(padding: EdgeInsets.only(top: 16)),
        buildDateTimeSelector(1, "结束"),
      ];
    } else {
      return [buildDateTimeSelector(0, "日期时间")];
    }
  }

  /// 构建日期时间选择器，如果先设置顺序在后的时间，自动补充前面的
  /// [valueIndex]是在filterValue中的位置
  Widget buildDateTimeSelector(int valueIndex, String title) {
    SingleFilter singleFilter = logic.dataSource.singleFilter;
    // 如果先设置顺序在后的时间，自动补充前面的
    if (singleFilter.value.length < 1 + valueIndex) {
      int distance = valueIndex - singleFilter.value.length;
      for (int i = 0; i <= distance; i++) {
        singleFilter.append(FilterDateTime());
      }
    }
    // 获取当前位置的值
    FilterDateTime filterDateTime = singleFilter.get(valueIndex);
    // 构建一个当前位置值的日期时间选择器
    return NeumorphicFormField(
      title: const Text("日期时间类型", style: TextStyle(fontWeight: FontWeight.bold)),
      child: FilterDateTimePicker(
        key: "${logic.key}_$valueIndex",
        args: FilterDateTimePickerArgs(
          title: title,
          navigatorId: logic.args.navigatorId,
          onChanged: (filterDateTime) => logic.setValue(valueIndex, filterDateTime),
        ),
        dataSource: FilterDateTimePickerDataSource(filterDateTime: filterDateTime),
      ),
    );
  }
}
