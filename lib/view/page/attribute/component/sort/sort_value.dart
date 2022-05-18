import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:hg_logger/ability/route/route.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/main.dart';
import 'package:hg_logger/view/enum/page_states.dart';
import 'package:hg_logger/view/export.dart';
import 'package:hg_orm/hg_orm.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

/// 外部参数
@immutable
class SortValueArgs extends ViewArgs {
  /// 导航id
  final int navigatorId;

  /// 页面状态
  final PageState state;

  final VoidCallback? onRemove;

  const SortValueArgs({
    required this.navigatorId,
    required this.state,
    this.onRemove,
  });
}

/// 外部数据
@immutable
class SortValueDataSource extends ViewDataSource {
  final SortValue sortValue;

  const SortValueDataSource({required this.sortValue});
}

/// 逻辑
class SortValueLogic extends TutorialViewLogic<SortValueArgs, SortValueDataSource> {
  /// 字段 名称(title)
  Rx<String> field = "字段".obs;

  /// 操作符 名称(title)
  Rx<String> op = "".obs;

  @override
  void afterArgsUpdate() {
    SortValue sortValue = dataSource.sortValue;
    Sort? sort = sortValue.sort;
    if (null == sort) {
      field.value = "字段";
      op.value = "";
      return;
    }
    EventFilterField filterField = EventFilterField.map[sort.field]!;
    field.value = filterField.title;
    op.value = sort.op.title;
  }

  /// 设置字段
  void setField(List<int> indexList) {
    if (indexList.isEmpty) return;
    SortValue sortValue = dataSource.sortValue;
    int index = indexList.first;
    Sort? sort = sortValue.sort;
    EventFilterField filterField = EventFilterField.list[index];
    String field = filterField.value;
    if (sort == null) {
      sort = Sort(field: field);
      sortValue.sort = sort;
    } else {
      sort.field = field;
    }
    this.field.value = filterField.title;
    op.value = sort.op.title;
  }

  /// 设置符号
  void setOp(List<int> indexList) {
    if (indexList.isEmpty) return;
    SortValue sortValue = dataSource.sortValue;
    int index = indexList.first;
    Sort sort = sortValue.sort!;
    SortOp op = SortOp.list[index];
    sort.op = op;
    this.op.value = op.title;
  }

  @override
  void buildTutorial() {
    buildAndAddTargetFocus(
      "sort_value",
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) => HgNeumorphicText("排序条件，\n向左滑动可删除该条件"),
        ),
      ],
    );
    buildAndAddTargetFocus(
      "sort_value_field",
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) => HgNeumorphicText("排序条件字段，\n点击可进入字段选择页面"),
        ),
      ],
    );
    buildAndAddTargetFocus(
      "sort_value_op",
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) => HgNeumorphicText("排序条件操作符，\n点击可进入操作符选择页面"),
        ),
      ],
    );
  }

  @override
  String? get tutorialSubKey => "sort_value";

  @override
  HomePages get homePage => HomePages.attribute;
}

/// 页面
class SortValueItem extends View<SortValueLogic> {
  SortValueItem({
    required String key,
    required SortValueArgs args,
    required SortValueDataSource dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, newLogic: SortValueLogic());

  @override
  Widget buildView(BuildContext context) {
    // 当前排序条件
    SortValue sortValue = logic.dataSource.sortValue;
    return Neumorphic(
      key: logic.addTutorialTargetKey(0, "sort_value"),
      child: Removeable(
        groupTag: "sort",
        key: sortValue.hashCode.toString(),
        child: buildSortValue(),
        // 浏览状态不可删除
        onRemove: logic.args.state == PageState.browse ? null : logic.args.onRemove,
        // 值不为空提示是否确定删除
        isShowHint: () => !sortValue.isNull,
      ),
    );
  }

  /// 构建内容
  Widget buildSortValue() {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 字段
          Expanded(flex: 3, child: buildField()),
          // 空置
          Expanded(child: Container()),
          // 排序符号
          Expanded(flex: 3, child: buildOp()),
        ],
      ),
    );
  }

  /// 构建字段
  Widget buildField() {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return HgNeumorphicButton(
      key: logic.addTutorialTargetKey(1, "sort_value_field"),
      padding: const EdgeInsets.all(8),
      fullScreenTooltip: true,
      style: NeumorphicStyle(depth: -themeData.depth),
      getTooltip: () => logic.field.value,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // 定点刷新
          Expanded(
            child: Obx(
              () => Text(
                logic.field.value,
                style: TextStyle(color: logic.dataSource.sortValue.isNull ? themeData.disabledColor : themeData.defaultTextColor),
              ),
            ),
          ),
          HgNeumorphicNextButton(
            padding: const EdgeInsets.all(4),
            onPressed: logic.args.state == PageState.browse ? null : fieldSelect,
          ),
        ],
      ),
      onPressed: logic.args.state == PageState.browse ? () {} : fieldSelect,
    );
  }

  /// 构建操作符
  Widget buildOp() {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return Obx(
      () {
        if (logic.op.isEmpty) return Container();
        return HgNeumorphicButton(
          key: logic.addTutorialTargetKey(2, "sort_value_op"),
          padding: const EdgeInsets.all(8),
          fullScreenTooltip: true,
          style: NeumorphicStyle(depth: -themeData.depth),
          getTooltip: () => logic.op.value,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // 定点刷新
              Expanded(child: Text(logic.op.value, style: TextStyle(color: themeData.defaultTextColor))),
              HgNeumorphicNextButton(
                padding: const EdgeInsets.all(4),
                onPressed: logic.args.state == PageState.browse ? null : opSelect,
              ),
            ],
          ),
          onPressed: logic.args.state == PageState.browse ? () {} : opSelect,
        );
      },
    );
  }

  /// 构建字段选择
  void fieldSelect() {
    SortValue sortValue = logic.dataSource.sortValue;
    // 已选择
    List<int> selected = [];
    Sort? sort = sortValue.sort;
    int index = EventFilterField.list.indexWhere((element) => element.value == sort?.field);
    if (index != -1) selected.add(index);
    RouteHelper.to(
      page: MultiSelect(
        key: "sort_field",
        args: MultiSelectArgs(
          title: "字段",
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
    SortValue sortValue = logic.dataSource.sortValue;
    List<int> selected = [];
    Sort? sort = sortValue.sort;
    if (null == sort) return;
    int index = SortOp.list.indexOf(sort.op);
    if (index != -1) selected.add(index);
    RouteHelper.to(
      page: MultiSelect(
        key: "sort_op",
        args: MultiSelectArgs(
          title: "操作符",
          navigatorId: logic.args.navigatorId,
          itemCount: SortOp.list.length,
          itemBuilder: (context, index, isSelect, action) => Text(SortOp.list[index].title),
          onBack: logic.setOp,
        ),
        dataSource: MultiSelectDataSource(selected: selected),
      ),
      id: logic.args.navigatorId,
    );
  }
}
