import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hg_logger/ability/export.dart';
import 'package:hg_logger/view/component/export.dart';
import 'package:hg_logger/view/page/home_pages.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import 'about/about.dart';
import 'quickaccess/quickaccess.dart';
import 'theme/theme.dart';
import 'tutorial/tutorial.dart';

/// 逻辑
class SettingsHomeLogic extends HomePageLogic {
  @override
  void buildTutorial() {
    addTutorialTargetKey(-1, "view");
    buildAndAddTargetFocus(
      "view",
      targetPosition: TargetPosition(const Size.square(4), Offset(Get.width / 2, Get.height / 2)),
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) => HgNeumorphicText("应用全局设置，\n不包括分页面设置，"
              "\n详细页面设置可通过页面设置按钮进行设置"),
        ),
      ],
    );
  }

  @override
  HomePages get homePage => HomePages.settings;
}

/// 页面
class SettingsHomePage extends HomePage<SettingsHomeLogic> {
  SettingsHomePage({required String key, required HomePageArgs args}) : super(key: key, args: args, newLogic: SettingsHomeLogic());

  @override
  Widget buildView(BuildContext context) {
    return HgNeumorphicScaffold(
      title: HgNeumorphicText("设置"),
      body: buildSettings(),
    );
  }

  Widget buildSettings() {
    return ListView(
      clipBehavior: Clip.none,
      padding: EdgeInsets.only(bottom: Get.height * 0.5),
      children: [
        buildHomeSettings(),
        const Padding(padding: EdgeInsets.only(top: 16)),
        buildThemeSettings(),
        const Padding(padding: EdgeInsets.only(top: 16)),
        buildCloudSettings(),
        const Padding(padding: EdgeInsets.only(top: 16)),
        buildTutorialSettings(),
        const Padding(padding: EdgeInsets.only(top: 16)),
        buildAbout(),
      ],
    );
  }

  /// 首页设置
  Widget buildHomeSettings() {
    return buildNextSettingsItem(title: "快速访问", toNextPage: toHomeSettings);
  }

  /// 主题设置
  Widget buildThemeSettings() {
    return buildNextSettingsItem(title: "显示设置", toNextPage: toThemeSettings);
  }

  /// 同步设置
  Widget buildCloudSettings() {
    return buildNextSettingsItem(title: "数据备份", toNextPage: toCloudSettings);
  }

  /// 用户引导设置
  Widget buildTutorialSettings() {
    return buildNextSettingsItem(title: "用户引导", toNextPage: toGuideSettings);
  }

  /// 用户引导设置
  Widget buildAbout() {
    return buildNextSettingsItem(title: "关于", toNextPage: toAbout);
  }

  /// 构建打开下个页面的设置项
  Widget buildNextSettingsItem({
    required String title,
    required VoidCallback toNextPage,
    Key? tutorialKey,
  }) {
    return SlideInLeft(
      child: HgNeumorphicButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            HgNeumorphicNextButton(onPressed: toNextPage),
          ],
        ),
        onPressed: toNextPage,
      ),
    );
  }

  /// 打开首页设置
  void toHomeSettings() {
    String key = "settings_home_settings";
    int id = key.hashCode;
    RouteHelper.bottomPageNested(
      parentId: logic.args.navigatorId,
      nestedId: id,
      page: QuickAccessSettings(
        key: key,
        args: SettingsItemArgs(
          navigatorId: id,
          parentNavigatorId: logic.args.navigatorId,
          onBack: logic.update,
        ),
      ),
    );
  }

  /// 打开同步设置
  void toCloudSettings() {
    String key = "settings_cloud_settings";
    int id = key.hashCode;
    RouteHelper.bottomPageNested(
      parentId: logic.args.navigatorId,
      nestedId: id,
      page: CloudSettingsPage(
        key: key,
        args: SettingsItemArgs(
          navigatorId: id,
          parentNavigatorId: logic.args.navigatorId,
          onBack: logic.update,
        ),
      ),
    );
  }

  /// 打开主题设置
  void toThemeSettings() {
    String key = "settings_theme_settings";
    int id = key.hashCode;
    RouteHelper.bottomPageNested(
      parentId: logic.args.navigatorId,
      nestedId: id,
      page: ThemeSettings(
        key: key,
        args: SettingsItemArgs(
          navigatorId: id,
          parentNavigatorId: logic.args.navigatorId,
          onBack: logic.update,
        ),
      ),
    );
  }

  /// 打开主题设置
  void toGuideSettings() {
    String key = "settings_guide_settings";
    int id = key.hashCode;
    RouteHelper.bottomPageNested(
      parentId: logic.args.navigatorId,
      nestedId: id,
      page: TutorialSettings(
        key: key,
        args: SettingsItemArgs(
          navigatorId: id,
          parentNavigatorId: logic.args.navigatorId,
          onBack: logic.update,
        ),
      ),
    );
  }

  /// 打开关于
  void toAbout() {
    String key = "settings_about";
    int id = key.hashCode;
    RouteHelper.bottomPageNested(
      parentId: logic.args.navigatorId,
      nestedId: id,
      page: About(
        key: key,
        args: SettingsItemArgs(
          navigatorId: id,
          parentNavigatorId: logic.args.navigatorId,
        ),
      ),
    );
  }
}

@immutable
class SettingsItemArgs extends ViewArgs {
  /// 导航id
  final int navigatorId;

  /// 上级导航id
  final int parentNavigatorId;

  /// 返回回调
  final VoidCallback? onBack;

  const SettingsItemArgs({
    required this.navigatorId,
    required this.parentNavigatorId,
    this.onBack,
  });
}

abstract class SettingsItemLogic extends TutorialViewLogicOnlyArgs<SettingsItemArgs> {
  /// 返回
  void back() {
    RouteHelper.back(id: args.parentNavigatorId);
  }

  /// 页面退出调用
  void onBack() {
    args.onBack?.call();
  }

  /// 打开回调
  @override
  void afterArgsUpdate() {}

  @override
  void buildTutorial() {}

  @override
  HomePages get homePage => HomePages.settings;
}

/// 设置项
abstract class SettingsItem<T extends SettingsItemLogic> extends View<T> with ObserverWidget {
  SettingsItem({
    required String key,
    required SettingsItemArgs args,
    required T newLogic,
  }) : super(key: key, args: args, newLogic: newLogic);

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
      trailing: buildTrailing(),
      title: HgNeumorphicText(title),
      bodyPadding: EdgeInsets.zero,
      body: buildSettings(),
    );
  }

  /// 尾部按钮
  Widget? buildTrailing() {
    return null;
  }

  /// 页面名称
  String get title;

  /// 构建具体设置页面
  Widget buildSettings();
}
