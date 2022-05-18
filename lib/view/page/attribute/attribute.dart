import 'package:animate_do/animate_do.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:hg_logger/config.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/main.dart';
import 'package:hg_logger/view/export.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import 'attribute_list.dart';
import 'priority/priority_list.dart';
import 'status/status_list.dart';
import 'tag/tag_list.dart';

class AttributeHomeLogic extends HomePageLogic {
  /// tab页面
  List<Type> tabList = const [Tag, Priority, Status];

  /// 标签页
  AttributeList? currentList;

  /// tab控制器
  PageController pageController = PageController(initialPage: 0);

  /// 当前活跃的页面
  Rx<int> activeIndex = 0.obs;

  /// 记录这个参数的原因是，animateToPage会触发onPageChange，需要忽略
  bool isAnimateToPage = false;

  @override
  void afterArgsUpdate() {
    super.afterArgsUpdate();
    pageController = PageController(initialPage: activeIndex.value);
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

  @override
  void buildTutorial() {
    addTutorialTargetKey(-1, "base");
    buildAndAddTargetFocus(
      "base",
      targetPosition: TargetPosition(const Size.square(4), Offset(Get.width / 2, Get.height / 2)),
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) => HgNeumorphicText("事件属性主页，\n主要用于事件属性的管理"),
        ),
      ],
    );
    buildAndAddTargetFocus(
      "tab_bar",
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) => HgNeumorphicText("事件属性标签页，\n点击可切换属性列表"),
        ),
      ],
    );
    buildAndAddTargetFocus(
      "tab_view",
      contents: [
        TargetContent(
          align: ContentAlign.custom,
          customPosition: CustomTargetContentPosition(top: 20),
          builder: (context, controller) => HgNeumorphicText("事件属性列表，左右滑动可切换列表，\n点击事件属性可查看属性详情，"
              "事件属性向左滑动可删除"),
        ),
      ],
    );
    buildAndAddTargetFocus(
      "settings_button",
      contents: [
        TargetContent(
          align: ContentAlign.top,
          builder: (context, controller) => HgNeumorphicText("设置按钮，\n点击可对属性列表进行设置"),
        ),
      ],
    );
    buildAndAddTargetFocus(
      "add_button",
      contents: [
        TargetContent(
          align: ContentAlign.top,
          builder: (context, controller) => HgNeumorphicText("新增按钮，\n点击可新增事件属性"),
        ),
      ],
    );
  }

  @override
  HomePages get homePage => HomePages.attribute;
}

/// 属性主页
class AttributeHomePage extends HomePage<AttributeHomeLogic> {
  AttributeHomePage({required String key, required HomePageArgs args}) : super(key: key, args: args, newLogic: AttributeHomeLogic());

  /// 主页
  @override
  Widget buildView(BuildContext context) {
    return HgNeumorphicScaffold(
      title: Container(
        clipBehavior: Clip.none,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: SlideInDown(child: buildTabBar()),
      ),
      bodyPadding: const EdgeInsets.symmetric(horizontal: 12),
      body: FadeInDownBig(
        child: buildTabBarView(),
        duration: AppConfig.animationConfig.middleAnimationDuration,
      ),
      onSettings: () {
        logic.currentList?.toSettings();
      },
      settingsButtonKey: logic.addTutorialTargetKey(2, "settings_button"),
      onAdd: () {
        logic.currentList?.add();
      },
      addButtonKey: logic.addTutorialTargetKey(3, "add_button"),
    );
  }

  /// 标签页指示器
  Widget buildTabBar() {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    List<ToggleElement> children = logic.tabList.map((e) {
      String name = _getTabBarName(e);
      return ToggleElement(
        background: Center(child: HgNeumorphicText(name, color: themeData.disabledColor)),
        foreground: Center(child: HgNeumorphicText(name, color: themeData.accentColor)),
      );
    }).toList();

    return Obx(
      () => NeumorphicToggle(
        key: logic.addTutorialTargetKey(0, "tab_bar"),
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

  /// 控制器名称
  String _getTabBarName(Type tabType) {
    if (tabType == Tag) return Tag.modelTitle;
    if (tabType == Priority) return Priority.modelTitle;
    if (tabType == Status) return Status.modelTitle;
    return "";
  }

  /// 页面
  Widget buildTabBarView() {
    return PageView.builder(
      key: logic.addTutorialTargetKey(1, "tab_view"),
      clipBehavior: Clip.none,
      controller: logic.pageController,
      itemBuilder: (context, index) {
        Type tabType = logic.tabList[index];
        return Container(child: getContent(tabType));
      },
      itemCount: logic.tabList.length,
      onPageChanged: logic.onPageChanged,
    );
  }

  /// 获取当前页面内容
  AttributeList? getContent(Type tabType) {
    AttributeListArgs args = AttributeListArgs(navigatorId: logic.args.navigatorId);
    if (tabType == Tag) {
      logic.currentList = TagList(key: "${logic.key}_tag_list", args: args);
    }
    if (tabType == Priority) {
      logic.currentList = PriorityList(key: "${logic.key}_priority_list", args: args);
    }
    if (tabType == Status) {
      logic.currentList = StatusList(key: "${logic.key}_status_list", args: args);
    }
    return logic.currentList;
  }
}
