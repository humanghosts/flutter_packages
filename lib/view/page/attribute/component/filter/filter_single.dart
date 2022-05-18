import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:hg_logger/ability/export.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/main.dart';
import 'package:hg_logger/view/enum/page_states.dart';
import 'package:hg_logger/view/export.dart';
import 'package:hg_logger/view/page/attribute/component/filter/filter_value.dart';
import 'package:hg_orm/hg_orm.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

/// 外部参数
@immutable
class FilterSingleEditorArgs extends ViewArgs {
  /// 导航id
  final int navigatorId;

  /// 页面状态
  final PageState state;

  const FilterSingleEditorArgs({required this.navigatorId, required this.state});
}

/// 数据源
@immutable
class FilterSingleDataSource extends ViewDataSource {
  /// 单个条件
  final SingleFilterValue singleFilterValue;

  const FilterSingleDataSource({required this.singleFilterValue});
}

class FilterSingleEditorLogic extends TutorialViewLogic<FilterSingleEditorArgs, FilterSingleDataSource> {
  static const String initFieldStr = "字段";

  /// 字段名称
  Rx<String> field = initFieldStr.obs;

  /// 操作符名称
  Rx<String> op = "".obs;

  /// 值名称
  Rx<String> value = "".obs;
  bool isValueNull = true;

  @override
  void afterArgsUpdate() {
    SingleFilter? singleFilter = dataSource.singleFilterValue.filter;
    if (singleFilter == null) {
      field.value = initFieldStr;
      op.value = "";
      value.value = "";
      isValueNull = true;
      return;
    }
    String filedValue = singleFilter.field;
    EventFilterField filterField = EventFilterField.map[filedValue]!;
    // 字段名称
    field.value = filterField.title;
    // 操作符名称
    op.value = singleFilter.op.name;
    // 值名称
    setValueText();
  }

  /// 设置字段
  void setField(List<int> indexList) {
    if (indexList.isEmpty) return;
    // 过滤条件
    SingleFilter? singleFilter = dataSource.singleFilterValue.filter;
    // 过滤字段
    EventFilterField filterField = EventFilterField.list[indexList.first];
    if (singleFilter == null) {
      singleFilter = SingleFilter(field: filterField.value, op: filterField.opList[0]);
      dataSource.singleFilterValue.filter = singleFilter;
    } else if (singleFilter.field == filterField.value) {
      return;
    } else {
      singleFilter.field = filterField.value;
      singleFilter.op = filterField.opList[0];
      singleFilter.clear();
    }
    field.value = filterField.title;
    op.value = singleFilter.op.name;
    setValueText();
  }

  /// 设置操作符
  void setOp(List<int> indexList) {
    if (indexList.isEmpty) return;
    SingleFilter? filter = dataSource.singleFilterValue.filter;
    if (null == filter) return;
    // 过滤字段
    EventFilterField field = EventFilterField.map[filter.field]!;
    // 操作符号
    List<SingleFilterOp> opList = field.opList;
    // 符号
    SingleFilterOp op = opList[indexList.first];
    if (filter.op == op) return;
    filter.op = op;
    // 清空值
    filter.clear();
    this.op.value = op.name;
    setValueText();
  }

  /// 设置值
  void setValue() {
    setValueText();
  }

  /// 设置value的名称值
  void setValueText() {
    // 过滤条件
    SingleFilter? filter = dataSource.singleFilterValue.filter;
    if (null == filter) {
      value.value = "";
      isValueNull = true;
      return;
    }
    int valueNumbers = filter.op.valueNumbers;
    // 不需要值的操作符，不渲染
    if (valueNumbers <= 0) {
      value.value = "";
      isValueNull = true;
      return;
    }
    // 过滤值
    List<Object> filterValueList = filter.value;
    // 过滤字段
    EventFilterField field = EventFilterField.map[filter.field]!;
    if (filterValueList.isEmpty) {
      value.value = field.valueType.name;
      isValueNull = true;
    } else {
      isValueNull = false;
      // 时间类型值
      if (field.valueType == EventFilterValueType.datetime) {
        if (filter.op == SingleFilterOp.between) {
          value.value = filterValueList.map((e) => e.toString()).join("到");
        } else {
          FilterDateTime filterDateTime = filter.get(0);
          if (filterDateTime.isNull) {
            value.value = field.valueType.name;
            isValueNull = true;
            filter.clear();
          } else {
            value.value = filterDateTime.toString();
          }
        }
      }
      // 实体类型值
      else if (field.valueType == EventFilterValueType.modelList) {
        value.value = (filterValueList.first as List).map((e) => e.toString()).join(",");
      }
      // 字符串类型值
      else {
        value.value = filterValueList.first.toString();
      }
    }
  }

  @override
  void buildTutorial() {
    buildAndAddTargetFocus(
      "single_field",
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) => HgNeumorphicText("子条件字段，\n点击可进入字段选择页面，"
              "\n长按可查看当前所选字段，\n注：可选字段均为事件字段。字段修改之后会清空操作符和值"),
        ),
      ],
    );
    buildAndAddTargetFocus(
      "single_op",
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) => HgNeumorphicText("子条件操作符，\n点击可进入操作符选择页面,"
              "\n长按可查看当前所选操作符，\n注：可选操作符会根据字段变化"),
        ),
      ],
    );
    buildAndAddTargetFocus(
      "single_value",
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) => HgNeumorphicText("子条件值，\n点击可进入值录入页面，"
              "\n长按可查看当前录入值"),
        ),
      ],
    );
  }

  @override
  HomePages get homePage => HomePages.attribute;

  @override
  String? get tutorialSubKey => "filter_single";
}

/// 单个条件
class FilterSingleEditor extends View<FilterSingleEditorLogic> {
  FilterSingleEditor({
    required String key,
    required FilterSingleEditorArgs args,
    required FilterSingleDataSource dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, newLogic: FilterSingleEditorLogic());

  @override
  Widget buildView(BuildContext context) {
    List<Widget> children = [];
    Widget filed = buildField();
    Widget op = buildOp();
    Widget value = buildValue();
    children.add(Expanded(child: filed));
    children.add(Expanded(child: Padding(padding: const EdgeInsets.only(left: 8), child: op)));
    children.add(Expanded(child: Padding(padding: const EdgeInsets.only(left: 8), child: value)));
    return Row(children: children);
  }

  /// 构建字段
  Widget buildField() {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return HgNeumorphicButton(
      key: logic.addTutorialTargetKey(0, "single_field"),
      padding: const EdgeInsets.all(8),
      style: NeumorphicStyle(depth: -themeData.depth),
      getTooltip: () => logic.field.value,
      fullScreenTooltip: true,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Obx(
              () => Text(
                logic.field.value,
                style: TextStyle(
                  color: logic.field.value == FilterSingleEditorLogic.initFieldStr ? themeData.disabledColor : themeData.defaultTextColor,
                ),
              ),
            ),
          ),
          HgNeumorphicNextButton(
            padding: const EdgeInsets.all(4),
            onPressed: logic.args.state == PageState.browse ? null : fieldSelect,
          ),
        ],
      ),
      onPressed: fieldSelect,
    );
  }

  /// 构建操作符
  Widget buildOp() {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return Obx(() {
      if (logic.field.value == FilterSingleEditorLogic.initFieldStr) return Container();
      return HgNeumorphicButton(
        key: logic.addTutorialTargetKey(1, "single_op"),
        fullScreenTooltip: true,
        padding: const EdgeInsets.all(8),
        style: NeumorphicStyle(depth: -themeData.depth),
        getTooltip: () => logic.op.value,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(child: Text(logic.op.value, style: TextStyle(color: themeData.defaultTextColor))),
            HgNeumorphicNextButton(
              padding: const EdgeInsets.all(4),
              onPressed: logic.args.state == PageState.browse ? null : opSelect,
            ),
          ],
        ),
        onPressed: opSelect,
      );
    });
  }

  /// 构建值
  Widget buildValue() {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return Obx(() {
      // 这里使用opacity的原因是 如果组件中不含rx值，就不会触发自动渲染
      if (logic.value.isEmpty && logic.isValueNull) return Container();
      return HgNeumorphicButton(
        key: logic.addTutorialTargetKey(2, "single_value"),
        fullScreenTooltip: true,
        padding: const EdgeInsets.all(8),
        style: NeumorphicStyle(depth: -themeData.depth),
        getTooltip: () => logic.value.value == "" ? "空" : logic.value.value,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Text(
                logic.value.value,
                style: TextStyle(color: logic.isValueNull ? themeData.disabledColor : themeData.defaultTextColor),
              ),
            ),
            HgNeumorphicNextButton(
              padding: const EdgeInsets.all(4),
              onPressed: logic.args.state == PageState.browse ? null : valueSelect,
            ),
          ],
        ),
        onPressed: valueSelect,
      );
    });
  }

  /// 构建字段选择
  void fieldSelect() {
    if (logic.args.state == PageState.browse) return;
    List<int> selected = [];
    SingleFilter? filter = logic.dataSource.singleFilterValue.filter;
    int index = EventFilterField.list.indexWhere((element) => element.value == filter?.field);
    if (index != -1) selected.add(index);
    RouteHelper.to(
      page: MultiSelect(
        key: "filter_single_field",
        args: MultiSelectArgs(
          title: "过滤字段",
          navigatorId: logic.args.navigatorId,
          itemCount: EventFilterField.list.length,
          itemBuilder: (context, index, isSelect, action) => Text(EventFilterField.list[index].title),
          onBack: logic.setField,
        ),
        dataSource: MultiSelectDataSource(selected: selected),
      ),
      id: logic.args.navigatorId,
    );
  }

  /// 构建操作符选择
  void opSelect() {
    if (logic.args.state == PageState.browse) return;
    List<int> selected = [];
    SingleFilter? filter = logic.dataSource.singleFilterValue.filter;
    if (null == filter) return;
    EventFilterField field = EventFilterField.map[filter.field]!;
    List<SingleFilterOp> opList = field.opList;
    int index = opList.indexOf(filter.op);
    if (index != -1) selected.add(index);
    RouteHelper.to(
      page: MultiSelect(
        key: "filter_single_op",
        args: MultiSelectArgs(
          title: "过滤操作符",
          navigatorId: logic.args.navigatorId,
          itemCount: opList.length,
          itemBuilder: (context, index, isSelect, action) => Text(opList[index].name),
          onBack: logic.setOp,
        ),
        dataSource: MultiSelectDataSource(selected: selected),
      ),
      id: logic.args.navigatorId,
    );
  }

  /// 构建值选择
  void valueSelect() {
    if (logic.args.state == PageState.browse) return;
    RouteHelper.to(
      page: FilterValueEditor(
        key: logic.dataSource.singleFilterValue.hashCode.toString(),
        args: FilterValueEditorArgs(
          onBack: logic.setValue,
          navigatorId: logic.args.navigatorId,
        ),
        dataSource: FilterValueEditorDataSource(singleFilter: logic.dataSource.singleFilterValue.filter!),
      ),
      id: logic.args.navigatorId,
    );
  }
}
