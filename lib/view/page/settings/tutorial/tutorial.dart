import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:hg_logger/ability/export.dart';
import 'package:hg_logger/main.dart';
import 'package:hg_logger/view/export.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../settings.dart';

/// 逻辑
class TutorialSettingsLogic extends SettingsItemLogic {
  /// 介绍页
  Rx<bool> isShowIntro = true.obs;

  /// 强制关闭
  Rx<bool> isForceClose = false.obs;

  /// 快速访问引导
  Rx<bool> isShowQuickaccess = true.obs;

  /// 事件引导
  Rx<bool> isShowEvent = true.obs;

  /// 事件属性引导
  Rx<bool> isShowAttribute = true.obs;

  /// 日程引导
  Rx<bool> isShowSchedule = true.obs;

  /// 专注引导
  Rx<bool> isShowFocus = true.obs;

  /// 设置引导
  Rx<bool> isShowSettings = true.obs;

  /// 打开回调
  @override
  void afterArgsUpdate() {
    super.afterArgsUpdate();
    isForceClose.value = TutorialHelper.getForceCloseAll();
    isShowIntro.value = SharedPreferencesHelper.sharedPreferences.getBool(SharedPreferencesKeys.isShowIntro) ?? true;
    isShowQuickaccess.value = TutorialHelper.getIsTutorial(HomePages.quickaccess);
    isShowEvent.value = TutorialHelper.getIsTutorial(HomePages.event);
    isShowAttribute.value = TutorialHelper.getIsTutorial(HomePages.attribute);
    isShowSchedule.value = TutorialHelper.getIsTutorial(HomePages.schedule);
    isShowFocus.value = TutorialHelper.getIsTutorial(HomePages.focus);
    isShowSettings.value = TutorialHelper.getIsTutorial(HomePages.settings);
  }

  /// 设置应用启动页
  void setShowIntro(bool value) async {
    await SharedPreferencesHelper.sharedPreferences.setBool(SharedPreferencesKeys.isShowIntro, value);
    isShowIntro.value = value;
    RouteHelper.toast(msg: "已${value ? "打开" : "关闭"}应用介绍页");
    if (value) {
      MainLogic.instance.rebuild();
    }
  }

  /// 设置
  void setShow(Rx<bool> attribute, HomePages homePage, bool value) async {
    await TutorialHelper.setIsTutorial(homePage, value, null, true);
    attribute.value = value;
    RouteHelper.toast(msg: "已${value ? "打开" : "关闭"}${homePage.title}引导");
  }

  void setForceClose(bool value) async {
    await TutorialHelper.setForceCloseAll(value);
    isForceClose.value = value;
    RouteHelper.toast(msg: "已${value ? "打开" : "取消"}强制关闭所有引导");
  }

  @override
  void buildTutorial() {
    addTutorialTargetKey(-1, "view");
    buildAndAddTargetFocus(
      "view",
      targetPosition: TargetPosition(const Size.square(4), Offset(Get.width / 2, Get.height / 2)),
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) => HgNeumorphicText("引导页设置，\n可打开或者关闭用户引导页，"
              "\n注：从来没有打开过的页面无法通过此开关\n强制关闭引导页"),
        ),
      ],
    );
  }

  @override
  String? get tutorialSubKey => "tutorial";
}

/// 页面
class TutorialSettings extends SettingsItem<TutorialSettingsLogic> {
  TutorialSettings({
    required String key,
    required SettingsItemArgs args,
  }) : super(key: key, args: args, newLogic: TutorialSettingsLogic());

  @override
  String get title => "用户引导设置";

  @override
  Widget buildSettings() {
    return ListView(
      clipBehavior: Clip.none,
      padding: EdgeInsets.only(left: 12, right: 12, bottom: Get.height * 0.5, top: 12),
      children: [
        Padding(padding: const EdgeInsets.symmetric(vertical: 12), child: buildIntro()),
        Padding(padding: const EdgeInsets.symmetric(vertical: 12), child: buildForceClose()),
        Padding(padding: const EdgeInsets.symmetric(vertical: 12), child: buildBool(logic.isShowQuickaccess, HomePages.quickaccess)),
        Padding(padding: const EdgeInsets.symmetric(vertical: 12), child: buildBool(logic.isShowEvent, HomePages.event)),
        Padding(padding: const EdgeInsets.symmetric(vertical: 12), child: buildBool(logic.isShowAttribute, HomePages.attribute)),
        Padding(padding: const EdgeInsets.symmetric(vertical: 12), child: buildBool(logic.isShowSchedule, HomePages.schedule)),
        Padding(padding: const EdgeInsets.symmetric(vertical: 12), child: buildBool(logic.isShowFocus, HomePages.focus)),
        Padding(padding: const EdgeInsets.symmetric(vertical: 12), child: buildBool(logic.isShowSettings, HomePages.settings)),
      ],
    );
  }

  /// 应用介绍页
  Widget buildIntro() {
    return HgNeumorphicButton(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("应用介绍页"),
          Obx(() => NeumorphicSwitch(value: logic.isShowIntro.value, onChanged: (value) => logic.setShowIntro(value))),
        ],
      ),
      onPressed: () => logic.setShowIntro(!logic.isShowIntro.value),
    );
  }

  Widget buildForceClose() {
    return HgNeumorphicButton(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("强制关闭所有用户引导"),
          Obx(() => NeumorphicSwitch(value: logic.isForceClose.value, onChanged: (value) => logic.setForceClose(value))),
        ],
      ),
      onPressed: () => logic.setForceClose(!logic.isForceClose.value),
    );
  }

  /// 页面引导
  Widget buildBool(Rx<bool> attribute, HomePages homePage) {
    return HgNeumorphicButton(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("${homePage.title}页 用户引导"),
          Obx(() => NeumorphicSwitch(value: attribute.value, onChanged: (value) => logic.setShow(attribute, homePage, value))),
        ],
      ),
      onPressed: () => logic.setShow(attribute, homePage, !attribute.value),
    );
  }
}
