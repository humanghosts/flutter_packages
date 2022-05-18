import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:hg_logger/ability/export.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/main.dart';
import 'package:hg_logger/view/export.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../enum/icons/icon.dart';
import '../../../enum/icons/iconpark.dart';
import '../../../enum/icons/ionicons.dart';
import '../../../enum/icons/material_icon.dart';
import 'expansion.dart';

/// 图标编辑参数
@immutable
class LogoPickerArgs extends ViewArgs {
  /// 退出页面回调
  final VoidCallback? onBack;

  /// 子导航id
  final int navigatorId;

  const LogoPickerArgs({
    this.onBack,
    required this.navigatorId,
  });
}

/// 图标数据
@immutable
class LogoPickerDataSource extends ViewDataSource {
  /// 图标
  final IconValue iconValue;

  const LogoPickerDataSource({required this.iconValue});
}

/// 图标编辑逻辑
class LogoPickerLogic extends ViewLogic<LogoPickerArgs, LogoPickerDataSource> {
  /// 背景色
  Rx<int> bgColor = 0.obs;

  /// 图标色
  Rx<int> iconColor = 0.obs;

  /// 图标名称
  Rx<int> iconUpdateFlag = 0.obs;

  /// 返回
  void back() {
    RouteHelper.back(id: args.navigatorId);
  }

  /// 打开回调
  @override
  void afterArgsUpdate() {
    bgColor.value = dataSource.iconValue.backgroundColor;
    iconColor.value = dataSource.iconValue.iconColor;
    iconUpdateFlag.value = 0;
  }

  /// 页面返回回调
  void onBack() {
    args.onBack?.call();
  }

  /// 更改标签颜色
  void changeIconColor(Color color) {
    dataSource.iconValue.iconColor = color.value;
    iconColor.value = color.value;
  }

  /// 更改背景颜色
  void changeBgColor(Color color) {
    dataSource.iconValue.backgroundColor = color.value;
    bgColor.value = color.value;
  }

  /// 更改图标
  void changeFontIcon(IconData iconData) {
    dataSource.iconValue.iconData = FontIcon.fromIconData(iconData);
    iconUpdateFlag.value++;
  }

  void changeSvgIcon(String path) {
    dataSource.iconValue.iconData = SvgIcon(path);
    iconUpdateFlag.value++;
  }
}

/// 页面
class LogoPicker extends View<LogoPickerLogic> with ObserverWidget {
  LogoPicker({
    required String key,
    required LogoPickerArgs args,
    required LogoPickerDataSource dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, newLogic: LogoPickerLogic());

  @override
  void observe(ObserverRouting? routing) {
    if (routing?.isBack == true) {
      logic.onBack();
    }
  }

  @override
  Widget buildView(BuildContext context) {
    return HgNeumorphicScaffold(
      resizeToAvoidBottomInset: true,
      leading: HgNeumorphicBackButton(onPressed: logic.back),
      title: HgNeumorphicText("图标编辑"),
      body: ListView(
        clipBehavior: Clip.none,
        padding: EdgeInsets.only(bottom: Get.height * 0.5),
        children: [
          buildLogo(),
          const Padding(padding: EdgeInsets.only(bottom: 16)),
          buildColorPicker("图标颜色", logic.iconColor, logic.changeIconColor),
          const Padding(padding: EdgeInsets.only(bottom: 16)),
          buildColorPicker("背景颜色", logic.bgColor, logic.changeBgColor),
          const Padding(padding: EdgeInsets.only(bottom: 16)),
          buildIonIcons(),
          const Padding(padding: EdgeInsets.only(bottom: 16)),
          buildIconPark(),
          const Padding(padding: EdgeInsets.only(bottom: 16)),
          buildMaterialIcon(),
        ],
      ),
    );
  }

  /// 图标预览
  Widget buildLogo() {
    return Neumorphic(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("图标预览", style: TextStyle(fontWeight: FontWeight.bold)),
          Center(child: Neumorphic(
            child: Obx(() {
              int iconUpdateFlag = logic.iconUpdateFlag.value;
              int iconColorUpdateFlag = logic.iconColor.value;
              int bgColorUpdateFlag = logic.bgColor.value;
              debugPrint("图标更新:$iconUpdateFlag:$iconColorUpdateFlag:$bgColorUpdateFlag");
              return Logo(iconValue: logic.dataSource.iconValue, size: 70);
            }),
          )),
        ],
      ),
    );
  }

  /// 颜色选择
  Widget buildColorPicker(String title, Rx<int> color, ValueChanged<Color> onColorChanged) {
    return NeumorphicFormField(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      child: Expansion(
        key: "${title.hashCode}",
        args: ExpansionArgs(
          title: Neumorphic(child: Obx(() {
            int colorUpdateFlag = color.value;
            debugPrint("$title颜色修改:$colorUpdateFlag");
            return Container(height: 30, color: Color(color.value));
          })),
          body: ColorPicker(
            key: "${logic.args.navigatorId}$title",
            args: ColorPickerArgs(
              navigatorId: logic.args.navigatorId,
              initColor: Color(color.value),
              onColorChanged: onColorChanged,
            ),
          ),
        ),
      ),
    );
  }

  /// 打开链接
  void launchUrl(String? url) async {
    HapticFeedback.lightImpact();
    if (null == url) return;
    final result = await canLaunch(url);
    if (result) await launch(url);
  }

  /// ionIcons
  Widget buildIonIcons() {
    return Obx(() {
      int iconUpdateFlag = logic.iconUpdateFlag.value;
      debugPrint("图标更新:$iconUpdateFlag");
      return IconSelector<SvgIconEnum>(
        key: logic.key + "ionicons",
        args: IconSelectorArgs(
          text: Row(
            children: [
              Logo(
                iconValue: IconValue.svg(path: IonIcons.logoIonic.path, backgroundColor: Colors.transparent),
                size: 30,
              ),
              const Text("ionicons图标选择", style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          commentWidget: Center(
            child: GestureDetector(
              child: Text(
                "来自于ionic的开源图标,共${IonIcons.iconMap.length}个"
                "\n图标搜索只支持英文搜索"
                "\n点击以上文字可打开图标源网站",
                overflow: TextOverflow.visible,
                style: const TextStyle(decoration: TextDecoration.underline),
              ),
              onTap: () => launchUrl("https://ionic.io/ionicons"),
            ),
          ),
          onIconSelected: (name) {
            IonIcons icon = IonIcons.iconMap[name]!;
            logic.changeSvgIcon(icon.path);
          },
        ),
        dataSource: IconSelectorDataSource(iconMap: IonIcons.iconMap, iconValue: logic.dataSource.iconValue),
      );
    });
  }

  Widget buildIconPark() {
    return Obx(() {
      int iconUpdateFlag = logic.iconUpdateFlag.value;
      debugPrint("图标更新:$iconUpdateFlag");
      return IconSelector<SvgIconEnum>(
        key: logic.key + "iconpark",
        args: IconSelectorArgs(
          text: Row(
            children: [
              Logo(
                iconValue: IconValue.svg(path: IconPark.bytedance.path, backgroundColor: Colors.transparent),
                size: 30,
              ),
              const Text("iconpark图标选择", style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          commentWidget: Center(
            child: GestureDetector(
              child: Text(
                "来自于iconpark的开源图标，共${IconPark.iconMap.length}个"
                "\n图标搜索支持中英文搜索"
                "\niconpark的图标文件中没有iconpark的品牌图标，此处用字节跳动的品牌图标代替"
                "\n点击以上文字可打开图标源网站",
                overflow: TextOverflow.visible,
                style: const TextStyle(decoration: TextDecoration.underline),
              ),
              onTap: () => launchUrl("https://iconpark.oceanengine.com/official"),
            ),
          ),
          onIconSelected: (name) {
            IconPark icon = IconPark.iconMap[name]!;
            logic.changeSvgIcon(icon.path);
          },
        ),
        dataSource: IconSelectorDataSource(iconMap: IconPark.iconMap, iconValue: logic.dataSource.iconValue),
      );
    });
  }

  Widget buildMaterialIcon() {
    return Obx(() {
      int iconUpdateFlag = logic.iconUpdateFlag.value;
      debugPrint("图标更新:$iconUpdateFlag");
      return IconSelector<FontIconEnum>(
        key: logic.key + "materialIcon",
        args: IconSelectorArgs(
          text: Row(
            children: [
              Logo(
                iconValue: IconValue.svg(path: IonIcons.logoGoogle.path, backgroundColor: Colors.transparent),
                size: 30,
              ),
              const Text("Material图标选择", style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          commentWidget: Center(
            child: GestureDetector(
              child: Text(
                "来自于Flutter自带的Material图标，共${MaterialIcon.iconMap.length}个"
                "\n图标搜索只支持英文搜索"
                "\n点击以上文字可打开图标源网站(网站已被屏蔽)",
                overflow: TextOverflow.visible,
                style: const TextStyle(decoration: TextDecoration.underline),
              ),
              onTap: () => launchUrl("https://material.io/resources/icons"),
            ),
          ),
          onIconSelected: (name) {
            MaterialIcon icon = MaterialIcon.iconMap[name]!;
            logic.changeFontIcon(icon.iconData);
          },
        ),
        dataSource: IconSelectorDataSource(iconMap: MaterialIcon.iconMap, iconValue: logic.dataSource.iconValue),
      );
    });
  }
}

/// 外部参数
@immutable
class IconSelectorArgs extends ViewArgs {
  final Widget text;
  final Widget? commentWidget;
  final ValueChanged<String>? onIconSelected;

  const IconSelectorArgs({
    required this.text,
    this.commentWidget,
    this.onIconSelected,
  });
}

/// 外部数据
@immutable
class IconSelectorDataSource<T extends IconEnum> extends ViewDataSource {
  final Map<String, T> iconMap;
  final IconValue iconValue;

  const IconSelectorDataSource({required this.iconMap, required this.iconValue});
}

/// 逻辑
class IconSelectorLogic<T extends IconEnum> extends ViewLogic<IconSelectorArgs, IconSelectorDataSource<T>> {
  /// 显示图标的名称
  List<String> showFileName = [];

  /// 搜索文字
  String searchText = "";

  /// 搜索框控制器
  final TextEditingController searchController = TextEditingController();

  /// 搜索框焦点
  FocusNode focusNode = FocusNode();

  /// 列表更新标识
  Rx<int> listUpdateFlag = 0.obs;

  @override
  void afterArgsUpdate() {
    super.afterArgsUpdate();
    if (searchText.isEmpty) {
      showFileName = dataSource.iconMap.keys.toList();
    }
  }

  /// 搜索
  Future<void> search(String text) async {
    if (searchText.isEmpty) {
      showFileName = dataSource.iconMap.keys.toList();
    } else {
      showFileName = dataSource.iconMap.keys.where((value) {
        return value.contains(text);
      }).toList();
    }
    listUpdateFlag.value++;
  }
}

/// 页面
class IconSelector<T extends IconEnum> extends View<IconSelectorLogic<T>> {
  IconSelector({
    required String key,
    required IconSelectorArgs args,
    required IconSelectorDataSource<T> dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, newLogic: IconSelectorLogic<T>());

  @override
  Widget buildView(BuildContext context) {
    return NeumorphicFormField(
      title: Row(
        children: [
          logic.args.text,
          const Padding(padding: EdgeInsets.only(left: 12)),
          SizedBox(width: 150, child: buildSearch()),
        ],
      ),
      commentWidget: logic.args.commentWidget,
      child: SizedBox(
        height: Get.width * 0.618,
        child: buildIconGrid(),
      ),
    );
  }

  Widget buildSearch() {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return Neumorphic(
      style: NeumorphicStyle(depth: -themeData.depth),
      child: CupertinoSearchTextField(
        controller: logic.searchController,
        placeholder: "搜索图标",
        focusNode: logic.focusNode,
        backgroundColor: themeData.baseColor,
        prefixIcon: HgNeumorphicIcon(Icons.search),
        prefixInsets: const EdgeInsets.only(left: 4),
        suffixMode: OverlayVisibilityMode.never,
        onChanged: (value) => logic.searchText = value,
        onSubmitted: logic.search,
        style: TextStyle(color: themeData.defaultTextColor),
      ),
    );
  }

  Widget buildIconGrid() {
    return Obx(() {
      debugPrint("搜索更新次数${logic.listUpdateFlag.value}");
      return GridView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: logic.showFileName.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (BuildContext context, int index) {
          if (T == SvgIconEnum) {
            return buildSvgIcon(context, index);
          }
          if (T == FontIconEnum) {
            return buildFontIcon(context, index);
          }
          return Container();
        },
      );
    });
  }

  Widget buildSvgIcon(BuildContext context, int index) {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    // 文件名称
    String fileName = logic.showFileName[index];
    SvgIconEnum file = logic.dataSource.iconMap[fileName] as SvgIconEnum;
    bool isSelect = false;
    IconValue iconValue = logic.dataSource.iconValue;
    if (iconValue.iconType == SvgIcon) isSelect = file.path == (iconValue.iconData as SvgIcon).path;
    return HgNeumorphicButton(
      key: ValueKey(file.path),
      padding: EdgeInsets.zero,
      getTooltip: () => fileName,
      margin: const EdgeInsets.all(8),
      onPressed: () => logic.args.onIconSelected?.call(file.name),
      style: NeumorphicStyle(
        depth: isSelect ? -themeData.depth : themeData.depth,
        border: NeumorphicBorder(width: isSelect ? themeData.borderWidth : 0, color: themeData.accentColor),
      ),
      child: Logo(
        size: Get.width * 0.618 / 4,
        iconValue: IconValue.svg(
          path: file.path,
          // iconColor: Color(logic.dataSource.iconValue.iconColor),
          // backgroundColor: Color(logic.dataSource.iconValue.backgroundColor),
        ),
      ),
    );
  }

  Widget buildFontIcon(BuildContext context, int index) {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    // 文件名称
    String iconName = logic.showFileName[index];
    FontIconEnum icon = logic.dataSource.iconMap[iconName] as FontIconEnum;
    bool isSelect = false;
    IconValue iconValue = logic.dataSource.iconValue;
    if (iconValue.iconType == FontIcon) isSelect = (iconValue.iconData as FontIcon).toIconData() == icon.iconData;
    return HgNeumorphicButton(
      key: ValueKey("${icon.fontFamily}_${icon.name}"),
      padding: EdgeInsets.zero,
      getTooltip: () => iconName,
      margin: const EdgeInsets.all(8),
      onPressed: () => logic.args.onIconSelected?.call(icon.name),
      style: NeumorphicStyle(
        depth: isSelect ? -themeData.depth : themeData.depth,
        border: NeumorphicBorder(width: isSelect ? themeData.borderWidth : 0, color: themeData.accentColor),
      ),
      child: Logo(
        size: Get.width * 0.618 / 4,
        iconValue: IconValue.fontIcon(iconData: icon.iconData),
      ),
    );
  }
}
