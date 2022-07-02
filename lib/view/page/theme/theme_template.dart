import 'dart:ui';

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:hg_framework/hg_framework.dart';
import 'package:hg_framework/view/page/page.dart' as hg;

import 'panel/android_bar.dart';
import 'panel/app_bar.dart';
import 'panel/banner_snack.dart';
import 'panel/bottom_nav_bar.dart';
import 'panel/buttons.dart';
import 'panel/card.dart';
import 'panel/dialogs.dart';
import 'panel/effective_colors.dart';
import 'panel/fab_toggle_chip_popup.dart';
import 'panel/global_settings.dart';
import 'panel/list_tile.dart';
import 'panel/nav_bar.dart';
import 'panel/nav_rail.dart';
import 'panel/seed_colors.dart';
import 'panel/showcase.dart';
import 'panel/surface_blends.dart';
import 'panel/switches.dart';
import 'panel/tab_bar.dart' as tab_bar_panel;
import 'panel/text_field.dart';
import 'panel/text_theme.dart';

/// 面板类型
enum TemplatePanelType {
  globalSettings,
  seededColorScheme,
  surfaceBlends,
  effectiveColors,
  textField,
  appBar,
  tabBar,
  bottomNavigationBar,
  navigationBar,
  navigationRail,
  androidBar,
  materialButtons,
  fabToggleChipPopup,
  switchCheckRadio,
  listTile,
  dialogs,
  materialBannerSnack,
  card,
  textTheme,
  widgetShowcase,
}

extension TemplatePanelTypeExtension on TemplatePanelType {
  String get title {
    switch (this) {
      case TemplatePanelType.globalSettings:
        return "全局设置";
      case TemplatePanelType.seededColorScheme:
        return "配色生成";
      case TemplatePanelType.surfaceBlends:
        return "混合配色";
      case TemplatePanelType.effectiveColors:
        return "配色预览";
      case TemplatePanelType.textField:
        return "文本输入";
      case TemplatePanelType.appBar:
        return "应用栏";
      case TemplatePanelType.tabBar:
        return "标签页栏";
      case TemplatePanelType.bottomNavigationBar:
        return "底部导航栏";
      case TemplatePanelType.navigationBar:
        return "导航栏";
      case TemplatePanelType.navigationRail:
        return "侧面导航栏";
      case TemplatePanelType.androidBar:
        return "安卓导航栏";
      case TemplatePanelType.materialButtons:
        return "按钮";
      case TemplatePanelType.fabToggleChipPopup:
        return "标签菜单";
      case TemplatePanelType.switchCheckRadio:
        return "开关选择";
      case TemplatePanelType.listTile:
        return "列表项";
      case TemplatePanelType.dialogs:
        return "对话框";
      case TemplatePanelType.materialBannerSnack:
        return "提示横幅";
      case TemplatePanelType.card:
        return "卡片";
      case TemplatePanelType.textTheme:
        return "文本";
      case TemplatePanelType.widgetShowcase:
        return "主题预览";
    }
  }

  Icon get icon {
    switch (this) {
      case TemplatePanelType.globalSettings:
        return const Icon(Icons.language_outlined);
      case TemplatePanelType.seededColorScheme:
        return const Icon(Icons.colorize_outlined);
      case TemplatePanelType.surfaceBlends:
        return const Icon(Icons.invert_colors_outlined);
      case TemplatePanelType.effectiveColors:
        return const Icon(Icons.gradient_outlined);
      case TemplatePanelType.textField:
        return const Icon(Icons.pin_outlined);
      case TemplatePanelType.appBar:
        return const Icon(Icons.web_asset_outlined);
      case TemplatePanelType.tabBar:
        return const Icon(Icons.tab_outlined);
      case TemplatePanelType.bottomNavigationBar:
        return const Icon(Icons.video_label);
      case TemplatePanelType.navigationBar:
        return const Icon(Icons.call_to_action);
      case TemplatePanelType.navigationRail:
        return const Icon(Icons.view_sidebar_outlined);
      case TemplatePanelType.androidBar:
        return const Icon(Icons.android_outlined);
      case TemplatePanelType.materialButtons:
        return const Icon(Icons.crop_16_9_outlined);
      case TemplatePanelType.fabToggleChipPopup:
        return const Icon(Icons.menu_open);
      case TemplatePanelType.switchCheckRadio:
        return const Icon(Icons.toggle_on_outlined);
      case TemplatePanelType.listTile:
        return const Icon(Icons.dns_outlined);
      case TemplatePanelType.dialogs:
        return const Icon(Icons.branding_watermark_outlined);
      case TemplatePanelType.materialBannerSnack:
        return const Icon(Icons.call_to_action_outlined);
      case TemplatePanelType.card:
        return const Icon(Icons.picture_in_picture_alt_outlined);
      case TemplatePanelType.textTheme:
        return const Icon(Icons.font_download_outlined);
      case TemplatePanelType.widgetShowcase:
        return const Icon(Icons.flutter_dash_outlined);
    }
  }

  static List<TemplatePanelType> valueList = [
    TemplatePanelType.globalSettings,
    TemplatePanelType.seededColorScheme,
    TemplatePanelType.surfaceBlends,
    TemplatePanelType.effectiveColors,
    TemplatePanelType.textField,
    TemplatePanelType.appBar,
    TemplatePanelType.tabBar,
    TemplatePanelType.bottomNavigationBar,
    TemplatePanelType.navigationBar,
    TemplatePanelType.navigationRail,
    TemplatePanelType.materialButtons,
    TemplatePanelType.fabToggleChipPopup,
    TemplatePanelType.switchCheckRadio,
    TemplatePanelType.listTile,
    TemplatePanelType.dialogs,
    TemplatePanelType.materialBannerSnack,
    TemplatePanelType.card,
    TemplatePanelType.textTheme,
    TemplatePanelType.widgetShowcase,
  ];
  static List<TemplatePanelType> androidValueList = [
    TemplatePanelType.globalSettings,
    TemplatePanelType.seededColorScheme,
    TemplatePanelType.surfaceBlends,
    TemplatePanelType.effectiveColors,
    TemplatePanelType.textField,
    TemplatePanelType.appBar,
    TemplatePanelType.tabBar,
    TemplatePanelType.bottomNavigationBar,
    TemplatePanelType.navigationBar,
    TemplatePanelType.navigationRail,
    TemplatePanelType.androidBar,
    TemplatePanelType.materialButtons,
    TemplatePanelType.fabToggleChipPopup,
    TemplatePanelType.switchCheckRadio,
    TemplatePanelType.listTile,
    TemplatePanelType.dialogs,
    TemplatePanelType.materialBannerSnack,
    TemplatePanelType.card,
    TemplatePanelType.textTheme,
    TemplatePanelType.widgetShowcase,
  ];
}

/// 外部参数
@immutable
class ThemeTemplateViewArgs extends PageArgs {}

/// 外部数据
@immutable
class ThemeTemplateViewDataSource extends PageDataSource {
  final ThemeTemplate template;

  const ThemeTemplateViewDataSource(this.template);
}

/// 逻辑
class ThemeTemplateViewLogic extends PageLogic<ThemeTemplateViewArgs, ThemeTemplateViewDataSource> {
  late final PageController panelPageController = PageController();
  late final ScrollController panelScrollController = ScrollController();
  late final List<TemplatePanelType> panelTypeList;
  late final TextEditingController nameController = TextEditingController();

  final double btnHeight = 70;
  final double btnHPadding = 4;
  final double btnVPadding = 12;

  ThemeTemplate get template => dataSource.template;

  /// 正在选中的panel
  Rx<TemplatePanelType> inUsePanel = TemplatePanelType.globalSettings.obs;

  @override
  void onInit() {
    super.onInit();
    if (DeviceInfoHelper.platform == TargetPlatform.android) {
      panelTypeList = TemplatePanelTypeExtension.androidValueList;
    } else {
      panelTypeList = TemplatePanelTypeExtension.valueList;
    }
  }

  /// todo 保存返回
  void saveBack() {}

  /// 获取主题
  ThemeData get lightThemeData => dataSource.template.toFlexColorThemeLight().toTheme;

  ThemeData get darkThemeData => dataSource.template.toFlexColorThemeDark().toTheme;

  /// 修改模板名称
  void changeTemplateName(String? name) {
    dataSource.template.name.value = name;
  }

  /// 点击按钮 修改面板类型
  void changePanelType(TemplatePanelType type) {
    if (type == inUsePanel.value) return;
    int currentIndex = panelTypeList.indexOf(inUsePanel.value);
    inUsePanel.value = type;
    int index = panelTypeList.indexOf(type);
    _panelButtonJump(index);
    if ((currentIndex - index).abs() > 1) {
      panelPageController.jumpToPage(index);
    } else {
      panelPageController.animateToPage(
        index,
        duration: AppLogic.appConfig.animationConfig.fastAnimationDuration,
        curve: Curves.linear,
      );
    }
  }

  /// 滑动页面修改
  void onPanelPageChanged(int index) {
    TemplatePanelType type = panelTypeList[index];
    inUsePanel.value = type;
    _panelButtonJump(index);
  }

  /// panel按钮自动滑动
  void _panelButtonJump(int index) {
    int length = panelTypeList.length;
    double maxSize = length * (8 + btnHeight);
    double realOffset = maxSize - (8 + btnHeight) * index > Get.width ? (8 + btnHeight) * index : maxSize - Get.width;
    panelScrollController.animateTo(
      realOffset,
      duration: AppLogic.appConfig.animationConfig.fastAnimationDuration,
      curve: Curves.linear,
    );
  }

  /// 修改当前主题模式
  void changeThemeMode(ThemeMode themeMode) {
    if (dataSource.template.themeMode.value.mode == themeMode) return;
    dataSource.template.themeMode.value.mode = themeMode;
    update();
  }

  bool get isDarkMode {
    ThemeMode themeMode = dataSource.template.themeMode.value.mode;
    switch (themeMode) {
      case ThemeMode.system:
        return AppLogic.instance.isDarkMode;
      case ThemeMode.light:
        return false;
      case ThemeMode.dark:
        return true;
    }
  }
}

/// 主题模板页面
class ThemeTemplateView extends hg.Page<ThemeTemplateViewLogic> {
  ThemeTemplateView({
    required String key,
    required ThemeTemplateViewArgs args,
    required ThemeTemplateViewDataSource dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, logic: ThemeTemplateViewLogic());

  @override
  Widget buildView(BuildContext context) {
    String? name = logic.dataSource.template.name.value;
    logic.nameController.text = name ?? "未命名";
    ThemeData themeData = logic.isDarkMode ? logic.darkThemeData : logic.lightThemeData;
    // app_bar的text_style 代码来自AppBar
    final Color foregroundColor = themeData.appBarTheme.foregroundColor ?? themeData.colorScheme.surface;
    TextStyle? titleTextStyle = themeData.appBarTheme.titleTextStyle ?? themeData.textTheme.titleLarge?.copyWith(color: foregroundColor);
    return Theme(
      data: themeData,
      child: AnnotatedRegion(
        value: FlexColorScheme.themedSystemNavigationBar(
          context,
          systemNavBarStyle: logic.dataSource.template.sysNavBarStyle.value.style,
          useDivider: logic.dataSource.template.useSysNavDivider.value,
          opacity: logic.dataSource.template.sysNavBarOpacity.value,
        ),
        child: Scaffold(
          appBar: AppBar(
            leading: const BackButton(),
            actions: [
              IconButton(
                onPressed: logic.saveBack,
                icon: const Icon(Icons.done),
                tooltip: "保存并返回",
              ),
            ],
            title: TextField(
              controller: logic.nameController,
              onChanged: logic.changeTemplateName,
              style: titleTextStyle,
              decoration: InputDecoration(
                hintText: name == null ? "未命名" : null,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                filled: false,
              ),
              cursorColor: titleTextStyle?.color,
            ),
            centerTitle: false,
          ),
          extendBody: true,
          extendBodyBehindAppBar: true,
          body: buildTemplateBody(context),
        ),
      ),
    );
  }

  /// 构建页面
  Widget buildTemplateBody(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool value) {
        return <Widget>[
          SliverPersistentHeader(
            pinned: false,
            floating: true,
            delegate: PanelSelectorHeaderDelegate(
              vsync: SimpleTickerProvider(),
              extent: kToolbarHeight + Get.mediaQuery.padding.top + logic.btnHeight + logic.btnVPadding * 2,
              builder: (context, shrinkOffset, overlapsContent) => Container(
                child: buildPanelRow(
                  context,
                  shrinkOffset,
                  overlapsContent,
                ),
              ),
            ),
          ),
          SliverPadding(padding: EdgeInsets.only(top: logic.btnVPadding)),
          SliverToBoxAdapter(
            child: buildThemeMode(),
          ),
        ];
      },
      body: buildPanelPageView(context),
    );
  }

  /// 面板选择行
  Widget buildPanelRow(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final ThemeData theme = Theme.of(context);
    return Container(
      height: logic.btnHeight + logic.btnVPadding * 2 + kToolbarHeight + Get.mediaQuery.padding.top,
      decoration: BoxDecoration(color: theme.colorScheme.primary.withAlpha(0x38)),
      clipBehavior: Clip.hardEdge,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Obx(() {
          TemplatePanelType inUseType = logic.inUsePanel.value;
          return Container(
            margin: EdgeInsets.only(top: kToolbarHeight + Get.mediaQuery.padding.top),
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: logic.btnHPadding, vertical: logic.btnVPadding),
              controller: logic.panelScrollController,
              scrollDirection: Axis.horizontal,
              itemCount: logic.panelTypeList.length,
              itemBuilder: (context, index) {
                TemplatePanelType type = logic.panelTypeList[index];
                return Container(
                  margin: const EdgeInsets.all(4),
                  width: logic.btnHeight,
                  child: buildPanelButton(context, type, inUseType == type),
                );
              },
            ),
          );
        }),
      ),
    );
  }

  /// 面板按钮
  Widget buildPanelButton(BuildContext context, TemplatePanelType type, bool isInUse) {
    final ThemeData theme = Theme.of(context);
    ThemeTemplate template = logic.dataSource.template;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(6),
        primary: theme.backgroundColor,
        shape: RoundedRectangleBorder(
          side: isInUse ? BorderSide(width: 2, color: theme.primaryColor) : BorderSide.none,
          borderRadius: BorderRadius.circular(template.elevatedButtonBorderRadius.value ?? template.defaultRadius.value ?? 12),
        ),
      ),
      onPressed: () => logic.changePanelType(type),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(type.icon.icon, color: theme.primaryColor, size: 26),
          Text(
            type.title,
            style: theme.textTheme.labelSmall?.copyWith(
              fontSize: 10,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// 主题模式
  Widget buildThemeMode() {
    return Container(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: HeaderCard(
        key: "theme_mode",
        title: const Text('主题模式'),
        child: ListTile(
          title: Text(logic.template.themeMode.value.mode.title),
          trailing: ThemeModeSwitch(
            themeMode: logic.template.themeMode.value.mode,
            onChanged: logic.changeThemeMode,
          ),
          onTap: () {
            ThemeMode themeMode = logic.template.themeMode.value.mode;
            int index = themeMode.index;
            int nextIndex = (index + 1) % ThemeMode.values.length;
            logic.changeThemeMode(ThemeMode.values[nextIndex]);
          },
        ),
      ),
    );
  }

  /// TODO 构建面板页面
  Widget buildPanelPageView(BuildContext context) {
    Map<TemplatePanelType, Widget Function(BuildContext context)> panelPageBuilder = {
      TemplatePanelType.globalSettings: buildGlobalSettingsPanel,
      TemplatePanelType.seededColorScheme: buildSeededColorSchemePanel,
      TemplatePanelType.surfaceBlends: buildSurfaceBlendsPanel,
      TemplatePanelType.effectiveColors: buildEffectiveColorsPanel,
      TemplatePanelType.textField: buildTextFieldSettingsPanel,
      TemplatePanelType.appBar: buildAppBarSettingsPanel,
      TemplatePanelType.tabBar: buildTabBarSettingsPanel,
      TemplatePanelType.bottomNavigationBar: buildBottomNavigationBarSettingsPanel,
      TemplatePanelType.navigationBar: buildNavigationBarSettingsPanel,
      TemplatePanelType.navigationRail: buildNavigationRailSettingsPanel,
      TemplatePanelType.androidBar: buildAndroidNavigationBarSettingsPanel,
      TemplatePanelType.materialButtons: buildButtonsSettingsPanel,
      TemplatePanelType.fabToggleChipPopup: buildFabToggleChipPopupSettingsPanel,
      TemplatePanelType.switchCheckRadio: buildSwitchesSettingsPanel,
      TemplatePanelType.listTile: buildListTileSettingsPanel,
      TemplatePanelType.dialogs: buildDialogSettingsPanel,
      TemplatePanelType.materialBannerSnack: buildMaterialSnackBarSettingsPanel,
      TemplatePanelType.card: buildCardSettingsPanel,
      TemplatePanelType.textTheme: buildTextThemeSettingsPanel,
      TemplatePanelType.widgetShowcase: buildWidgetShowcasePanel,
    };
    return PageView.builder(
      controller: logic.panelPageController,
      itemCount: logic.panelTypeList.length,
      itemBuilder: (context, index) {
        TemplatePanelType type = logic.panelTypeList[index];

        final ThemeData theme = Theme.of(context);
        final bool isLight = theme.brightness == Brightness.light;
        final Color iconColor = isLight
            ? Color.alphaBlend(theme.colorScheme.primary.withAlpha(0x99), theme.colorScheme.onBackground)
            : Color.alphaBlend(theme.colorScheme.primary.withAlpha(0x7F), theme.colorScheme.onBackground);

        return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
          return ListView(
            padding: EdgeInsets.only(left: 12, right: 12, bottom: Get.height * 0.4, top: 12),
            children: <Widget>[
              HeaderCard(
                key: "panel_page",
                title: Text(type.title),
                leading: Icon(type.icon.icon, color: iconColor),
                child: panelPageBuilder[type]?.call(context) ?? Center(child: Text(type.title)),
              ),
            ],
          );
        });
      },
      onPageChanged: (index) => logic.onPanelPageChanged(index),
    );
  }

  Widget buildGlobalSettingsPanel(BuildContext context) {
    return GlobalSettingsView(
      key: "global_settings",
      args: GlobalSettingsArgs(
        onTemplateChange: () => logic.update(),
      ),
      dataSource: GlobalSettingsDataSource(logic.dataSource.template),
    );
  }

  Widget buildSeededColorSchemePanel(BuildContext context) {
    return SeededColorsView(
      key: "seeded_colors",
      args: SeededColorsArgs(
        onTemplateChange: () => logic.update(),
      ),
      dataSource: SeededColorsDataSource(logic.dataSource.template),
    );
  }

  Widget buildSurfaceBlendsPanel(BuildContext context) {
    return SurfaceBlendsView(
      key: "surface_blends",
      args: SurfaceBlendsArgs(
        onTemplateChange: logic.update,
      ),
      dataSource: SurfaceBlendsDataSource(logic.dataSource.template),
    );
  }

  Widget buildEffectiveColorsPanel(BuildContext context) {
    return EffectiveColorsView(
      key: "effective_colors",
      args: EffectiveColorsArgs(
        onTemplateChange: logic.update,
      ),
      dataSource: EffectiveColorsDataSource(logic.dataSource.template),
    );
  }

  Widget buildTextFieldSettingsPanel(BuildContext context) {
    return TextFieldView(
      key: "text_field",
      args: TextFieldArgs(
        onTemplateChange: logic.update,
      ),
      dataSource: TextFieldDataSource(logic.dataSource.template),
    );
  }

  Widget buildAppBarSettingsPanel(BuildContext context) {
    return AppBarView(
      key: "app_bar",
      args: AppBarArgs(
        onTemplateChange: logic.update,
      ),
      dataSource: AppBarDataSource(logic.dataSource.template),
    );
  }

  Widget buildTabBarSettingsPanel(BuildContext context) {
    return tab_bar_panel.TabBarView(
      key: "tab_bar",
      args: tab_bar_panel.TabBarArgs(
        onTemplateChange: logic.update,
      ),
      dataSource: tab_bar_panel.TabBarDataSource(logic.dataSource.template),
    );
  }

  Widget buildBottomNavigationBarSettingsPanel(BuildContext context) {
    return BottomNavBarView(
      key: "bottom_nav_bar",
      args: BottomNavBarArgs(
        onTemplateChange: logic.update,
      ),
      dataSource: BottomNavBarDataSource(logic.dataSource.template),
    );
  }

  Widget buildNavigationBarSettingsPanel(BuildContext context) {
    return NavBarView(
      key: "nav_bar",
      args: NavBarArgs(
        onTemplateChange: logic.update,
      ),
      dataSource: NavBarDataSource(logic.dataSource.template),
    );
  }

  Widget buildNavigationRailSettingsPanel(BuildContext context) {
    return NavRailView(
      key: "nav_rail",
      args: NavRailArgs(
        onTemplateChange: logic.update,
      ),
      dataSource: NavRailDataSource(logic.dataSource.template),
    );
  }

  Widget buildAndroidNavigationBarSettingsPanel(BuildContext context) {
    return AndroidBarView(
      key: "android_bar",
      args: AndroidBarArgs(
        onTemplateChange: logic.update,
      ),
      dataSource: AndroidBarDataSource(logic.dataSource.template),
    );
  }

  Widget buildButtonsSettingsPanel(BuildContext context) {
    return ButtonsView(
      key: "buttons",
      args: ButtonsArgs(
        onTemplateChange: logic.update,
      ),
      dataSource: ButtonsDataSource(logic.dataSource.template),
    );
  }

  Widget buildFabToggleChipPopupSettingsPanel(BuildContext context) {
    return FabToggleChipPopupView(
      key: "fab_toggle_chip_popup",
      args: FabToggleChipPopupArgs(
        onTemplateChange: logic.update,
      ),
      dataSource: FabToggleChipPopupDataSource(logic.dataSource.template),
    );
  }

  Widget buildSwitchesSettingsPanel(BuildContext context) {
    return SwitchesView(
      key: "switches",
      args: SwitchesArgs(
        onTemplateChange: logic.update,
      ),
      dataSource: SwitchesDataSource(logic.dataSource.template),
    );
  }

  Widget buildListTileSettingsPanel(BuildContext context) {
    return ListTileView(
      key: "list_tile",
      args: ListTileArgs(
        onTemplateChange: logic.update,
      ),
      dataSource: ListTileDataSource(logic.dataSource.template),
    );
  }

  Widget buildDialogSettingsPanel(BuildContext context) {
    return DialogsView(
      key: "dialogs",
      args: DialogsArgs(
        onTemplateChange: logic.update,
      ),
      dataSource: DialogsDataSource(logic.dataSource.template),
    );
  }

  Widget buildMaterialSnackBarSettingsPanel(BuildContext context) {
    return BannerSnackView(
      key: "banner_snack",
      args: BannerSnackArgs(
        onTemplateChange: logic.update,
      ),
      dataSource: BannerSnackDataSource(logic.dataSource.template),
    );
  }

  Widget buildCardSettingsPanel(BuildContext context) {
    return CardView(
      key: "card",
      args: CardArgs(
        onTemplateChange: logic.update,
      ),
      dataSource: CardDataSource(logic.dataSource.template),
    );
  }

  Widget buildTextThemeSettingsPanel(BuildContext context) {
    return TextThemeView(
      key: "text_theme",
      args: TextThemeArgs(
        onTemplateChange: logic.update,
      ),
      dataSource: TextThemeDataSource(logic.dataSource.template),
    );
  }

  Widget buildWidgetShowcasePanel(BuildContext context) {
    return ShowcaseView(
      key: "effective_colors",
      args: ShowcaseArgs(
        onTemplateChange: logic.update,
      ),
      dataSource: ShowcaseDataSource(logic.dataSource.template),
    );
  }
}

class PanelSelectorHeaderDelegate extends SliverPersistentHeaderDelegate {
  PanelSelectorHeaderDelegate({
    required this.extent,
    required this.builder,
    required this.vsync,
  });

  @override
  final TickerProvider vsync;
  final double extent;
  final Widget Function(BuildContext context, double shrinkOffset, bool overlapsContent) builder;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return builder(context, shrinkOffset, overlapsContent);
  }

  @override
  double get maxExtent => extent;

  @override
  double get minExtent => extent;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return oldDelegate.maxExtent != maxExtent || oldDelegate.minExtent != minExtent;
  }

  @override
  FloatingHeaderSnapConfiguration? get snapConfiguration => FloatingHeaderSnapConfiguration();
}
