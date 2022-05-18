import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:hg_entity/hg_entity.dart';
import 'package:hg_logger/ability/notification/notification.dart';
import 'package:hg_logger/ability/route/route.dart';
import 'package:hg_logger/config.dart';
import 'package:hg_logger/entity/data/focus.dart' as models;
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/main.dart';
import 'package:hg_logger/service/services.dart';
import 'package:hg_logger/util/datetime_util.dart';
import 'package:hg_logger/view/export.dart';
import 'package:hg_logger/view/page/focus/event.dart';
import 'package:hg_logger/view/page/focus/focus_history.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import 'base_count.dart';
import 'count_down.dart';
import 'count_up.dart';

/// 专注状态
enum FocusState { start, pause, stop }

/// 逻辑
class FocusHomeLogic extends HomePageLogic {
  /// 专注服务
  static final FocusService _focusService = FocusService.instance;

  /// 活跃的页面
  Rx<int> activeIndex = 0.obs;

  /// 当前模式
  Rx<FocusMode> mode = FocusMode.down.obs;

  /// 当前状态
  Rx<FocusState> focusState = FocusState.stop.obs;

  /// 开始专注时间
  DateTime? startFocusDateTime;

  /// 开始专注时间更新标识
  Rx<int> startFocusDateTimeUpdateFlag = 0.obs;

  /// 开始按钮是否可用
  Rx<bool> startActionEnabled = true.obs;

  /// 结束按钮是否可用
  Rx<bool> stopActionEnabled = false.obs;

  /// 模式列表
  List<FocusMode> modeList = FocusMode.list;

  /// 页面控制器
  final PageController pageController = PageController(initialPage: 0, keepPage: false);

  /// 计时时长
  int milliseconds = 0;

  /// 状态更新标识
  Rx<int> millisecondsUpdateFlag = 0.obs;

  /// 刷新间隔
  int refreshMilliseconds = 100;

  /// 当前专注
  models.Focus focus = models.Focus();

  /// 打开时操作
  @override
  void afterArgsUpdate() {
    startActionEnabled.value = true;
    stopActionEnabled.value = false;
    focusState.value = FocusState.stop;
    millisecondsUpdateFlag.value = 0;
    readTemp();
    super.afterArgsUpdate();
  }

  /// 组件销毁时操作
  @override
  void onWidgetDispose(BuildContext context, GetBuilderState state) async {
    if (milliseconds > 0) {
      saveTemp();
    }
  }

  @override
  Future<bool> canPagePop() async {
    if (focusState.value != FocusState.start) return true;
    bool? canPop = await RouteHelper.showOneChoiceRequest(msg: "离开本页面将会暂停专注,确定要离开吗?", doneText: "离开");
    return canPop == true;
  }

  /// 应用生命周期回调
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      if (focusState.value == FocusState.start) {
        focusState.value = FocusState.pause;
        getLogicByMode().pause();
        notification("专注已暂停,快回来吧");
      }
    }
  }

  /// 提示用户
  void notification(String body) async {
    // 发送通知
    await NotificationHelper.showNotification(NotificationArgs(
      id: UUIDGenerator.instance.id.hashCode,
      title: "专注提醒",
      body: body,
    ));
  }

  /// 读缓存
  Future<void> readTemp() async {
    // 是否有暂存的倒计时
    models.Focus? tempSave = await _focusService.focusTempGet();
    if (null != tempSave) {
      focus = tempSave;
      startFocusDateTime = focus.start.value;
      startFocusDateTimeUpdateFlag.value++;
      mode.value = tempSave.mode.value.mode;
      milliseconds = tempSave.milliseconds.value;
      millisecondsUpdateFlag.value++;
      focusState.value = FocusState.pause;
      startActionEnabled.value = true;
      stopActionEnabled.value = true;
    }
    activeIndex.value = modeList.indexOf(mode.value);
    if (pageController.positions.isEmpty) return;
    pageController.jumpToPage(activeIndex.value);
  }

  /// 写缓存
  Future<void> saveTemp() async {
    await _focusService.focusTempSave(focus);
  }

  /// 清空缓存
  Future<void> clearTemp() async {
    await _focusService.focusTempClear();
  }

  /// 设置事件
  void setEvent(DeriveEvent? event) {
    focus.event.value = event;
  }

  /// 保存专注记录
  Future<void> saveFocus() async {
    await _focusService.save(focus);
    // 新建一个专注
    focus = models.Focus();
    startFocusDateTime = null;
    startFocusDateTimeUpdateFlag.value++;
  }

  static const String countDownKey = "focus_count_down";
  static const String countUpKey = "focus_count_up";

  /// 通过模式获取子组件控制器
  BaseCountLogic getLogicByMode() {
    if (mode.value == FocusMode.down) {
      return Get.find<CountDownLogic>(tag: countDownKey);
    } else {
      return Get.find<CountUpLogic>(tag: countUpKey);
    }
  }

  /// 清空别的模式的数据
  void clearOtherMode() {
    BaseCountLogic logic;
    if (mode.value == FocusMode.up) {
      logic = Get.find<CountDownLogic>(tag: countDownKey);
    } else {
      logic = Get.find<CountUpLogic>(tag: countUpKey);
    }
    logic.reset();
  }

  /// 开始计时
  void onStartAction() {
    switch (focusState.value) {
      case FocusState.start:
        focusState.value = FocusState.pause;
        getLogicByMode().pause();
        break;
      case FocusState.stop:
        focus.start.value = DateTime.now();
        startFocusDateTime = focus.start.value;
        startFocusDateTimeUpdateFlag.value++;
        focusState.value = FocusState.start;
        getLogicByMode().start();
        break;
      case FocusState.pause:
        focusState.value = FocusState.start;
        getLogicByMode().start();
        break;
    }
    startActionEnabled.value = true;
    stopActionEnabled.value = true;
  }

  /// 结束计时
  /// 有事件 选择事件状态
  void onStopAction() async {
    focusState.value = FocusState.pause;
    getLogicByMode().pause();
    bool? isSave = await RouteHelper.showTwoChoiceRequest(msg: "是否记录专注", doneText: "记录", unDoneText: "放弃");
    // 取消，不进行任何操作
    if (null == isSave) return;
    getLogicByMode().stop();
    focusState.value = FocusState.stop;
    startActionEnabled.value = true;
    stopActionEnabled.value = false;
    startFocusDateTime = null;
    startFocusDateTimeUpdateFlag.value++;
    int millisecondsRecord = milliseconds;
    // 不关是记录还是放弃，都要清空数据
    milliseconds = 0;
    await clearTemp();
    getLogicByMode().reset();
    // 如果是放弃，直接 返回
    if (!isSave) return;
    // 保存操作
    focus.end.value = DateTime.now();
    focus.milliseconds.value = millisecondsRecord;
    DeriveEvent? event = focus.event.value;
    await saveFocus();
    if (event != null) {
      // 显示事件的快速操作
      await showEventQuickAction(event);
    }
  }

  /// 计时时长发生改变回调
  void onMillisecondsChanged(int value) {
    milliseconds = value;
    focus.milliseconds.value = milliseconds;
  }

  /// 每秒更新一次缓存
  void onSecondsChanged(int value) {
    saveTemp();
  }

  /// 倒计时结束回调 结束并通知用户
  void onCountDownFinish() {
    startActionEnabled.value = false;
    stopActionEnabled.value = true;
    getLogicByMode().stop();
    if (MainLogic.instance.appLifecycleState != AppLifecycleState.resumed) {
      notification("倒计时结束");
    } else {
      RouteHelper.inAppNotification(title: "专注提醒", message: "倒计时结束");
    }
  }

  /// 记录这个参数的原因是，animateToPage会触发onPageChange，需要忽略
  bool isAnimateToPage = false;

  /// tab bar切换，控制tab view
  void onIndexChanged(int index) async {
    if (focusState.value != FocusState.stop) return;
    if (index == activeIndex.value) return;
    activeIndex.value = index;
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
  void onPageChanged(int index) {
    if (isAnimateToPage) return;
    if (focusState.value != FocusState.stop) return;
    if (index == activeIndex.value) return;
    mode.value = modeList[index];
    activeIndex.value = index;
    focus.mode.value.mode = mode.value;
    HapticFeedback.lightImpact();
  }

  @override
  void buildTutorial() {
    buildAndAddTargetFocus(
      "history",
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) => HgNeumorphicText("专注历史按钮，\n点击可查看专注历史"),
        ),
      ],
    );
    buildAndAddTargetFocus(
      "event",
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) => HgNeumorphicText("专注事件，\n点击可选择要专注的事件"),
        ),
      ],
    );
    buildAndAddTargetFocus(
      "count",
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) => HgNeumorphicText("计时器，\n左右滑动可切换计时器"),
        ),
      ],
    );
  }

  @override
  HomePages get homePage => HomePages.focus;
}

/// 专注页面
class FocusHomePage extends HomePage<FocusHomeLogic> {
  FocusHomePage({required String key, required HomePageArgs args}) : super(key: key, args: args, newLogic: FocusHomeLogic());

  @override
  Widget buildView(BuildContext context) {
    return HgNeumorphicScaffold(
      leading: Expanded(child: SlideInLeft(child: buildTabBar())),
      trailing: SlideInRight(
        child: Obx(
          () => Container(
            margin: const EdgeInsets.only(right: 16),
            child: HgNeumorphicButton(
              key: logic.addTutorialTargetKey(0, "history"),
              padding: const EdgeInsets.all(8),
              child: HgNeumorphicIcon(Icons.history),
              getTooltip: () => "专注历史",
              onPressed: logic.focusState.value == FocusState.stop ? showFocusHistory : null,
            ),
          ),
        ),
      ),
      bodyPadding: const EdgeInsets.only(top: 12),
      body: SafeArea(child: buildFocus()),
    );
  }

  ///  显示专注历史
  void showFocusHistory() async {
    int navigatorId = "focus_focus_history".hashCode;
    RouteHelper.bottomPageNested(
      parentId: logic.args.navigatorId,
      nestedId: navigatorId,
      page: FocusHistory(
        key: "focus_focus_history",
        args: FocusHistoryArgs(
          navigatorId: navigatorId,
          parentNavigatorId: logic.args.navigatorId,
        ),
      ),
    );
  }

  /// 构建标签页导航栏
  Widget buildTabBar() {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    List<ToggleElement> children = logic.modeList.map((mode) {
      return ToggleElement(
        background: Center(child: HgNeumorphicText(mode.name, color: themeData.disabledColor)),
        foreground: Center(child: HgNeumorphicText(mode.name, color: themeData.accentColor)),
      );
    }).toList();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      child: Obx(
        () => NeumorphicToggle(
          padding: EdgeInsets.zero,
          selectedIndex: logic.activeIndex.value,
          displayForegroundOnlyIfSelected: true,
          children: children,
          thumb: Container(),
          style: const NeumorphicToggleStyle(border: NeumorphicBorder()),
          onChanged: logic.onIndexChanged,
        ),
      ),
    );
  }

  /// 构建专注页面
  Widget buildFocus() {
    return Column(
      children: [
        // 事件
        SlideInLeft(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            child: Container(
              key: logic.addTutorialTargetKey(1, "event"),
              child: EventSelector(
                key: logic.key + "event_selector",
                args: EventSelectorArgs(navigatorId: logic.args.navigatorId, onSelected: logic.setEvent, focusLogic: logic),
                dataSource: EventSelectorDataSource(event: logic.focus.event.value),
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(top: 12, left: 12),
          child: SlideInLeft(
            child: Obx(() {
              int startFocusDateTimeUpdateFlag = logic.startFocusDateTimeUpdateFlag.value;
              debugPrint("专注开始时间更新次数:$startFocusDateTimeUpdateFlag");
              return Text(
                "专注开始时间 : ${DateTimeUtil.format(logic.startFocusDateTime)}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              );
            }),
          ),
        ),
        // 计时
        BounceInLeft(child: buildCount()),
        // 按钮
        FadeIn(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [buildStop(), buildStartButton()],
          ),
        )
      ],
    );
  }

  /// 计时器
  Widget buildCount() {
    List<Widget> children = logic.modeList.map((mode) {
      Widget? child;
      bool isCurrent = logic.focus.mode.value.mode == mode;
      if (mode == FocusMode.up) {
        child = CountUp(
          key: FocusHomeLogic.countUpKey,
          args: CountUpArgs(
            initMilliseconds: isCurrent ? logic.milliseconds : 0,
            refreshDurationInMilliseconds: logic.refreshMilliseconds,
            onMillisecondsChanged: logic.onMillisecondsChanged,
            onSecondsChanged: logic.onSecondsChanged,
            focusLogic: logic,
          ),
        );
      }
      if (mode == FocusMode.down) {
        child = CountDown(
          key: FocusHomeLogic.countDownKey,
          args: CountDownArgs(
            initMilliseconds: isCurrent ? logic.milliseconds : 0,
            refreshDurationInMilliseconds: logic.refreshMilliseconds,
            onMillisecondsChanged: logic.onMillisecondsChanged,
            onCountDownFinish: logic.onCountDownFinish,
            onSecondsChanged: logic.onSecondsChanged,
            focusLogic: logic,
          ),
        );
      }
      return Container(child: child);
    }).toList();

    /// 是否可以滚动
    return Container(
      key: logic.addTutorialTargetKey(2, "count"),
      padding: const EdgeInsets.symmetric(horizontal: 6),
      clipBehavior: Clip.none,
      child: AspectRatio(
        aspectRatio: 0.8,
        child: Obx(() {
          return PageView(
            controller: logic.pageController,
            physics: logic.focusState.value == FocusState.stop ? null : const NeverScrollableScrollPhysics(),
            children: children,
            onPageChanged: logic.onPageChanged,
          );
        }),
      ),
    );
  }

  /// 开始按钮
  Widget buildStartButton() {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return Obx(() {
      String text;
      switch (logic.focusState.value) {
        case FocusState.start:
          text = "暂停";
          break;
        case FocusState.pause:
          text = "继续";
          break;
        case FocusState.stop:
          text = "开始";
          break;
      }
      bool isEnable = logic.startActionEnabled.value;
      return HgNeumorphicButton(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        child: Text(text, style: TextStyle(color: isEnable ? themeData.defaultTextColor : themeData.disabledColor)),
        style: NeumorphicStyle(
          depth: isEnable ? themeData.depth : 0,
          border: isEnable ? const NeumorphicBorder() : const NeumorphicBorder.none(),
        ),
        onPressed: isEnable ? logic.onStartAction : null,
      );
    });
  }

  /// 暂停按钮
  Widget buildStop() {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return Obx(() {
      bool isEnable = logic.stopActionEnabled.value;
      return HgNeumorphicButton(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        child: Text("结束", style: TextStyle(color: isEnable ? themeData.defaultTextColor : themeData.disabledColor)),
        style: NeumorphicStyle(
          depth: isEnable ? themeData.depth : 0,
          border: isEnable ? const NeumorphicBorder() : const NeumorphicBorder.none(),
        ),
        onPressed: isEnable ? logic.onStopAction : null,
      );
    });
  }
}
