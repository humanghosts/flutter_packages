import 'package:flutter/gestures.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hg_logger/main.dart';

import 'button.dart';
import 'icon.dart';

class HgNeumorphicScaffold extends StatelessWidget {
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final Widget? body;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;
  final List<Widget>? persistentFooterButtons;
  final PreferredSizeWidget? appBar;
  final Color? drawerScrimColor;
  final Color? backgroundColor;
  final Widget? bottomNavigationBar;
  final Widget? bottomSheet;
  final bool? resizeToAvoidBottomInset;
  final bool primary;
  final DragStartBehavior drawerDragStartBehavior;
  final double? drawerEdgeDragWidth;
  final bool drawerEnableOpenDragGesture;
  final bool endDrawerEnableOpenDragGesture;
  final String? restorationId;
  final Widget? leading;
  final Widget? trailing;
  final Widget? title;
  final VoidCallback? onSettings;
  final VoidCallback? onAdd;
  final EdgeInsets? bodyPadding;
  final Widget? leftFabButton;
  final Widget? rightFabButton;
  final NeumorphicThemeData? themeData;
  final GlobalKey? settingsButtonKey;
  final GlobalKey? addButtonKey;

  const HgNeumorphicScaffold({
    Key? key,
    this.body,
    this.leading,
    this.trailing,
    this.title,
    this.onSettings,
    this.onAdd,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.persistentFooterButtons,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.backgroundColor,
    this.resizeToAvoidBottomInset,
    this.primary = true,
    this.drawerDragStartBehavior = DragStartBehavior.start,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.drawerScrimColor,
    this.drawerEdgeDragWidth,
    this.drawerEnableOpenDragGesture = true,
    this.endDrawerEnableOpenDragGesture = true,
    this.restorationId,
    this.bodyPadding = const EdgeInsets.all(12),
    this.leftFabButton,
    this.rightFabButton,
    this.themeData,
    this.settingsButtonKey,
    this.addButtonKey,
    this.appBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        body: buildBody(),
        appBar: appBar,
        floatingActionButton: floatingActionButton ?? buildFab(),
        floatingActionButtonLocation: floatingActionButtonLocation ?? FloatingActionButtonLocation.centerFloat,
        floatingActionButtonAnimator: floatingActionButtonAnimator,
        persistentFooterButtons: persistentFooterButtons,
        bottomNavigationBar: bottomNavigationBar,
        bottomSheet: bottomSheet,
        backgroundColor: backgroundColor,
        primary: primary,
        drawerDragStartBehavior: drawerDragStartBehavior,
        extendBody: extendBody,
        extendBodyBehindAppBar: extendBodyBehindAppBar,
        drawerScrimColor: drawerScrimColor,
        drawerEdgeDragWidth: drawerEdgeDragWidth,
        drawerEnableOpenDragGesture: drawerEnableOpenDragGesture,
        endDrawerEnableOpenDragGesture: endDrawerEnableOpenDragGesture,
        restorationId: restorationId,
      ),
    );
  }

  Widget? buildBody() {
    if (null == leading && null == trailing && null == title) return body;
    if (null == body) return null;
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          // 按钮栏
          Expanded(
            flex: 0,
            child: Container(
              clipBehavior: Clip.none,
              padding: const EdgeInsets.only(top: 8, bottom: 4),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  title ?? Container(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [leading ?? Container(), trailing ?? Container()],
                  ),
                ],
              ),
            ),
          ),
          // 内容列表
          Expanded(
            child: Container(clipBehavior: Clip.antiAlias, decoration: const BoxDecoration(), padding: bodyPadding, child: body),
          ),
        ],
      ),
    );
  }

  Widget? buildFab() {
    List<Widget> children = [];
    if (leftFabButton != null) {
      children.add(leftFabButton!);
    } else {
      if (null != onSettings) children.add(buildSettingButton());
    }
    if (rightFabButton != null) {
      children.add(rightFabButton!);
    } else {
      if (null != onAdd) children.add(buildAddButton());
    }
    if (children.isEmpty) return null;
    MainAxisAlignment mainAxisAlignment;
    if (children.length == 2) {
      mainAxisAlignment = MainAxisAlignment.spaceBetween;
    } else {
      mainAxisAlignment = null == onSettings ? MainAxisAlignment.end : MainAxisAlignment.start;
    }
    return Row(mainAxisAlignment: mainAxisAlignment, children: children);
  }

  Widget buildSettingButton() {
    NeumorphicThemeData themeData = this.themeData ?? MainLogic.instance.neumorphicThemeData;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: HgNeumorphicButton(
        key: settingsButtonKey,
        padding: const EdgeInsets.all(16),
        child: HgNeumorphicIcon(Icons.settings, color: themeData.disabledColor),
        onPressed: onSettings,
        getTooltip: () => "设置",
      ),
    );
  }

  Widget buildAddButton() {
    NeumorphicThemeData themeData = this.themeData ?? MainLogic.instance.neumorphicThemeData;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: HgNeumorphicButton(
        key: addButtonKey,
        padding: const EdgeInsets.all(16),
        child: HgNeumorphicIcon(Icons.add, color: themeData.accentColor),
        onPressed: onAdd,
        getTooltip: () => "新增",
      ),
    );
  }
}
