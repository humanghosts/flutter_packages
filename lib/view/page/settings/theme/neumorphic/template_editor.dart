import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hg_entity/hg_entity.dart';
import 'package:hg_logger/ability/export.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/main.dart';
import 'package:hg_logger/view/export.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

/// 外部参数
@immutable
class NeumorphicTemplateEditorArgs extends ViewArgs {
  /// 导航id
  final int navigatorId;

  /// 返回调用
  final VoidCallback? onDone;

  const NeumorphicTemplateEditorArgs({required this.navigatorId, this.onDone});
}

/// 外部数据
@immutable
class NeumorphicTemplateEditorDataSource extends ViewDataSource {
  final ThemeTemplate template;
  final NeumorphicThemeTemplateData templateData;

  const NeumorphicTemplateEditorDataSource({required this.template, required this.templateData});
}

/// 逻辑
class NeumorphicTemplateLogic extends ViewLogic<NeumorphicTemplateEditorArgs, NeumorphicTemplateEditorDataSource> {
  /// double类型属性的输入框控制器
  Map<String, TextEditingController> doubleAttrControllerMap = {};

  /// 名称输入框焦点
  FocusNode nameFocusNode = FocusNode();

  /// 名称控制器
  TextEditingController nameCtrl = TextEditingController();

  /// 模板数据
  NeumorphicThemeTemplateData templateData = NeumorphicThemeTemplateData();

  /// 名称数据
  String? name;

  @override
  void afterArgsUpdate() {
    super.afterArgsUpdate();
    templateData = dataSource.templateData.clone() as NeumorphicThemeTemplateData;
    name = dataSource.template.name.value;
  }

  /// 返回
  void back() {
    RouteHelper.back(id: args.navigatorId);
  }

  /// 保存
  void done() {
    dataSource.template.name.value = name;
    dataSource.templateData.merge(templateData);
    back();
    args.onDone?.call();
  }

  /// 修改名称
  void setName(String name) {
    this.name = name;
  }

  /// 颜色修改
  void colorChange(Attribute<int> attribute, Color color) {
    attribute.value = color.value;
    update();
  }

  /// 修改浮点类型的值
  void doubleChange(Attribute<double> attribute, double parse) {
    attribute.value = parse;
    update();
  }
}

/// 页面
class NeumorphicTemplateEditor extends View<NeumorphicTemplateLogic> {
  NeumorphicTemplateEditor({
    required String key,
    required NeumorphicTemplateEditorArgs args,
    required NeumorphicTemplateEditorDataSource dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, newLogic: NeumorphicTemplateLogic());

  @override
  Widget buildView(BuildContext context) {
    return HgNeumorphicScaffold(
      leading: HgNeumorphicBackButton(onPressed: logic.back),
      trailing: HgNeumorphicDoneButton(onPressed: logic.done),
      title: buildName(),
      bodyPadding: EdgeInsets.zero,
      body: SlidingUpPanel(
        body: buildNeumorphicTemplate(),
        maxHeight: Get.height * 0.85,
        panel: Neumorphic(
          child: SizedBox(height: Get.height * 0.85, child: buildPreview()),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  /// 模板名称
  Widget buildName() {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    logic.nameCtrl.text = logic.name ?? "";
    return Container(
      alignment: Alignment.center,
      width: 100,
      child: Neumorphic(
        style: NeumorphicStyle(depth: -themeData.depth),
        child: TextField(
          focusNode: logic.nameFocusNode,
          controller: logic.nameCtrl,
          onChanged: logic.setName,
          decoration: InputDecoration(
            hintText: "模板名称",
            hintStyle: TextStyle(color: themeData.disabledColor),
          ),
        ),
      ),
    );
  }

  /// 内部内容
  Widget buildNeumorphicTemplate() {
    NeumorphicThemeTemplateData templateData = logic.templateData;
    List<Attribute> attributeList = [
      templateData.baseColor,
      templateData.shadowLightColor,
      templateData.shadowDarkColor,
      templateData.shadowLightColorEmboss,
      templateData.shadowDarkColorEmboss,
      templateData.borderColor,
      templateData.defaultTextColor,
      templateData.defaultIconColor,
      templateData.disabledColor,
      templateData.accentColor,
      templateData.depth,
      templateData.borderWidth,
      templateData.intensity
    ];

    List<StairedGridTile> pattern = [];
    for (Attribute attribute in attributeList) {
      StairedGridTile tile;
      if (attribute is IntegerAttribute) {
        tile = const StairedGridTile(0.5, 2);
      } else {
        tile = const StairedGridTile(1, 4);
      }
      pattern.add(tile);
    }

    return GridView.builder(
      padding: EdgeInsets.only(bottom: Get.height * 0.5),
      clipBehavior: Clip.none,
      itemCount: attributeList.length,
      gridDelegate: SliverStairedGridDelegate(
        mainAxisSpacing: 1,
        crossAxisSpacing: 1,
        pattern: pattern,
      ),
      itemBuilder: (context, index) {
        Attribute attribute = attributeList[index];
        Widget child;
        if (attribute is IntegerAttribute) {
          child = buildColor(attribute as Attribute<int>);
        } else {
          double min;
          double max;
          if (attribute.name == templateData.intensity.name) {
            min = 0;
            max = 1;
          } else {
            min = 0;
            max = 4;
          }
          child = buildDouble(attribute as Attribute<double>, min, max);
        }
        return Neumorphic(
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.all(8),
          child: child,
        );
      },
    );
  }

  /// 构建颜色类型属性
  Widget buildColor(Attribute<int> attribute) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(attribute.title),
        Expanded(
          child: HgNeumorphicButton(
            margin: const EdgeInsets.only(top: 8),
            style: NeumorphicStyle(color: Color(attribute.value)),
            child: Container(),
            // 修改颜色
            onPressed: () => toColorSelect(attribute),
          ),
        ),
      ],
    );
  }

  /// 构建浮点类型属性
  Widget buildDouble(Attribute<double> attribute, double min, double max) {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    TextEditingController controller = logic.doubleAttrControllerMap.putIfAbsent(attribute.name, () => TextEditingController());
    controller.text = attribute.value.toStringAsFixed(2);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("${attribute.title} : ${attribute.value.toStringAsFixed(2)}"),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 4,
                child: NeumorphicSlider(
                  value: attribute.value,
                  min: min,
                  max: max,
                  style: SliderStyle(depth: themeData.depth),
                  onChanged: (double percent) {
                    String text = percent.toStringAsFixed(2);
                    controller.text = text;
                    logic.doubleChange(attribute, double.parse(text));
                  },
                ),
              ),
              const Padding(padding: EdgeInsets.only(left: 8)),
              Expanded(
                flex: 1,
                child: Neumorphic(
                  style: NeumorphicStyle(depth: -themeData.depth),
                  padding: const EdgeInsets.only(bottom: 12),
                  child: TextField(
                    controller: controller,
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9.]"))],
                    textInputAction: TextInputAction.done,
                    onSubmitted: (String value) {
                      if (value.isEmpty) value = "0";
                      double percent = double.parse(value);
                      if (percent > max) percent = max;
                      if (percent < min) percent = min;
                      controller.text = percent.toStringAsFixed(2);
                      logic.doubleChange(attribute, percent);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void toColorSelect(Attribute<int> attribute) {
    RouteHelper.to(
      page: HgNeumorphicScaffold(
        leading: HgNeumorphicBackButton(onPressed: () {
          logic.back();
          logic.update();
        }),
        title: Text(attribute.title),
        body: ColorPicker(
          key: attribute.hashCode.toString(),
          args: ColorPickerArgs(
            showPreview: true,
            navigatorId: logic.args.navigatorId,
            initColor: Color(attribute.value),
            onColorChanged: (color) => logic.colorChange(attribute, color),
          ),
        ),
      ),
      id: logic.args.navigatorId,
    );
  }

  /// 构建预览，用snapping sheet 拉起查看
  Widget buildPreview() {
    NeumorphicThemeData themeData = logic.templateData.toNeumorphicThemeData();
    return Theme(
      data: logic.templateData.toThemeData(),
      child: NeumorphicTheme(
        theme: themeData,
        darkTheme: themeData,
        child: HgNeumorphicScaffold(
          leading: HgNeumorphicBackButton(onPressed: () {}, themeData: themeData),
          trailing: HgNeumorphicDoneButton(onPressed: () {}, themeData: themeData),
          title: HgNeumorphicText("预览", color: themeData.defaultTextColor),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HgNeumorphicButton(
                child: const Text("按钮1"),
                themeData: themeData,
                onPressed: () {},
              ),
              const Padding(padding: EdgeInsets.only(top: 12)),
              HgNeumorphicButton(
                padding: const EdgeInsets.all(12),
                themeData: themeData,
                child: const Text("按钮2"),
                style: const NeumorphicStyle(boxShape: NeumorphicBoxShape.circle()),
                onPressed: () {},
              ),
              const Padding(padding: EdgeInsets.only(top: 12)),
              HgNeumorphicButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("按钮3"),
                    HgNeumorphicNextButton(onPressed: () {}),
                  ],
                ),
                themeData: themeData,
                onPressed: () {},
              ),
              const Padding(padding: EdgeInsets.only(top: 12)),
              HgNeumorphicIcon(FontAwesomeIcons.icons, themeData: themeData),
              const Padding(padding: EdgeInsets.only(top: 12)),
              const Text("普通文字"),
              const Padding(padding: EdgeInsets.only(top: 12)),
              Text("强调文字", style: TextStyle(color: themeData.accentColor)),
              const Padding(padding: EdgeInsets.only(top: 12)),
              Text("禁用文字", style: TextStyle(color: themeData.disabledColor)),
              const Padding(padding: EdgeInsets.only(top: 12)),
              SizedBox(
                height: 40,
                width: 40 / 0.618,
                child: Neumorphic(child: const Center(child: Text("凸起"))),
              ),
              const Padding(padding: EdgeInsets.only(top: 12)),
              SizedBox(
                height: 40,
                width: 40 / 0.618,
                child: Neumorphic(
                  style: const NeumorphicStyle(depth: -4),
                  child: const Center(child: Text("凹陷")),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 12)),
              SizedBox(
                height: 40,
                width: 40 / 0.618,
                child: Neumorphic(
                  style: NeumorphicStyle(border: NeumorphicBorder(color: themeData.borderColor, width: themeData.borderWidth)),
                  child: const Center(child: Text("边框")),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
