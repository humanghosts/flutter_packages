import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hg_logger/ability/export.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/main.dart';
import 'package:hg_logger/view/enum/page_states.dart';
import 'package:hg_logger/view/export.dart';
import 'package:hg_logger/view/page/settings/theme/theme.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import 'template_editor.dart';

/// 逻辑
class NeumorphicTemplateRowLogic extends TemplateRowLogic {
  @override
  void buildTutorial() {
    super.buildTutorial();
    buildAndAddTargetFocus(
      "name",
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) => HgNeumorphicText("主题名称"),
        ),
      ],
    );
    buildAndAddTargetFocus(
      "remove_button",
      shape: ShapeLightFocus.Circle,
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) => HgNeumorphicText("删除按钮，\n点击可删除该主题"),
        ),
      ],
    );
    buildAndAddTargetFocus(
      "preview",
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) => HgNeumorphicText("主题预览，\n简单预览该主题内容"),
        ),
      ],
    );
    buildAndAddTargetFocus(
      "edit_button",
      shape: ShapeLightFocus.Circle,
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) => HgNeumorphicText("编辑按钮，\n点击可进入主题编辑页面编辑该主题"),
        ),
      ],
    );
    buildAndAddTargetFocus(
      "set_light_button",
      shape: ShapeLightFocus.Circle,
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) => HgNeumorphicText("浅色模式主题按钮，\n点击可设置为浅色模式默认主题"),
        ),
      ],
    );
    buildAndAddTargetFocus(
      "set_dark_button",
      shape: ShapeLightFocus.Circle,
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) => HgNeumorphicText("深色模式主题按钮，\n点击可设置为深色模式默认主题"),
        ),
      ],
    );
  }

  @override
  String? get tutorialSubKey => "neumorphic_template";
}

/// 页面
class NeumorphicTemplateRow extends TemplateRow<NeumorphicTemplateRowLogic> {
  NeumorphicTemplateRow({
    required String key,
    required TemplateRowArgs args,
    required TemplateRowDataSource dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, newLogic: NeumorphicTemplateRowLogic());

  @override
  String get title => "新拟态主题";

  ///  构建模板
  @override
  Widget buildTemplate(ThemeTemplate template, int index) {
    // 模板配置
    ThemeConfig config = logic.dataSource.config;
    // 当前主题
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    // 当前模板主题数据
    NeumorphicThemeTemplateData templateData = template.data.value.themeData as NeumorphicThemeTemplateData;
    // 当前模板主题
    NeumorphicThemeData templateThemeData = templateData.toNeumorphicThemeData();
    // 是否是默认深色模式主题
    bool isDark = template.id.value == config.dark.value.id.value;
    // 是否是默认浅色模式主题
    bool isLight = template.id.value == config.light.value.id.value;
    bool isFirst = index == 0;
    return Neumorphic(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          // 模板名称
          Expanded(
            flex: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  template.name.value ?? "未命名",
                  key: isFirst ? logic.addTutorialTargetKey(0, "name") : null,
                  style: TextStyle(color: template.name.isNull ? themeData.disabledColor : null),
                ),
                HgNeumorphicButton(
                  key: isFirst ? logic.addTutorialTargetKey(1, "remove_button") : null,
                  getTooltip: () => "删除主题",
                  padding: const EdgeInsets.all(4),
                  style: const NeumorphicStyle(boxShape: NeumorphicBoxShape.circle()),
                  child: HgNeumorphicIcon(Icons.delete_forever, color: Colors.red),
                  onPressed: () => logic.args.onRemove?.call(template),
                ),
              ],
            ),
          ),
          Expanded(
            child: NeumorphicTheme(
              theme: templateThemeData,
              darkTheme: templateThemeData,
              child: Theme(
                data: templateData.toThemeData(),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Neumorphic(
                      key: isFirst ? logic.addTutorialTargetKey(2, "preview") : null,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text("默认颜色"),
                          Text("禁用颜色", style: TextStyle(color: templateThemeData.disabledColor)),
                          Text("强调颜色", style: TextStyle(color: templateThemeData.accentColor)),
                          HgNeumorphicButton(child: const Text("按钮"), onPressed: () {}),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 0,
            child: Row(
              children: [
                HgNeumorphicButton(
                  key: isFirst ? logic.addTutorialTargetKey(3, "edit_button") : null,
                  getTooltip: () => "编辑主题",
                  padding: const EdgeInsets.all(4),
                  style: const NeumorphicStyle(boxShape: NeumorphicBoxShape.circle()),
                  child: HgNeumorphicIcon(Icons.edit),
                  onPressed: () => toTemplateDetail(template, template.data.value.themeData as NeumorphicThemeTemplateData, PageState.edit),
                ),
                const Spacer(),
                HgNeumorphicButton(
                  key: isFirst ? logic.addTutorialTargetKey(4, "set_light_button") : null,
                  getTooltip: () => "设置为浅色主题",
                  padding: const EdgeInsets.all(4),
                  style: NeumorphicStyle(depth: isLight ? -themeData.depth : themeData.depth, boxShape: const NeumorphicBoxShape.circle()),
                  child: HgNeumorphicIcon(Icons.light_mode, color: isLight ? themeData.accentColor : themeData.disabledColor),
                  onPressed: () => logic.args.onSetLight?.call(template),
                ),
                const Padding(padding: EdgeInsets.only(right: 8)),
                HgNeumorphicButton(
                  key: isFirst ? logic.addTutorialTargetKey(5, "set_dark_button") : null,
                  getTooltip: () => "设置为深色主题",
                  padding: const EdgeInsets.all(4),
                  style: NeumorphicStyle(depth: isDark ? -themeData.depth : themeData.depth, boxShape: const NeumorphicBoxShape.circle()),
                  child: HgNeumorphicIcon(Icons.dark_mode, color: isDark ? themeData.accentColor : themeData.disabledColor),
                  onPressed: () => logic.args.onSetDark?.call(template),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  /// 构建新增模板
  @override
  Widget buildTemplateAdd() {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return HgNeumorphicButton(
      getTooltip: () => "新建主题",
      padding: const EdgeInsets.all(8),
      child: Stack(
        children: [
          Row(children: [Text("新建主题", style: TextStyle(color: themeData.disabledColor))]),
          Center(child: HgNeumorphicIcon(FontAwesomeIcons.plus))
        ],
      ),
      onPressed: () {
        NeumorphicThemeTemplateData templateData = NeumorphicThemeTemplateData();
        ThemeTemplate template = ThemeTemplate(name: "新建主题")
          ..data.value = ThemeDataValue(
            themeType: ThemeType.neumorphic,
            themeData: templateData,
          );
        toTemplateDetail(template, templateData, PageState.add);
      },
    );
  }

  /// 打开明细
  void toTemplateDetail(ThemeTemplate template, NeumorphicThemeTemplateData templateData, PageState states) {
    RouteHelper.to(
      id: logic.args.navigatorId,
      page: NeumorphicTemplateEditor(
        key: template.id.value,
        args: NeumorphicTemplateEditorArgs(
          navigatorId: logic.args.navigatorId,
          onDone: () => logic.args.onSave?.call(template),
        ),
        dataSource: NeumorphicTemplateEditorDataSource(template: template, templateData: templateData),
      ),
    );
  }
}
