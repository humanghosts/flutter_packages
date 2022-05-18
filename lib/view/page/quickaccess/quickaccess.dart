import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/service/services.dart';
import 'package:hg_logger/view/export.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

/// 逻辑
class QuickAccessHomeLogic extends HomePageLogic {
  /// 设置
  QuickAccessConfig config = QuickAccessConfig();

  /// 设置服务
  QuickAccessConfigService settingsService = QuickAccessConfigService.instance;
  PageController pageController = PageController(initialPage: 0);

  /// 活跃的页面
  int activeIndex = 0;

  /// 查找配置
  Future<void> findConfig() async {
    config = await settingsService.find();
    update();
  }

  /// 打开回调
  @override
  void afterArgsUpdate() {
    pageController = PageController(initialPage: activeIndex);
    findConfig();
    super.afterArgsUpdate();
  }

  /// 导航栏变化
  void onIndexChanged(int index) {
    if (index == activeIndex) return;
    activeIndex = index;
    update();
    if (pageController.positions.isNotEmpty) {
      pageController.jumpToPage(activeIndex);
    }
  }

  /// 翻页
  void onPageChanged(int index) {
    activeIndex = index;
    update();
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
          builder: (context, controller) => HgNeumorphicText("快速访问页面，\n可通过下方导航栏快速切换页面，"
              "\n导航页面可在设置页面中进行选择，"
              "\n向右滑动可打开抽屉菜单"),
        ),
      ],
    );
  }

  @override
  HomePages get homePage => HomePages.quickaccess;
}

/// 页面
class QuickAccessHomePage extends HomePage<QuickAccessHomeLogic> {
  QuickAccessHomePage({required String key, required HomePageArgs args}) : super(key: key, args: args, newLogic: QuickAccessHomeLogic());

  @override
  Widget buildView(BuildContext context) {
    return HgNeumorphicScaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          buildPageView(),
          buildBottomNavBar() ?? Container(),
        ],
      ),
    );
  }

  Widget buildPageView() {
    QuickAccessConfig settings = logic.config;
    List<PageValue> homePages = settings.homePages.value.where((e) => !e.isNull).toList();
    return PageView.builder(
      itemBuilder: (context, index) {
        HomePages homePage = homePages[index].page!;
        return homePage.build(navigatorId: logic.args.navigatorId);
      },
      physics: const NeverScrollableScrollPhysics(),
      controller: logic.pageController,
      itemCount: homePages.length,
      onPageChanged: logic.onPageChanged,
    );
  }

  Widget? buildBottomNavBar() {
    QuickAccessConfig settings = logic.config;
    if (settings.homePages.value.length <= 1) return null;

    List<Widget> barItemList = [];

    for (int index = 0; index < settings.homePages.value.length; index++) {
      PageValue pageValue = settings.homePages.value[index];
      barItemList.add(Container(
        height: 40,
        width: 70,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: buildNavigatorBarItem(pageValue.page!, index),
      ));
    }

    return Neumorphic(
      margin: const EdgeInsets.only(bottom: 30),
      child: Container(
        height: 70,
        width: Get.width / 2,
        alignment: Alignment.center,
        child: SingleChildScrollView(
          clipBehavior: Clip.none,
          scrollDirection: Axis.horizontal,
          child: Row(children: barItemList),
        ),
      ),
    );
  }

  Widget buildNavigatorBarItem(HomePages page, int index) {
    bool isActive = index == logic.activeIndex;
    HomePageLogic? pageLogic = page.getLogic();
    if (null == pageLogic) return Container();
    return pageLogic.buildQuickaccess(
      isActive: isActive,
      iconData: page.iconData,
      title: page.title,
      action: () => logic.onIndexChanged(index),
    );
  }
}
