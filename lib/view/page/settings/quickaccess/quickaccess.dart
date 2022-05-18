import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/main.dart';
import 'package:hg_logger/service/services.dart';
import 'package:hg_logger/view/export.dart';

import '../settings.dart';

/// 逻辑
class QuickAccessSettingsLogic extends SettingsItemLogic {
  /// 所有可设置的页面
  final List<HomePages> pageList = [
    HomePages.event,
    HomePages.attribute,
    HomePages.schedule,
    HomePages.focus,
    HomePages.settings,
  ];

  /// 设置服务
  final QuickAccessConfigService service = QuickAccessConfigService.instance;

  /// 设置
  QuickAccessConfig config = QuickAccessConfig();

  /// 设置更新标识
  Rx<int> configUpdateFlag = 0.obs;

  /// 列表选择更新包标识
  Rx<int> selectedUpdateFlag = 0.obs;

  /// 打开回调
  @override
  void afterArgsUpdate() {
    super.afterArgsUpdate();
    configUpdateFlag = 0.obs;
    selectedUpdateFlag.value = 0;
    find();
  }

  /// 查找设置
  void find() async {
    config = await service.find();
    configUpdateFlag.value++;
    selectedUpdateFlag.value++;
  }

  /// 选择主页显示的内容
  void selectPage(bool select, HomePages page) {
    List<String> selectedValue = config.homePages.value.where((e) => !e.isNull).map((e) => e.page!.value).toList();
    if (select && selectedValue.contains(page.value)) return;
    if (!select && !selectedValue.contains(page.value)) return;
    if (select) {
      config.homePages.add(PageValue(page: page));
    } else {
      int index = config.homePages.value.indexWhere((e) => e.page?.value == page.value);
      config.homePages.removeAt(index);
    }
    selectedUpdateFlag.value++;
  }

  /// 保存
  void done() async {
    await service.save(config);
    back();
  }
}

/// 页面
class QuickAccessSettings extends SettingsItem<QuickAccessSettingsLogic> {
  QuickAccessSettings({
    required String key,
    required SettingsItemArgs args,
  }) : super(
          key: key,
          args: args,
          newLogic: QuickAccessSettingsLogic(),
        );

  @override
  String get title => "快速访问设置";

  @override
  Widget? buildTrailing() => HgNeumorphicDoneButton(onPressed: logic.done);

  @override
  Widget buildSettings() {
    return ListView(
      clipBehavior: Clip.none,
      padding: EdgeInsets.only(left: 12, right: 12, bottom: Get.height * 0.5, top: 12),
      children: [
        buildHomePageList(),
      ],
    );
  }

  Widget buildHomePageList() {
    return HgNeumorphicExpandedButton(
      key: "settings_home_settings_page_list",
      args: HgNeumorphicExpandedButtonArgs(
        left: const Text("标签页设置"),
        child: Column(
          children: [
            buildSelectedList(),
            const Padding(padding: EdgeInsets.only(top: 16)),
            buildUnSelectedList(),
          ],
        ),
      ),
    );
  }

  /// 已选列表
  Widget buildSelectedList() {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [Text("已选页面", style: TextStyle(color: themeData.disabledColor))],
        ),
        const Padding(padding: EdgeInsets.only(top: 4)),
        Obx(() {
          int selectedUpdateFlag = logic.selectedUpdateFlag.value;
          debugPrint("已选页面更新次数:$selectedUpdateFlag");
          List<Widget> children = [];
          QuickAccessConfig settings = logic.config;
          List<HomePages> pageList = settings.homePages.value.where((e) => !e.isNull).map((e) => e.page!).toList();
          for (HomePages page in pageList) {
            children.add(HgNeumorphicButton(
              key: ValueKey(page.value),
              margin: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                children: [
                  HgNeumorphicIcon(page.iconData),
                  const Padding(padding: EdgeInsets.only(left: 8)),
                  Text(page.title),
                  const Spacer(),
                  HgNeumorphicButton(
                    child: HgNeumorphicIcon(Icons.remove),
                    onPressed: () => logic.selectPage(false, page),
                  ),
                ],
              ),
              onPressed: () => logic.selectPage(false, page),
            ));
          }
          return Column(children: children);
        }),
      ],
    );
  }

  /// 备选列表
  Widget buildUnSelectedList() {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [Text("备选页面", style: TextStyle(color: themeData.disabledColor))],
        ),
        const Padding(padding: EdgeInsets.only(top: 4)),
        Obx(() {
          int selectedUpdateFlag = logic.selectedUpdateFlag.value;
          debugPrint("备选页面更新次数:$selectedUpdateFlag");
          List<Widget> children = [];
          QuickAccessConfig settings = logic.config;
          List<String> selectedValue = settings.homePages.value.where((e) => !e.isNull).map((e) => e.page!.value).toList();
          List<HomePages> pageList = logic.pageList.where((e) => !selectedValue.contains(e.value)).toList();
          for (HomePages page in pageList) {
            children.add(HgNeumorphicButton(
              key: ValueKey(page.value),
              margin: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                children: [
                  HgNeumorphicIcon(page.iconData),
                  const Padding(padding: EdgeInsets.only(left: 8)),
                  Text(page.title),
                  const Spacer(),
                  HgNeumorphicButton(
                    child: HgNeumorphicIcon(Icons.add),
                    onPressed: () => logic.selectPage(true, page),
                  ),
                ],
              ),
              onPressed: () => logic.selectPage(true, page),
            ));
          }
          return Column(children: children);
        }),
      ],
    );
  }
}
