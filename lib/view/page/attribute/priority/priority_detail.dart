import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:hg_logger/entity/data/priority.dart';
import 'package:hg_logger/main.dart';
import 'package:hg_logger/view/component/export.dart';
import 'package:hg_logger/view/enum/page_states.dart';
import 'package:hg_logger/view/page/attribute/attribute_detail.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class PriorityDetailLogic extends AttributeDetailLogic<Priority> {
  Rx<int> weightValue = 0.obs;
  int minWeight = 0;
  int maxWeight = 99;

  /// 修改权重的时候 需要马达反馈，但是直接用number_picker的反馈会有问题
  /// 按下按钮的时候，重新设置了number_picker的value,但是没有滚动，导致组件计算的值与设置值不一样，触发反馈
  /// 滚动之后，值更新，位置和值又不一样，又会触发反馈，导致按一次按钮触发两次反馈，所以这里加个参数
  /// 当是按钮操作的时候，不触发onChange，然后关闭按钮和picker的反馈，手动在onChange里反馈
  bool isButtonPush = false;

  @override
  void afterArgsUpdate() {
    super.afterArgsUpdate();
    weightValue.value = dataSource.data.weight.value;
  }

  /// 设置权重值
  void setWeightValue(int value) {
    // 浏览状态不修改
    if (args.state == PageState.browse) return;
    // 超过上下限不修改
    if (value < minWeight) return;
    if (value > maxWeight) return;
    // 值没变化 不修改
    if (dataSource.data.weight.value == value) return;
    // 修改值并反馈
    dataSource.data.weight.value = value;
    weightValue.value = value;
    HapticFeedback.selectionClick();
  }

  @override
  String? get tutorialSubKey => "priority_detail";

  @override
  void buildTutorial() {
    super.buildTutorial();
    buildAndAddTargetFocus(
      "weight",
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) => HgNeumorphicText("优先级权重设置，\n用于事件页面列表分组排序使用"
              "\n左右滑动或点击按钮可修改。"),
        ),
      ],
    );
    buildAndAddTargetFocus(
      "weight_comment",
      shape: ShapeLightFocus.Circle,
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) => HgNeumorphicText("权重帮助，\n点击可查看权重属性说明"),
        ),
      ],
    );
  }
}

/// 页面
class PriorityDetail extends AttributeDetail<Priority, PriorityDetailLogic> {
  PriorityDetail({
    required String key,
    required AttributeDetailArgs<Priority> args,
    required AttributeDetailDataSource<Priority> dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, newLogic: PriorityDetailLogic());

  @override
  List<Widget> get content => [buildPriorityWeight()];

  @override
  String get title => Priority.modelTitle;

  /// 优先级权重
  Widget buildPriorityWeight() {
    Priority priority = logic.dataSource.data;
    return NeumorphicFormField(
      key: logic.addTutorialTargetKey(4, "weight"),
      title: Text(priority.weight.title, style: const TextStyle(fontWeight: FontWeight.bold)),
      comment: priority.weight.comment,
      commentKey: logic.addTutorialTargetKey(5, "weight_comment"),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          buildMinusButton(),
          buildNumberPicker(),
          buildAddButton(),
        ],
      ),
    );
  }

  /// 减1按钮
  Widget buildMinusButton() {
    if (logic.args.state == PageState.browse) return Container();
    return HgNeumorphicButton(
      provideHapticFeedback: false,
      child: HgNeumorphicIcon(Icons.remove),
      onPressed: () {
        logic.isButtonPush = true;
        logic.setWeightValue(logic.weightValue.value - 1);
      },
    );
  }

  /// 加1按钮
  Widget buildAddButton() {
    if (logic.args.state == PageState.browse) return Container();
    return HgNeumorphicButton(
      provideHapticFeedback: false,
      child: HgNeumorphicIcon(Icons.add),
      onPressed: () {
        logic.isButtonPush = true;
        logic.setWeightValue(logic.weightValue.value + 1);
      },
    );
  }

  /// 数字选择器
  Widget buildNumberPicker() {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return Listener(
      child: Neumorphic(
        margin: const EdgeInsets.symmetric(vertical: 12),
        child: Obx(
          () => NumberPicker(
            axis: Axis.horizontal,
            onChanged: (value) {
              if (logic.isButtonPush) return;
              logic.setWeightValue(value);
            },
            itemWidth: 50,
            itemHeight: 50 / 0.618,
            value: logic.weightValue.value,
            maxValue: logic.maxWeight,
            minValue: logic.minWeight,
            selectedTextStyle: TextStyle(color: themeData.defaultTextColor, fontSize: 24, fontWeight: FontWeight.w500),
            textStyle: TextStyle(color: themeData.disabledColor, fontSize: 12, fontWeight: FontWeight.w300),
          ),
        ),
      ),
      onPointerDown: (event) {
        logic.isButtonPush = false;
      },
    );
  }
}
