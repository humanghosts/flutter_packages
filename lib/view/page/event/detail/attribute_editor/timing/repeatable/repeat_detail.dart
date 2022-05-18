import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:hg_logger/ability/export.dart';
import 'package:hg_logger/config.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/main.dart';
import 'package:hg_logger/view/export.dart';
import 'package:numberpicker/numberpicker.dart';

@immutable
class RepeatDetailArgs extends ViewArgs {
  /// 返回回调
  final VoidCallback? onBack;

  /// 导航id
  final int? navigatorId;

  const RepeatDetailArgs({
    this.onBack,
    this.navigatorId,
  });
}

@immutable
class RepeatDetailDataSource extends ViewDataSource {
  final RepeatRule repeatRule;

  const RepeatDetailDataSource({required this.repeatRule});
}

class RepeatDetailLogic extends ViewLogic<RepeatDetailArgs, RepeatDetailDataSource> {
  /// 当前活跃的页面
  Rx<int> activeIndex = 0.obs;

  /// 记录这个参数的原因是，animateToPage会触发onPageChange，需要忽略
  bool isAnimateToPage = false;

  PageController pageController = PageController(initialPage: 0);

  /// 单位
  Rx<int> unit = 0.obs;

  /// 单位数
  Rx<int> unitNumbers = 0.obs;

  /// 截止次数
  Rx<int> deadtimes = 0.obs;

  /// 返回
  void back() {
    RouteHelper.back(id: args.navigatorId);
  }

  /// 返回回调
  void onBack() {
    clearUnUse();
    args.onBack?.call();
  }

  /// 打开回调
  @override
  void afterArgsUpdate() {
    RepeatRule repeatRule = dataSource.repeatRule;
    if (repeatRule.deadline != null) {
      activeIndex.value = 1;
    } else if (repeatRule.deadtimes != null) {
      activeIndex.value = 2;
    } else {
      activeIndex.value = 0;
    }
    repeatRule.unitNumber ??= 1;
    // 初始值
    unit.value = repeatRule.unit.value;
    unitNumbers.value = repeatRule.unitNumber ?? 0;
    deadtimes.value = repeatRule.deadtimes ?? 0;

    pageController = PageController(initialPage: activeIndex.value);
    if (pageController.positions.isNotEmpty) {
      pageController.jumpToPage(activeIndex.value);
    }
  }

  /// 修改单位
  void changeUnit(int value) {
    dataSource.repeatRule.unit = RepeatUnit.map[value]!;
    unit.value = value;
  }

  /// 修改次数
  void changeNumbers(int value) {
    dataSource.repeatRule.unitNumber = value;
    unitNumbers.value = value;
  }

  void clearUnUse() {
    // 永远重复
    if (0 == activeIndex.value) {
      dataSource.repeatRule.deadtimes = null;
      dataSource.repeatRule.deadline = null;
    }
    // 按截止时间
    if (1 == activeIndex.value) {
      dataSource.repeatRule.deadtimes = null;
    }
    // 按次数
    if (2 == activeIndex.value) {
      dataSource.repeatRule.deadline = null;
    }
  }

  /// 设置截止日期
  void setDeadline(DateTime dateTime) {
    dataSource.repeatRule.deadline = dateTime;
  }

  /// 设置截止次数
  void setDeadTimes(int value) {
    dataSource.repeatRule.deadtimes = value;
    deadtimes.value = value;
  }

  /// tab bar切换，控制tab view
  void onIndexChanged(int value) async {
    if (value == activeIndex.value) return;
    activeIndex.value = value;
    if (pageController.positions.isEmpty) return;
    HapticFeedback.lightImpact();
    isAnimateToPage = true;
    await pageController.animateToPage(
      activeIndex.value,
      duration: AppConfig.animationConfig.middleAnimationDuration,
      curve: Curves.linear,
    );
    isAnimateToPage = false;
  }

  /// tab view切换，更新控制tab bar
  void onPageChanged(int value) {
    if (isAnimateToPage) return;
    activeIndex.value = value;
    HapticFeedback.lightImpact();
  }
}

/// 时间详情弹框
class RepeatDetail extends View<RepeatDetailLogic> with ObserverWidget {
  RepeatDetail({
    required String key,
    RepeatDetailArgs? args,
    required RepeatDetailDataSource dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, newLogic: RepeatDetailLogic());

  @override
  void observe(ObserverRouting? routing) {
    if (routing?.isBack == true) {
      logic.onBack();
    }
  }

  @override
  Widget buildView(BuildContext context) {
    return HgNeumorphicScaffold(
      leading: HgNeumorphicBackButton(onPressed: logic.back),
      title: HgNeumorphicText("重复设置"),
      bodyPadding: EdgeInsets.zero,
      body: buildRepeat(),
    );
  }

  /// 构建日期时间的弹框
  Widget buildRepeat() {
    return Column(
      children: [
        // 重复规则
        Padding(padding: const EdgeInsets.only(top: 12, left: 12, bottom: 16, right: 12), child: buildRepeatRule()),
        // 停止重复设置 导航栏
        Neumorphic(
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.all(8),
          child: Row(children: [const Text("停止重复"), const Padding(padding: EdgeInsets.only(left: 16)), Expanded(child: buildTabBar())]),
        ),
        // 停止重复设置 页面
        Expanded(child: buildTabViews()),
      ],
    );
  }

  /// 构建重复规则
  Widget buildRepeatRule() {
    return NeumorphicFormField(
      title: const Text('重复规则'),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text("每"),
            // 数字
            Obx(() => buildNumberPicker(
                  key: "repeat_numbers",
                  max: 60,
                  min: 1,
                  value: logic.unitNumbers.value,
                  onChanged: logic.changeNumbers,
                )),
            // 单位
            Obx(() => buildNumberPicker(
                  key: "repeat_unit",
                  max: 4,
                  min: 0,
                  value: logic.unit.value,
                  onChanged: logic.changeUnit,
                  textMapper: (numberText) => RepeatUnit.fromMap(int.parse(numberText))!.name,
                )),
            const Text("重复一次"),
          ],
        ),
      ),
    );
  }

  /// 构建停止规则的导航栏
  Widget buildTabBar() {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    List<ToggleElement> children = ["不停止", "按时间", "按次数"].map((name) {
      return ToggleElement(
        background: Center(child: Text(name, style: TextStyle(color: themeData.disabledColor))),
        foreground: Center(child: Text(name, style: TextStyle(color: themeData.accentColor))),
      );
    }).toList();
    return Obx(
      () => NeumorphicToggle(
        padding: EdgeInsets.zero,
        selectedIndex: logic.activeIndex.value,
        displayForegroundOnlyIfSelected: true,
        children: children,
        thumb: Container(),
        style: const NeumorphicToggleStyle(border: NeumorphicBorder()),
        onChanged: logic.onIndexChanged,
      ),
    );
  }

  /// 构建停止规则的内容
  Widget buildTabViews() {
    return SizedBox.expand(
      child: PageView.builder(
        clipBehavior: Clip.none,
        itemCount: 3,
        itemBuilder: (context, index) {
          Widget child;
          if (index == 0) {
            child = Container();
          } else if (index == 1) {
            child = buildDeadLine();
          } else {
            child = buildDeadTimes();
          }
          return Container(
            child: child,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: const BoxDecoration(),
            clipBehavior: Clip.hardEdge,
          );
        },
        controller: logic.pageController,
        onPageChanged: logic.onPageChanged,
      ),
    );
  }

  /// 按时间停止重复
  Widget buildDeadLine() {
    RepeatRule repeatRule = logic.dataSource.repeatRule;
    repeatRule.deadline ??= DateTime.now();
    return SingleChildScrollView(
      clipBehavior: Clip.none,
      padding: EdgeInsets.only(bottom: Get.height * 0.25),
      physics: const AlwaysScrollableScrollPhysics(),
      child: DateTimePicker(
        key: "repeat_time",
        args: DateTimePickerArgs(
          firstDate: DateTime.fromMillisecondsSinceEpoch(0),
          lastDate: DateTime(2050, 12, 31),
          initialDate: repeatRule.deadline!,
          onDateTimeChanged: logic.setDeadline,
        ),
      ),
    );
  }

  /// 按次数停止重复
  Widget buildDeadTimes() {
    return Container(
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Text("重复"),
          Obx(() {
            RepeatRule repeatRule = logic.dataSource.repeatRule;
            repeatRule.deadtimes ??= 1;
            logic.deadtimes.value = repeatRule.deadtimes!;
            return buildNumberPicker(
              key: "repeat_dead_times",
              max: 60,
              min: 1,
              value: logic.deadtimes.value,
              onChanged: logic.setDeadTimes,
            );
          }),
          const Text("次"),
        ],
      ),
    );
  }

  /// 数字选择器
  Widget buildNumberPicker({
    required String key,
    required int max,
    required int min,
    required int value,
    required Function(int value) onChanged,
    TextMapper? textMapper,
  }) {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return Neumorphic(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
      child: NumberPicker(
        key: ValueKey(key),
        minValue: min,
        maxValue: max,
        itemCount: 5,
        itemHeight: 30,
        itemWidth: 80,
        infiniteLoop: false,
        value: value,
        onChanged: onChanged,
        zeroPad: true,
        textMapper: textMapper,
        haptics: true,
        selectedTextStyle: TextStyle(color: themeData.defaultTextColor, fontSize: 24, fontWeight: FontWeight.w500),
        textStyle: TextStyle(color: themeData.disabledColor, fontSize: 12, fontWeight: FontWeight.w300),
      ),
    );
  }
}
