import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:hg_logger/ability/export.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/main.dart';
import 'package:hg_logger/view/enum/page_states.dart';
import 'package:hg_logger/view/export.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zefyr/zefyr.dart';

import 'content_toolbar.dart';

enum ContentEditorMode { widget, page }

@immutable
class ContentEditorArgs extends ViewArgs {
  /// 焦点
  final FocusNode focusNode;

  /// 页面状态
  final PageState state;

  /// 导航id
  final int navigatorId;

  /// 编辑器模式
  final ContentEditorMode mode;

  const ContentEditorArgs({
    required this.focusNode,
    required this.state,
    required this.navigatorId,
    this.mode = ContentEditorMode.widget,
  });
}

@immutable
class ContentEditorDataSource extends ViewDataSource {
  final Event event;

  const ContentEditorDataSource({required this.event});
}

/// 内容编辑逻辑
class ContentEditorLogic extends TutorialViewLogic<ContentEditorArgs, ContentEditorDataSource> {
  /// 编辑器控制器
  late ZefyrController controller;

  /// 内容
  NotusDocument document = NotusDocument();

  /// 打开回调
  @override
  void afterArgsUpdate() {
    Content content = dataSource.event.content.value;
    if (content.isNull) {
      content.document = NotusDocument();
    }
    controller = ZefyrController(content.document!);
  }

  /// 打开链接
  void launchUrl(String? url) async {
    HapticFeedback.lightImpact();
    if (null == url) return;
    final result = await canLaunch(url);
    if (result) await launch(url);
  }

  /// 全屏
  void fullscreen() {
    (widget as ContentEditor).fullscreen();
  }

  @override
  void buildTutorial() {
    buildAndAddTargetFocus(
      "editor",
      contents: [
        TargetContent(
          align: ContentAlign.top,
          builder: (context, controller) => HgNeumorphicText("事件内容编辑器"),
        ),
      ],
    );
    buildAndAddTargetFocus(
      "editor_toolbar",
      contents: [
        TargetContent(
          align: ContentAlign.top,
          builder: (context, controller) => HgNeumorphicText("事件内容编辑工具栏，可左右滑动查看更多功能，"
              "\n长按按钮可以查看按钮功能呢"
              "\n注：大部分按钮可以长按查看内容或者获取提示"),
        ),
      ],
    );
  }

  @override
  String? get tutorialSubKey => "detail_content_editor";

  @override
  HomePages get homePage => HomePages.event;
}

/// 内容编辑器
class ContentEditor extends View<ContentEditorLogic> {
  ContentEditor({
    required String key,
    required ContentEditorArgs args,
    required ContentEditorDataSource dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, newLogic: ContentEditorLogic());

  @override
  Widget buildView(BuildContext context) {
    return Column(children: [buildEditor(), buildToolBar()]);
  }

  Widget buildEditor() {
    return Expanded(
      key: logic.addTutorialTargetKey(0, "editor"),
      child: ZefyrEditor(
        key: ValueKey(logic.key),
        readOnly: logic.args.state == PageState.browse,
        expands: true,
        scrollable: true,
        // enableSuggestions: true,
        autofocus: false,
        controller: logic.controller,
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        focusNode: logic.args.focusNode,
        onLaunchUrl: logic.launchUrl,
        textCapitalization: TextCapitalization.none,
        keyboardAppearance: Get.isDarkMode ? Brightness.dark : Brightness.light,
        linkActionPickerDelegate: linkActionPickerDelegate,
      ),
    );
  }

  /// 超链接操作
  Future<LinkMenuAction> linkActionPickerDelegate(BuildContext context, String link) async {
    logic.args.focusNode.requestFocus();
    HapticFeedback.lightImpact();
    logic.args.focusNode.unfocus();
    final result = await showCupertinoModalPopup<LinkMenuAction>(
      context: Get.context!,
      builder: (ctx) {
        return CupertinoActionSheet(
          title: Text(link, style: const TextStyle(fontWeight: FontWeight.bold)),
          actions: [
            CupertinoActionSheetAction(
              onPressed: () => RouteHelper.back(result: LinkMenuAction.launch),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: const [Expanded(child: Text('打开', textAlign: TextAlign.start)), Icon(Icons.language)],
                ),
              ),
            ),
            CupertinoActionSheetAction(
              onPressed: () => RouteHelper.back(result: LinkMenuAction.copy),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: const [Expanded(child: Text('复制', textAlign: TextAlign.start)), Icon(Icons.copy)],
                ),
              ),
            ),
            CupertinoActionSheetAction(
              onPressed: () => RouteHelper.back(result: LinkMenuAction.remove),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: const [Expanded(child: Text('删除', textAlign: TextAlign.start)), Icon(Icons.link_off)],
                ),
              ),
            ),
          ],
        );
      },
    );
    return result ?? LinkMenuAction.none;
  }

  /// 操作栏
  Widget buildToolBar() {
    // 浏览状态不显示操作栏
    if (logic.args.state == PageState.browse) return Container();
    List<Widget> toolBarItem = [];
    for (ToolBarItem item in ToolBarItem.list) {
      if (item == ToolBarItem.fullscreen && logic.args.mode == ContentEditorMode.page) continue;
      toolBarItem.add(item.build(logic.args.mode.toString(), logic));
    }
    ZefyrToolbar zToolbar = ZefyrToolbar(key: ValueKey(logic.key), children: toolBarItem);
    return Container(
      key: logic.addTutorialTargetKey(1, "editor_toolbar"),
      child: zToolbar,
    );
  }

  /// 全屏编辑
  void fullscreen() {
    logic.args.focusNode.unfocus();
    RouteHelper.to(
      id: logic.args.navigatorId,
      page: _ContentEditorPage(logic: logic),
    );
  }
}

class _ContentEditorPage extends StatelessWidget with ObserverWidget {
  final ContentEditorLogic logic;
  final FocusNode pageFocusNode = FocusNode();

  _ContentEditorPage({Key? key, required this.logic}) : super(key: key);

  @override
  void observe(ObserverRouting? routing) {
    if (routing?.isBack == true) {
      pageFocusNode.unfocus();
      Content content = logic.dataSource.event.content.value;
      if (content.isNull) {
        content.document = NotusDocument();
      }
      logic.controller = ZefyrController(content.document!);
      logic.update();
    }
  }

  @override
  Widget build(BuildContext context) {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return HgNeumorphicScaffold(
      leading: HgNeumorphicBackButton(onPressed: () => RouteHelper.back(id: logic.args.navigatorId)),
      title: HgNeumorphicText("事件内容编辑"),
      body: Neumorphic(
        style: NeumorphicStyle(depth: -themeData.depth),
        child: ContentEditor(
          key: logic.key + "_page",
          args: ContentEditorArgs(focusNode: pageFocusNode, state: logic.args.state, navigatorId: logic.args.navigatorId, mode: ContentEditorMode.page),
          dataSource: ContentEditorDataSource(event: logic.dataSource.event),
        ),
      ),
    );
  }
}
