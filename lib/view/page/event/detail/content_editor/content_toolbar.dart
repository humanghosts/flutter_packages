import 'dart:math';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:hg_logger/ability/export.dart';
import 'package:hg_logger/main.dart';
import 'package:hg_logger/view/export.dart';
import 'package:zefyr/zefyr.dart';

import 'content_editor.dart';

/// 工具栏按钮枚举
class ToolBarItem {
  final String name;
  final NotusAttributeBuilder? attribute;
  final IconData? iconData;
  final String? textData;
  final String? message;
  final Widget Function(String key, ContentEditorLogic logic) build;

  const ToolBarItem._({
    required this.name,
    this.attribute,
    this.iconData,
    this.textData,
    this.message,
    required this.build,
  });

  static ToolBarItem bold = ToolBarItem._(
    name: "bold",
    attribute: NotusAttribute.bold,
    iconData: Icons.format_bold,
    message: "粗体",
    build: (key, logic) => ToolbarItemButton(args: ToolbarItemButtonArgs(bold, logic, key)),
  );
  static ToolBarItem italic = ToolBarItem._(
    name: "italic",
    attribute: NotusAttribute.italic,
    iconData: Icons.format_italic,
    message: "斜体",
    build: (key, logic) => ToolbarItemButton(args: ToolbarItemButtonArgs(italic, logic, key)),
  );
  static ToolBarItem underline = ToolBarItem._(
    name: "underline",
    attribute: NotusAttribute.underline,
    iconData: Icons.format_underline,
    message: "下划线",
    build: (key, logic) => ToolbarItemButton(args: ToolbarItemButtonArgs(underline, logic, key)),
  );
  static ToolBarItem strikethrough = ToolBarItem._(
    name: "strikethrough",
    attribute: NotusAttribute.strikethrough,
    iconData: Icons.format_strikethrough,
    message: "删除线",
    build: (key, logic) => ToolbarItemButton(args: ToolbarItemButtonArgs(strikethrough, logic, key)),
  );

  static ToolBarItem inlineCode = ToolBarItem._(
    name: "inlineCode",
    attribute: NotusAttribute.inlineCode,
    iconData: Icons.code,
    message: "行内代码",
    build: (key, logic) => ToolbarItemButton(args: ToolbarItemButtonArgs(inlineCode, logic, key)),
  );

  static ToolBarItem alignLeft = ToolBarItem._(
    name: "alignLeft",
    attribute: NotusAttribute.left,
    iconData: Icons.format_align_left,
    message: "左对齐",
    build: (key, logic) => ToolbarItemButton(args: ToolbarItemButtonArgs(alignLeft, logic, key)),
  );

  static ToolBarItem alignCenter = ToolBarItem._(
    name: "alignCenter",
    attribute: NotusAttribute.center,
    iconData: Icons.format_align_center,
    message: "居中对齐",
    build: (key, logic) => ToolbarItemButton(args: ToolbarItemButtonArgs(alignCenter, logic, key)),
  );

  static ToolBarItem alignRight = ToolBarItem._(
    name: "alignRight",
    attribute: NotusAttribute.right,
    iconData: Icons.format_align_right,
    message: "右对齐",
    build: (key, logic) => ToolbarItemButton(args: ToolbarItemButtonArgs(alignRight, logic, key)),
  );

  static ToolBarItem alignJustify = ToolBarItem._(
    name: "alignJustify",
    attribute: NotusAttribute.justify,
    iconData: Icons.format_align_justify,
    message: "两端对齐",
    build: (key, logic) => ToolbarItemButton(args: ToolbarItemButtonArgs(alignJustify, logic, key)),
  );

  static ToolBarItem headingUnset = ToolBarItem._(
    name: "headingUnset",
    attribute: NotusAttribute.heading.unset,
    message: "普通文本",
    textData: "N",
    build: (key, logic) => ToolbarItemButton(args: ToolbarItemButtonArgs(headingUnset, logic, key)),
  );
  static ToolBarItem headingLevel1 = ToolBarItem._(
    name: "headingLevel1",
    attribute: NotusAttribute.heading.level1,
    message: "一级标题",
    textData: "h1",
    build: (key, logic) => ToolbarItemButton(args: ToolbarItemButtonArgs(headingLevel1, logic, key)),
  );
  static ToolBarItem headingLevel2 = ToolBarItem._(
    name: "headingLevel2",
    attribute: NotusAttribute.heading.level2,
    message: "二级标题",
    textData: "h2",
    build: (key, logic) => ToolbarItemButton(args: ToolbarItemButtonArgs(headingLevel2, logic, key)),
  );
  static ToolBarItem headingLevel3 = ToolBarItem._(
    name: "headingLevel3",
    attribute: NotusAttribute.heading.level3,
    message: "三级标题",
    textData: "h3",
    build: (key, logic) => ToolbarItemButton(args: ToolbarItemButtonArgs(headingLevel3, logic, key)),
  );
  static ToolBarItem numberList = ToolBarItem._(
    name: "numberList",
    attribute: NotusAttribute.block.numberList,
    iconData: Icons.format_list_numbered,
    message: "有序列表",
    build: (key, logic) => ToolbarItemButton(args: ToolbarItemButtonArgs(numberList, logic, key)),
  );
  static ToolBarItem bulletList = ToolBarItem._(
    name: "bulletList",
    attribute: NotusAttribute.block.bulletList,
    iconData: Icons.format_list_bulleted,
    message: "无序列表",
    build: (key, logic) => ToolbarItemButton(args: ToolbarItemButtonArgs(bulletList, logic, key)),
  );
  static ToolBarItem checkList = ToolBarItem._(
    name: "checkList",
    attribute: NotusAttribute.block.checkList,
    iconData: Icons.checklist,
    message: "代办列表",
    build: (key, logic) => ToolbarItemButton(args: ToolbarItemButtonArgs(checkList, logic, key)),
  );

  static ToolBarItem blockCode = ToolBarItem._(
    name: "blockCode",
    attribute: NotusAttribute.block.code,
    iconData: Icons.code,
    message: "代码块",
    build: (key, logic) => ToolbarItemButton(args: ToolbarItemButtonArgs(blockCode, logic, key)),
  );
  static ToolBarItem quote = ToolBarItem._(
    name: "quote",
    attribute: NotusAttribute.block.quote,
    iconData: Icons.format_quote,
    message: "引用",
    build: (key, logic) => ToolbarItemButton(args: ToolbarItemButtonArgs(quote, logic, key)),
  );
  static ToolBarItem embed = ToolBarItem._(
    name: "embed",
    iconData: Icons.horizontal_rule,
    message: "分割线",
    build: (key, logic) {
      return HgNeumorphicButton(
        key: ValueKey("${key}_${embed.name}"),
        getTooltip: () => embed.message ?? "",
        margin: const EdgeInsets.symmetric(horizontal: 2),
        padding: const EdgeInsets.all(4),
        child: HgNeumorphicIcon(Icons.horizontal_rule),
        style: const NeumorphicStyle(disableDepth: true, border: NeumorphicBorder.none()),
        onPressed: () {
          final index = logic.controller.selection.baseOffset;
          final length = logic.controller.selection.extentOffset - index;
          logic.controller.replaceText(index, length, BlockEmbed.horizontalRule);
        },
      );
    },
  );
  static ToolBarItem link = ToolBarItem._(
    name: "link",
    attribute: NotusAttribute.link,
    iconData: Icons.link,
    message: "链接",
    build: (key, logic) => ToolBarItemLinkButton(args: ToolBarItemLinkButtonArgs(link, logic, key)),
  );

  static ToolBarItem fullscreen = ToolBarItem._(
    name: "fullscreen",
    iconData: Icons.fullscreen,
    message: "全屏",
    build: (key, logic) {
      return HgNeumorphicButton(
        key: ValueKey("${key}_${fullscreen.name}"),
        getTooltip: () => fullscreen.message ?? "",
        margin: const EdgeInsets.symmetric(horizontal: 2),
        padding: const EdgeInsets.all(4),
        child: HgNeumorphicIcon(fullscreen.iconData!),
        style: const NeumorphicStyle(disableDepth: true, border: NeumorphicBorder.none()),
        onPressed: logic.fullscreen,
      );
    },
  );

  static ToolBarItem divide = ToolBarItem._(
    name: "divide",
    build: (key, logic) {
      NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
      return VerticalDivider(indent: 16, endIndent: 16, color: themeData.disabledColor);
    },
  );

  static List<ToolBarItem> list = [
    bold,
    italic,
    underline,
    strikethrough,
    inlineCode,
    divide,
    alignLeft,
    alignCenter,
    alignRight,
    alignJustify,
    divide,
    headingUnset,
    headingLevel1,
    headingLevel2,
    headingLevel3,
    divide,
    numberList,
    bulletList,
    checkList,
    divide,
    blockCode,
    quote,
    divide,
    link,
    embed,
    divide,
    fullscreen,
  ];
}

@immutable
class ToolbarItemButtonArgs extends ViewArgs {
  final ToolBarItem toolBarItem;
  final ContentEditorLogic logic;
  final String key;

  const ToolbarItemButtonArgs(this.toolBarItem, this.logic, this.key);
}

class ToolbarItemButtonLogic extends ViewLogicOnlyArgs<ToolbarItemButtonArgs> {
  bool isPressed = false;

  /// 打开回调
  @override
  void afterArgsUpdate() {
    args.logic.controller.removeListener(checkToggleStyle);
    args.logic.controller.addListener(checkToggleStyle);
  }

  /// 是否是当前样式
  NotusStyle get _selectionStyle => args.logic.controller.getSelectionStyle();

  /// 检查是否是当前样式
  void checkToggleStyle() {
    NotusAttribute attribute = (args.toolBarItem.attribute as NotusAttribute);
    if (attribute.isUnset) {
      isPressed = !_selectionStyle.contains(attribute);
    } else {
      isPressed = _selectionStyle.containsSame(attribute);
    }
    update();
  }

  /// 切换按钮状态
  void toggle() {
    isPressed = !isPressed;
    if (isPressed) {
      args.logic.controller.formatSelection(args.toolBarItem.attribute as NotusAttribute);
    } else {
      args.logic.controller.formatSelection(args.toolBarItem.attribute!.unset);
    }
    update();
  }
}

class ToolbarItemButton extends View<ToolbarItemButtonLogic> {
  ToolbarItemButton({required ToolbarItemButtonArgs args}) : super(key: args.toolBarItem.name, args: args, newLogic: ToolbarItemButtonLogic());

  @override
  Widget buildView(BuildContext context) {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    Widget child;
    if (null != logic.args.toolBarItem.iconData) {
      child = HgNeumorphicIcon(logic.args.toolBarItem.iconData!);
    } else {
      child = NeumorphicText(
        logic.args.toolBarItem.textData!,
        style: NeumorphicStyle(
          color: themeData.defaultTextColor,
          depth: min(1, themeData.depth),
        ),
        textStyle: NeumorphicTextStyle(
          fontWeight: FontWeight.w500,
        ),
      );
    }
    return HgNeumorphicButton(
      getTooltip: () => logic.args.toolBarItem.message ?? "",
      margin: const EdgeInsets.symmetric(horizontal: 2),
      child: child,
      padding: const EdgeInsets.all(4),
      pressed: logic.isPressed,
      style: NeumorphicStyle(
        depth: logic.isPressed ? -themeData.depth : 0,
        border: logic.isPressed ? const NeumorphicBorder() : const NeumorphicBorder.none(),
      ),
      onPressed: logic.toggle,
    );
  }
}

class ToolBarItemLinkButtonArgs extends ViewArgs {
  final ToolBarItem toolBarItem;
  final ContentEditorLogic logic;
  final String key;

  const ToolBarItemLinkButtonArgs(this.toolBarItem, this.logic, this.key);
}

class ToolBarItemLinkButtonLogic extends ViewLogicOnlyArgs<ToolBarItemLinkButtonArgs> {
  /// 打开回调
  @override
  void afterArgsUpdate() {
    args.logic.controller.removeListener(listener);
    args.logic.controller.addListener(listener);
  }

  /// 更新
  void listener() {
    update();
  }
}

class ToolBarItemLinkButton extends View<ToolBarItemLinkButtonLogic> {
  ToolBarItemLinkButton({required ToolBarItemLinkButtonArgs args})
      : super(
          key: "${args.key}_${args.toolBarItem.name}",
          args: args,
          newLogic: ToolBarItemLinkButtonLogic(),
        );

  @override
  Widget buildView(BuildContext context) {
    bool isEnabled = !logic.args.logic.controller.selection.isCollapsed;
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return HgNeumorphicButton(
      child: HgNeumorphicIcon(logic.args.toolBarItem.iconData ?? Icons.link, color: isEnabled ? null : themeData.disabledColor),
      getTooltip: () => logic.args.toolBarItem.message ?? "",
      margin: const EdgeInsets.symmetric(horizontal: 2),
      padding: const EdgeInsets.all(4),
      style: const NeumorphicStyle(depth: 0),
      onPressed: toLinkDialog,
    );
  }

  void toLinkDialog() async {
    bool isEnabled = !logic.args.logic.controller.selection.isCollapsed;
    if (!isEnabled) return;
    String? value = await Get.dialog(
      Material(
        child: Center(
          child: Container(
            height: 80,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            clipBehavior: Clip.none,
            child: Neumorphic(
              padding: const EdgeInsets.all(8),
              child: TextField(
                controller: TextEditingController(text: "https://"),
                decoration: const InputDecoration(
                  labelText: '链接',
                  labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                toolbarOptions: const ToolbarOptions(copy: true, cut: true, paste: true, selectAll: true),
                autofocus: true,
                onSubmitted: (value) => RouteHelper.back(result: value),
              ),
            ),
          ),
        ),
      ),
    );

    if (value == null || value.isEmpty) return;
    if (value == "https://") return;
    logic.args.logic.controller.formatSelection(NotusAttribute.link.fromString(value));
  }
}
