import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:hg_logger/ability/route/route.dart';
import 'package:hg_logger/entity/data/status.dart';
import 'package:hg_logger/main.dart';
import 'package:hg_logger/view/component/export.dart';
import 'package:hg_logger/view/page/attribute/attribute_detail.dart';
import 'package:hg_logger/view/page/attribute/component/to_string.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../component/expansion.dart';
import '../component/filter/filter_group.dart';

/// 状态明细逻辑
class StatusDetailLogic extends AttributeDetailLogic<Status> {
  /// 处理条件描述
  Rx<String> conditionText = "".obs;

  /// 打开回调 更新值
  @override
  void afterArgsUpdate() {
    super.afterArgsUpdate();
    setConditionText();
  }

  /// 设置过滤条件描述
  void setConditionText() {
    String? text = groupFilterToString(dataSource.data.filter.value);
    conditionText.value = text ?? "";
  }

  String? getConditionText({bool format = false}) {
    return groupFilterToString(dataSource.data.filter.value, format: format);
  }

  @override
  String? get tutorialSubKey => "status_detail";

  @override
  void buildTutorial() {
    super.buildTutorial();
    buildAndAddTargetFocus(
      "filter",
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) => HgNeumorphicText("状态匹配条件，\n点击进入匹配条件设置页面，"
              "\n长按可以查看按钮功能说明。"
              "\n注：大部分按钮长按可查看内容或按钮功能呢说明"),
        ),
      ],
    );
  }
}

/// 页面
class StatusDetail extends AttributeDetail<Status, StatusDetailLogic> {
  StatusDetail({
    required String key,
    required AttributeDetailArgs<Status> args,
    required AttributeDetailDataSource<Status> dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, newLogic: StatusDetailLogic());

  @override
  List<Widget> get content => [buildAdvance()];

  @override
  String get title => Status.modelTitle;

  /// 高级设置
  Widget buildAdvance() {
    return NeumorphicFormField(
      title: const Text("其它", style: TextStyle(fontWeight: FontWeight.bold)),
      child: Expansion(
        key: logic.dataSource.data.id.value,
        args: ExpansionArgs(
          initExpand: logic.isTutorial ? true : false,
          title: const Text("高级选项"),
          body: Column(
            children: [
              Container(margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), child: buildCondition()),
            ],
          ),
        ),
      ),
    );
  }

  /// 标签过滤条件
  Widget buildCondition() {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return HgNeumorphicButton(
      key: logic.addTutorialTargetKey(4, "filter"),
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
                const Text("状态匹配条件"),
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

  /// 打开条件设置页面
  void toCondition() {
    RouteHelper.to(
      page: FilterGroupEditor(
        args: FilterGroupEditorArgs(
          pageTitle: "状态自动处理条件",
          navigatorId: logic.args.navigatorId,
          state: logic.args.state,
          onBack: logic.setConditionText,
        ),
        dataSource: FilterGroupEditorDataSource(groupFilterValue: logic.dataSource.data.filter.value),
      ),
      id: logic.args.navigatorId,
    );
  }
}
