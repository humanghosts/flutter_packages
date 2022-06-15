import 'dart:developer';
import 'dart:math' as math;

import 'package:badges/badges.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hg_framework/ability/export.dart';
import 'package:hg_framework/ability/shared_preferences/prefs.dart';
import 'package:hg_framework/hg_framework.dart';
import 'package:hg_framework/view/page/page.dart' as hg;

import 'theme_template.dart';

/// 模板的可操作动作枚举
enum ThemeTemplateOption {
  use,
  edit,
  remove,
}

/// 获取动作名称
extension ThemeTemplateOptionExtension on ThemeTemplateOption {
  String get title {
    switch (this) {
      case ThemeTemplateOption.use:
        return "使用";
      case ThemeTemplateOption.edit:
        return "编辑";
      case ThemeTemplateOption.remove:
        return "删除";
    }
  }

  Widget get icon {
    switch (this) {
      case ThemeTemplateOption.use:
        return const Icon(Icons.color_lens_outlined);
      case ThemeTemplateOption.edit:
        return const Icon(Icons.edit_outlined);
      case ThemeTemplateOption.remove:
        return const Icon(Icons.delete_outlined);
    }
  }
}

/// 模板列表类型
enum ThemeTemplateViewType { list, grid }

extension ThemeTemplateViewTypeExtension on ThemeTemplateViewType {
  /// name:type
  static Map<String, ThemeTemplateViewType> typeStrMap = {
    ThemeTemplateViewType.list.name: ThemeTemplateViewType.list,
    ThemeTemplateViewType.grid.name: ThemeTemplateViewType.grid,
  };

  /// 通过name获取type
  static ThemeTemplateViewType getTypeByStr(String? typeStr) {
    return typeStrMap[typeStr] ?? ThemeTemplateViewType.list;
  }

  String get title {
    switch (this) {
      case ThemeTemplateViewType.list:
        return "列表";
      case ThemeTemplateViewType.grid:
        return "表格";
    }
  }
}

/// 逻辑
class ThemeConfigViewLogic extends PageLogicOnly {
  static const templateViewTypeKey = "template_view_type";

  late AnimationController animationController;

  /// 主题列表展示方式
  Rx<ThemeTemplateViewType> templateViewType = ThemeTemplateViewType.list.obs;

  /// 主题列表更新方式
  Rx<int> templateViewUpdateFlag = 0.obs;

  /// 构建前查询列表展示方式
  @override
  void onWidgetBuild(BuildContext context) {
    super.onWidgetBuild(context);
    templateViewType.value = ThemeTemplateViewTypeExtension.getTypeByStr(PrefsHelper.prefs.getString(templateViewTypeKey));
    animationController = AnimationController(duration: AppLogic.appConfig.animationConfig.middleAnimationDuration, vsync: SimpleTickerProvider());
    if (templateViewType.value == ThemeTemplateViewType.grid) {
      animationController.reverse();
    } else {
      animationController.forward();
    }
  }

  /// 使用指定模板
  void useTemplate(ThemeTemplate template) {
    AppLogic.instance.useThemeTemplate(template);
  }

  /// 删除指定模板 并更新主题列表
  void removeTemplate(ThemeTemplate template) {
    AppLogic.instance.removeThemeTemplate(template);
    templateViewUpdateFlag.value++;
  }

  /// 更换主题列表展示方式
  void changeTemplateViewType(ThemeTemplateViewType viewType) async {
    if (viewType == templateViewType.value) return;
    PrefsHelper.prefs.setString(templateViewTypeKey, viewType.name);
    templateViewType.value = viewType;
    if (templateViewType.value == ThemeTemplateViewType.grid) {
      animationController.reverse();
    } else {
      animationController.forward();
    }
  }
}

/// 主题设置页面
class ThemeConfigView extends hg.Page<ThemeConfigViewLogic> {
  ThemeConfigView({required String key}) : super(key: key, logic: ThemeConfigViewLogic());

  @override
  Widget buildView(BuildContext context) {
    return AnnotatedRegion(
      value: FlexColorScheme.themedSystemNavigationBar(
        context,
        systemNavBarStyle: AppLogic.currentThemeTemplate.sysNavBarStyle.value.style,
        useDivider: AppLogic.currentThemeTemplate.useSysNavDivider.value,
        opacity: AppLogic.currentThemeTemplate.sysNavBarOpacity.value,
      ),
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
          title: const Text("主题选择"),
          centerTitle: false,
          actions: [
            Obx(() {
              ThemeTemplateViewType type = logic.templateViewType.value;
              int nextIndex = type.index + 1;
              int realNextIndex = nextIndex % ThemeTemplateViewType.values.length;
              ThemeTemplateViewType nextType = ThemeTemplateViewType.values[realNextIndex];
              return IconButton(
                key: ValueKey(nextType.name),
                onPressed: () => logic.changeTemplateViewType(nextType),
                icon: AnimatedIcon(
                  icon: AnimatedIcons.list_view,
                  progress: logic.animationController,
                ),
                tooltip: "按${nextType.title}显示",
              );
            }),
          ],
        ),
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: Obx(() {
          // 使用.value才能处罚绑定，否则Obx不生效
          log("主题列表展示方式:${logic.templateViewType.value.title}");
          log("主题列表更新:${logic.templateViewUpdateFlag.value}");
          ThemeConfig themeConfig = AppLogic.instance.themeConfig;
          ThemeTemplate inUseTemplate = themeConfig.templateInUse.value;
          List<ThemeTemplate> templateList = themeConfig.templateList.value;
          // 将正在使用中的模板放到第一个
          templateList.removeWhere((element) => element.id.value == inUseTemplate.id.value);
          templateList.insert(0, inUseTemplate);
          Widget child;
          if (logic.templateViewType.value == ThemeTemplateViewType.list) {
            child = buildTemplateList(context, templateList: templateList, inUseTemplate: inUseTemplate);
          } else {
            child = buildTemplateGrid(context, templateList: templateList, inUseTemplate: inUseTemplate);
          }
          return AnimatedSwitcher(
            duration: logic.middleAnimationDuration,
            child: Container(key: ValueKey(logic.templateViewType.value), child: child),
          );
        }),
      ),
    );
  }

  /// 主题模板列表
  Widget buildTemplateList(
    BuildContext context, {
    required List<ThemeTemplate> templateList,
    required ThemeTemplate inUseTemplate,
  }) {
    double width = Get.width;
    int columnLength = math.max((width / 400).floor(), 1);

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columnLength,
        mainAxisExtent: 64,
      ),
      padding: EdgeInsets.only(
        top: kToolbarHeight + Get.mediaQuery.padding.top + 6,
        bottom: Get.height * 0.4,
      ),
      itemCount: templateList.length,
      itemBuilder: (context, index) {
        ThemeTemplate template = templateList[index];
        bool isInUse = template.id.value == inUseTemplate.id.value;
        return Center(
          child: Card(
            shape: RoundedRectangleBorder(
              side: isInUse ? BorderSide(width: 2, color: Theme.of(context).primaryColor) : BorderSide.none,
              borderRadius: BorderRadius.circular(inUseTemplate.elevatedButtonBorderRadius.value ?? inUseTemplate.defaultRadius.value ?? 12),
            ),
            child: buildTemplateListItem(context, template, isInUse),
          ),
        );
      },
    );
  }

  /// 构建列表模板项
  Widget buildTemplateListItem(BuildContext context, ThemeTemplate template, bool isInUse) {
    FlexSchemeColor flexSchemeColor = template.toFlexSchemeColor();
    // 主题名称
    String? templateName = template.name.value;
    return ListTile(
      minVerticalPadding: 0,
      leading: SizedBox(
        width: 120,
        child: Card(
          child: Row(
            children: [
              Expanded(child: Container(color: flexSchemeColor.primary)),
              Expanded(child: Container(color: flexSchemeColor.primaryContainer)),
              Expanded(child: Container(color: flexSchemeColor.secondary)),
              Expanded(child: Container(color: flexSchemeColor.secondaryContainer)),
              Expanded(child: Container(color: flexSchemeColor.tertiary)),
              Expanded(child: Container(color: flexSchemeColor.tertiaryContainer)),
            ],
          ),
        ),
      ),
      title: Text(
        templateName ?? "未命名",
        style: TextStyle(
          overflow: TextOverflow.ellipsis,
          color: templateName == null ? Theme.of(context).disabledColor : null,
        ),
      ),
      trailing: IconButton(
        icon: Icon(Icons.adaptive.more),
        tooltip: "显示操作项",
        onPressed: () => showTemplateGridItemOption(context, template, isInUse),
      ),
      onTap: () => isInUse ? null : logic.useTemplate(template),
    );
  }

  /// 主题模板表格
  Widget buildTemplateGrid(
    BuildContext context, {
    required List<ThemeTemplate> templateList,
    required ThemeTemplate inUseTemplate,
  }) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 100,
        childAspectRatio: 0.618,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      padding: EdgeInsets.only(
        top: kToolbarHeight + Get.mediaQuery.padding.top + 6,
        left: 6,
        right: 6,
        bottom: Get.height * 0.4,
      ),
      itemCount: templateList.length,
      itemBuilder: (context, index) {
        ThemeTemplate template = templateList[index];
        return buildTemplateGridItem(context, template, template.id.value == inUseTemplate.id.value);
      },
    );
  }

  /// 构建表格模板项
  Widget buildTemplateGridItem(BuildContext context, ThemeTemplate template, bool isInUse) {
    FlexSchemeColor flexSchemeColor = template.toFlexSchemeColor();
    ThemeTemplate inUseTemplate = AppLogic.currentThemeTemplate;
    ThemeData theme = AppLogic.instance.themeData;
    // 主题名称
    String? templateName = template.name.value;
    return Column(
      children: [
        // 颜色
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                side: isInUse ? BorderSide(width: 2, color: Theme.of(context).primaryColor) : BorderSide.none,
                borderRadius: BorderRadius.circular(inUseTemplate.elevatedButtonBorderRadius.value ?? inUseTemplate.defaultRadius.value ?? 12),
              ),
            ),
            // 点击整体将模板设置为默认模板
            onPressed: () => isInUse ? null : logic.useTemplate(template),
            // card 用来做容器裁切内容
            child: Card(
              margin: EdgeInsets.zero,
              elevation: 0,
              // 角标，用来显示操作按钮
              child: Badge(
                // 角标内容 点击进入模板编辑页
                badgeContent: IconButton(
                  icon: Icon(Icons.adaptive.more),
                  padding: EdgeInsets.zero,
                  splashRadius: inUseTemplate.elevatedButtonBorderRadius.value ?? inUseTemplate.defaultRadius.value ?? 12,
                  onPressed: () => showTemplateGridItemOption(context, template, isInUse),
                  tooltip: "显示操作项",
                ),
                animationDuration: Duration.zero,
                // z轴高度0
                elevation: 0,
                // 角标颜色：透明
                badgeColor: Colors.transparent,
                // 不要内边距
                padding: EdgeInsets.zero,
                // 角标位置，右下角
                position: BadgePosition.bottomEnd(),
                child: Column(
                  children: [
                    Expanded(child: Container(color: flexSchemeColor.primary)),
                    Expanded(child: Container(color: flexSchemeColor.primaryContainer)),
                    Expanded(child: Container(color: flexSchemeColor.secondary)),
                    Expanded(child: Container(color: flexSchemeColor.secondaryContainer)),
                    Expanded(child: Container(color: flexSchemeColor.tertiary)),
                    Expanded(child: Container(color: flexSchemeColor.tertiaryContainer)),
                  ],
                ),
              ),
            ),
          ),
        ),
        // 方案名称
        Expanded(
          flex: 0,
          child: SizedBox(
            height: 20,
            child: Text(
              templateName ?? "未命名",
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                color: templateName == null ? Theme.of(context).disabledColor : null,
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// 显示表格项目的可操作项
  void showTemplateGridItemOption(BuildContext context, ThemeTemplate template, bool isInUse) async {
    List<ThemeTemplateOption> optionList = [ThemeTemplateOption.edit];
    if (!isInUse) {
      optionList.insert(0, ThemeTemplateOption.use);
      optionList.add(ThemeTemplateOption.remove);
    }
    ThemeTemplateOption? result = await ToastHelper.showRequest<ThemeTemplateOption>(
      context,
      valueList: optionList,
      childBuilder: (option) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [option.icon, Text(option.title)],
        );
      },
      defaultValue: [ThemeTemplateOption.use],
      destructiveValue: [ThemeTemplateOption.remove],
    );
    if (null == result) return;
    switch (result) {
      case ThemeTemplateOption.use:
        logic.useTemplate(template);
        break;
      case ThemeTemplateOption.edit:
        toTemplateView(template);
        break;
      case ThemeTemplateOption.remove:
        logic.removeTemplate(template);
        break;
    }
  }

  /// 打开主题设置页面
  void toTemplateView(ThemeTemplate template) {
    RouteHelper.to(
      page: ThemeTemplateView(
        key: template.id.value,
        args: ThemeTemplateViewArgs(),
        dataSource: ThemeTemplateViewDataSource(template),
      ),
    );
  }
}
