import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:hg_logger/ability/export.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/main.dart';
import 'package:hg_logger/service/services.dart';
import 'package:hg_logger/view/export.dart';
import 'package:hg_logger/view/page/settings/settings.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import 'neumorphic/template_row.dart';

/// 逻辑
class ThemeSettingsLogic extends SettingsItemLogic {
  ThemeConfig themeConfig = ThemeConfig();

  /// 主题配置服务
  ThemeConfigService service = ThemeConfigService.instance;

  /// 模板保存服务
  final ThemeTemplateService templateService = ThemeTemplateService.instance;

  /// 新拟态主题模板
  List<ThemeTemplate> neumorphicList = [];

  Rx<int> neumorphicListUpdateFlag = 0.obs;

  @override
  void afterArgsUpdate() async {
    super.afterArgsUpdate();
    themeConfig = await service.find();
    neumorphicListUpdateFlag.value = 0;
    neumorphicList = themeConfig.templateList.value.where((element) {
      ThemeDataValue dataValue = element.data.value;
      if (dataValue.isNull) return false;
      if (dataValue.themeType != ThemeType.neumorphic) return false;
      return true;
    }).toList();
    neumorphicListUpdateFlag.value++;
  }

  /// 保存配置
  void saveConfigAndUpdateTheme() async {
    await service.save(themeConfig);
    MainLogic.instance.updateTheme(themeConfig);
    update();
  }

  /// 设置默认深色主题
  void setDark(ThemeTemplate template) {
    themeConfig.dark.value = template;
    if (template.data.value.themeType == ThemeType.neumorphic) neumorphicListUpdateFlag.value++;
    saveConfigAndUpdateTheme();
  }

  /// 设置默认浅色主题
  void setLight(ThemeTemplate template) {
    themeConfig.light.value = template;
    if (template.data.value.themeType == ThemeType.neumorphic) neumorphicListUpdateFlag.value++;
    saveConfigAndUpdateTheme();
  }

  /// 保存模板
  void saveTemplate(ThemeTemplate template) {
    templateService.save(template);
    Set<String> idSet = themeConfig.templateList.value.map((e) => e.id.value).toSet();
    if (!idSet.contains(template.id.value)) {
      themeConfig.templateList.add(template);
    }
    if (template.data.value.themeType == ThemeType.neumorphic) {
      Set<String> idSet = neumorphicList.map((e) => e.id.value).toSet();
      if (!idSet.contains(template.id.value)) {
        neumorphicList.add(template);
      }
      neumorphicListUpdateFlag.value++;
    }
    saveConfigAndUpdateTheme();
  }

  /// 移除模板
  void removeTemplate(ThemeTemplate template) async {
    if (themeConfig.dark.value.id.value == template.id.value) return RouteHelper.toast(msg: "已设置为默认深色主题，不可删除");
    if (themeConfig.light.value.id.value == template.id.value) return RouteHelper.toast(msg: "已设置为默认浅色主题，不可删除");
    bool? result = await RouteHelper.showTwoChoiceRequest();
    if (result != true) return;
    await templateService.remove(template);
    themeConfig.templateList.removeWhere((e) => e.id.value == template.id.value);
    if (template.data.value.themeType == ThemeType.neumorphic) {
      neumorphicList.removeWhere((e) => e.id.value == template.id.value);
      neumorphicListUpdateFlag.value++;
    }
    saveConfigAndUpdateTheme();
  }

  @override
  void buildTutorial() {
    super.buildTutorial();
    buildAndAddTargetFocus(
      "neumorphic",
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) => HgNeumorphicText("新拟态主题列表，\n左右滑动可查看更多主题"),
        ),
      ],
    );
  }

  @override
  String? get tutorialSubKey => "theme";
}

/// 页面
class ThemeSettings extends SettingsItem<ThemeSettingsLogic> {
  ThemeSettings({required String key, required SettingsItemArgs args})
      : super(
          key: key,
          args: args,
          newLogic: ThemeSettingsLogic(),
        );

  @override
  String get title => "显示设置";

  @override
  Widget buildSettings() {
    return ListView(
      clipBehavior: Clip.none,
      padding: EdgeInsets.only(left: 12, right: 12, bottom: Get.height * 0.5, top: 12),
      children: [
        buildNeumorphic(),
      ],
    );
  }

  Widget buildNeumorphic() {
    return Container(
      key: logic.addTutorialTargetKey(0, "neumorphic"),
      child: Obx(() {
        debugPrint("新拟态主题更新次数:${logic.neumorphicListUpdateFlag.value}");
        return NeumorphicTemplateRow(
          key: "neumorphic_template_row",
          args: TemplateRowArgs(
            navigatorId: logic.args.navigatorId,
            onRemove: logic.removeTemplate,
            onSetLight: logic.setLight,
            onSetDark: logic.setDark,
            onSave: logic.saveTemplate,
          ),
          dataSource: TemplateRowDataSource(config: logic.themeConfig, templateList: logic.neumorphicList),
        );
      }),
    );
  }
}

/// 外部参数
@immutable
class TemplateRowArgs extends ViewArgs {
  /// 导航id
  final int navigatorId;

  /// 模板删除回调
  final ValueChanged<ThemeTemplate>? onRemove;

  /// 设置默认浅色主题回调
  final ValueChanged<ThemeTemplate>? onSetLight;

  /// 设置默认深色主题回调
  final ValueChanged<ThemeTemplate>? onSetDark;

  /// 保存回调
  final ValueChanged<ThemeTemplate>? onSave;

  const TemplateRowArgs({
    required this.navigatorId,
    this.onRemove,
    this.onSetLight,
    this.onSetDark,
    this.onSave,
  });
}

/// 外部数据
@immutable
class TemplateRowDataSource extends ViewDataSource {
  final List<ThemeTemplate> templateList;
  final ThemeConfig config;

  const TemplateRowDataSource({required this.templateList, required this.config});
}

/// 逻辑
abstract class TemplateRowLogic extends TutorialViewLogic<TemplateRowArgs, TemplateRowDataSource> {
  @override
  void buildTutorial() {}

  @override
  HomePages get homePage => HomePages.settings;

  @override
  String? get tutorialSubKey => "template_row";
}

/// 模板行
abstract class TemplateRow<L extends TemplateRowLogic> extends View<L> {
  TemplateRow({
    required String key,
    required TemplateRowArgs args,
    required TemplateRowDataSource dataSource,
    required L newLogic,
  }) : super(key: key, args: args, dataSource: dataSource, newLogic: newLogic);

  @override
  Widget buildView(BuildContext context) {
    return Column(
      children: [
        buildTitle(),
        const Padding(padding: EdgeInsets.only(top: 12)),
        buildTemplateList(),
      ],
    );
  }

  /// 构建标题
  Widget buildTitle() {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return Row(children: [Text(title, style: TextStyle(color: themeData.disabledColor))]);
  }

  /// 标题名称
  String get title;

  Widget buildTemplateList() {
    List<ThemeTemplate> templateList = logic.dataSource.templateList;
    return SizedBox(
      height: Get.height * 0.4,
      child: GridView.builder(
        clipBehavior: Clip.none,
        scrollDirection: Axis.horizontal,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 1 / 0.618,
          crossAxisSpacing: 0,
          mainAxisSpacing: 12,
        ),
        itemBuilder: (context, index) {
          Widget child;
          if (index == templateList.length) {
            child = buildTemplateAdd();
          } else {
            child = buildTemplate(templateList[index], index);
          }
          return child;
        },
        itemCount: templateList.length + 1,
      ),
    );
  }

  /// 构建模板预览
  Widget buildTemplate(ThemeTemplate template, int index);

  /// 新增模板
  Widget buildTemplateAdd();
}
