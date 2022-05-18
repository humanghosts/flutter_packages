import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:hg_logger/ability/route/route.dart';
import 'package:hg_logger/entity/data/tag.dart';
import 'package:hg_logger/main.dart';
import 'package:hg_logger/view/component/export.dart';
import 'package:hg_logger/view/page/attribute/attribute_detail.dart';
import 'package:hg_logger/view/page/attribute/component/expansion.dart';
import 'package:hg_logger/view/page/attribute/component/sort/sort.dart';
import 'package:hg_logger/view/page/attribute/component/to_string.dart';
import 'package:hg_orm/hg_orm.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../component/filter/filter_group.dart';

/// 标签明细逻辑
class TagDetailLogic extends AttributeDetailLogic<Tag> {
  /// 标签过滤条件关系
  Rx<bool> isAndFilter = false.obs;

  /// 过滤条件描述
  Rx<String> conditionText = "".obs;

  /// 排序条件描述
  Rx<String> sortText = "".obs;

  /// 打开回调 更新值
  @override
  void afterArgsUpdate() {
    super.afterArgsUpdate();
    isAndFilter.value = dataSource.data.isAndFilter.value;
    setConditionText();
    setSortText();
  }

  /// 设置关系
  void setIsAndFilter(bool? value) {
    bool finalValue = value ?? !isAndFilter.value;
    dataSource.data.isAndFilter.value = finalValue;
    isAndFilter.value = finalValue;
  }

  /// 设置过滤条件描述
  void setConditionText() {
    String? text = getConditionText();
    conditionText.value = text ?? "";
  }

  String? getConditionText({bool format = false}) {
    return groupFilterToString(dataSource.data.filter.value, format: format);
  }

  /// 设置排序条件描述
  void setSortText() {
    String? text = getSortText();
    sortText.value = text ?? "";
  }

  /// 获取排序条件描述
  String? getSortText({bool format = false}) {
    List<SortValue> sortValueList = dataSource.data.sort.value;
    List<String> sortValueStrList = [];
    for (var sortValue in sortValueList) {
      String? sortStr = sortToString(sortValue);
      if (null == sortStr) continue;
      if (sortStr.isNotEmpty) {
        sortValueStrList.add("${format ? "    " : ""}$sortStr");
      }
    }
    if (sortValueStrList.isEmpty) return null;
    return "[${format ? "\n" : ""}${sortValueStrList.join(",${format ? "\n" : ""}")}${format ? "\n" : ""}]";
  }

  @override
  String? get tutorialSubKey => "detail_tag";

  @override
  void buildTutorial() {
    super.buildTutorial();
    buildAndAddTargetFocus(
      "relation",
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) => HgNeumorphicText("标签与过滤条件关系，\n点击可修改，长按可以查看按钮功能说明。"
              "\n注：大部分按钮长按可查看内容或按钮功能呢说明"),
        ),
      ],
    );
    buildAndAddTargetFocus(
      "filter",
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) => HgNeumorphicText("标签过滤条件，\n用于事件页面按条件检索事件，"
              "\n点击进入过滤条件设置页面，\n长按查看当前过滤条件或按钮功能说明"),
        ),
      ],
    );
    buildAndAddTargetFocus(
      "sort",
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) => HgNeumorphicText("标签排序条件，\n用于事件页面按条件和标签检索到的事件排序"),
        ),
      ],
    );
  }

  @override
  bool get isTutorial => (!args.isIntro) && super.isTutorial;
}

/// 标签明细页面
class TagDetail extends AttributeDetail<Tag, TagDetailLogic> {
  TagDetail({
    required String key,
    required AttributeDetailArgs<Tag> args,
    required AttributeDetailDataSource<Tag> dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, newLogic: TagDetailLogic());

  @override
  List<Widget> get content => [buildAdvance()];

  @override
  String get title => Tag.modelTitle;

  /// 高级设置
  Widget buildAdvance() {
    bool isTutorial = logic.isTutorial;
    return NeumorphicFormField(
      title: const Text("其它", style: TextStyle(fontWeight: FontWeight.bold)),
      child: Expansion(
        key: logic.dataSource.data.id.value,
        args: ExpansionArgs(
          initExpand: logic.args.isIntro
              ? true
              : isTutorial
                  ? true
                  : false,
          title: const Text("高级选项"),
          body: Column(
            children: [
              Container(margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), child: buildRelation()),
              Container(margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), child: buildCondition()),
              Container(margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), child: buildSort()),
            ],
          ),
        ),
      ),
    );
  }

  /// 构建标签过滤条件关系
  Widget buildRelation() {
    Tag tag = logic.dataSource.data;
    return HgNeumorphicButton(
      key: logic.addTutorialTargetKey(4, "relation"),
      getTooltip: () => tag.isAndFilter.comment ?? "",
      fullScreenTooltip: true,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 名称
          Expanded(child: Text(tag.isAndFilter.title)),
          // switch
          Obx(() => NeumorphicSwitch(value: logic.isAndFilter.value, onChanged: logic.setIsAndFilter)),
        ],
      ),
      onPressed: () => logic.setIsAndFilter(null),
    );
  }

  /// 标签过滤条件
  Widget buildCondition() {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return HgNeumorphicButton(
      key: logic.addTutorialTargetKey(5, "filter"),
      // 按钮提示
      getTooltip: () => logic.getConditionText(format: true) ?? logic.dataSource.data.filter.comment ?? "",
      fullScreenTooltip: true,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("过滤条件"),
                // 过滤条件描述 定点刷新
                Obx(() => logic.conditionText.isEmpty ? Container() : Text(logic.conditionText.value, style: TextStyle(color: themeData.disabledColor))),
              ],
            ),
          ),
          HgNeumorphicNextButton(onPressed: toCondition),
        ],
      ),
      onPressed: toCondition,
    );
  }

  /// 标签内排序条件
  Widget buildSort() {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return HgNeumorphicButton(
      key: logic.addTutorialTargetKey(6, "sort"),
      getTooltip: () => logic.getSortText(format: true) ?? logic.dataSource.data.sort.comment ?? "",
      fullScreenTooltip: true,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("排序条件"),
                // 定点刷新
                Obx(() => logic.sortText.isEmpty ? Container() : Text(logic.sortText.value, style: TextStyle(color: themeData.disabledColor))),
              ],
            ),
          ),
          HgNeumorphicNextButton(onPressed: toSort),
        ],
      ),
      onPressed: toSort,
    );
  }

  /// 前往过滤页签
  void toCondition() {
    if (logic.args.isIntro) return;
    RouteHelper.to(
      page: FilterGroupEditor(
        args: FilterGroupEditorArgs(
          pageTitle: "过滤条件",
          navigatorId: logic.args.navigatorId,
          onBack: logic.setConditionText,
          state: logic.args.state,
        ),
        dataSource: FilterGroupEditorDataSource(groupFilterValue: logic.dataSource.data.filter.value),
      ),
      id: logic.args.navigatorId,
    );
  }

  /// 打开排序条件
  void toSort() {
    if (logic.args.isIntro) return;
    RouteHelper.to(
      page: SortEditor(
        key: logic.key,
        args: SortEditorArgs(
          navigatorId: logic.args.navigatorId,
          onBack: logic.setSortText,
          state: logic.args.state,
        ),
        dataSource: SortAttributeEditorDataSource(attribute: logic.dataSource.data.sort),
      ),
      id: logic.args.navigatorId,
    );
  }
}
