import 'dart:math' as math;
import 'dart:ui';

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hg_framework/hg_framework.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';

@immutable
class AdaptiveScaffoldArgs extends ViewArgs {
  /// 菜单
  final Widget menu;

  /// 内容
  final Widget body;

  /// 第二内容
  final Widget? secondBody;

  /// 获取控制器
  final void Function(AdaptiveScaffoldLogic controller)? controller;

  const AdaptiveScaffoldArgs({
    required this.menu,
    required this.body,
    this.secondBody,
    this.controller,
  });
}

class AdaptiveScaffoldLogic extends ViewLogicOnlyArgs<AdaptiveScaffoldArgs> {
  /// 菜单宽度
  RxDouble menuWidth = 304.0.obs;

  /// 第二内容宽度
  Rx<double> secondaryBodyWidth = (-1.0).obs;

  BuildContext? context;

  /// 菜单是否打开
  Rx<bool> isMenuOpen = true.obs;

  /// 第二内容是否打开
  Rx<bool> isSecondaryBodyOpen = true.obs;

  /// 鼠标是否悬停在开关按钮上
  Rx<bool> isHoverMenuButton = false.obs;

  /// 鼠标是否悬停在开关按钮上
  Rx<bool> isHoverSecondaryBodyButton = false.obs;

  /// 是否展开第二内容
  RxBool isExpandSecondaryBody = false.obs;

  /// 第二内容
  Rxn<Widget?> secondaryBody = Rxn(null);

  /// 抽屉菜单控制器
  ScrollController mobileController = ScrollController(initialScrollOffset: 0);

  /// 组件开始起点
  RxDouble dx = 0.0.obs;

  /// 组件开始起点
  RxDouble dy = 0.0.obs;

  /// 最大宽度
  double? _maxWidth;

  /// 最大高度
  double? _maxHeight;

  double get maxWidth => _maxWidth ?? Get.width;

  double get maxHeight => _maxHeight ?? Get.height;

  set maxWidth(double value) => _maxWidth = value;

  set maxHeight(double value) => _maxHeight = value;

  @override
  void afterArgsUpdate() {
    super.afterArgsUpdate();
    secondaryBody.value ??= args.secondBody;
    args.controller?.call(this);
    menuWidth.value = math.max(
      math.min(menuWidth.value, maxWidth / 3),
      maxWidth / 8,
    );
    secondaryBodyWidth.value = math.max(
      math.min(secondaryBodyWidth.value, maxWidth / 2),
      maxWidth / 4,
    );
  }

  /// 打开菜单
  void openMenu() {
    isMenuOpen.value = true;
    if (null != context) Scaffold.of(context!).openDrawer();
  }

  /// 关闭菜单
  void closeMenu() {
    isMenuOpen.value = false;
    if (null != context) Scaffold.of(context!).closeDrawer();
  }

  /// 打开或关闭菜单栏
  void openCloseMenu() {
    bool value = isMenuOpen.value;
    if (value) {
      closeMenu();
    } else {
      openMenu();
    }
  }

  /// 打开第二内容 只有有内容的情况下才能打开
  void openSecondaryBody({Widget? secondaryBody, bool? isExpand = false}) {
    if (null != secondaryBody) {
      this.secondaryBody.value = secondaryBody;
      // 计算窗口初始大小
      if (secondaryBodyWidth.value < 0) {
        bool isMenuOpen = this.isMenuOpen.value;
        if (isMenuOpen) {
          secondaryBodyWidth.value = (maxWidth - menuWidth.value) / 2;
        } else {
          secondaryBodyWidth.value = (maxWidth / 2);
        }
        // 初始长度不超过屏幕一半
        secondaryBodyWidth.value = math.min(secondaryBodyWidth.value, maxWidth / 2);
      }
    }
    if (null != isExpand) {
      isExpandSecondaryBody.value = isExpand;
    }
    if (null != this.secondaryBody.value) {
      isSecondaryBodyOpen.value = true;
      if (DeviceInfoHelper.isMobile) {
        mobileController.animateTo(
          maxWidth,
          duration: AppLogic.appConfig.animationConfig.fastAnimationDuration,
          curve: Curves.linear,
        );
      }
    } else {
      closeSecondaryBody();
    }
  }

  /// 关闭并清空第二内容
  void clearAndCloseSecondaryBody() {
    isSecondaryBodyOpen.value = false;
    secondaryBody.value = null;
  }

  /// 关闭第二内容
  void closeSecondaryBody() {
    isSecondaryBodyOpen.value = false;
    if (DeviceInfoHelper.isMobile) {
      mobileController.animateTo(
        0,
        duration: AppLogic.appConfig.animationConfig.fastAnimationDuration,
        curve: Curves.linear,
      );
    }
  }

  /// 开启或关闭第二内容
  void openCloseSecondaryBody() {
    bool value = isSecondaryBodyOpen.value;
    if (value) {
      closeSecondaryBody();
    } else {
      openSecondaryBody();
    }
  }

  /// 扩展第二内容
  void expandSecondaryBody() {
    if (null == secondaryBody.value) return;
    isExpandSecondaryBody.value = true;
  }

  /// 收缩第二内容
  void collapseSecondaryBody() {
    if (null == secondaryBody.value) return;
    isExpandSecondaryBody.value = false;
  }
}

/// 自适应侧导航 包含侧导航与应用栏
class AdaptiveScaffold extends View<AdaptiveScaffoldLogic> {
  AdaptiveScaffold({
    required String key,
    required AdaptiveScaffoldArgs args,
  }) : super(key: key, args: args, logic: AdaptiveScaffoldLogic());

  @override
  Widget buildView(BuildContext context) {
    ThemeTemplate themeTemplate = AppLogic.instance.themeTemplate;
    return LayoutBuilder(builder: (context, constraints) {
      logic.maxWidth = math.min(constraints.maxWidth, Get.width);
      logic.maxHeight = math.min(constraints.maxHeight, Get.height);
      Future.delayed(Duration.zero, () {
        final RenderBox stack = context.findRenderObject()! as RenderBox;
        Offset global = stack.localToGlobal(Offset.zero);
        logic.dx.value = global.dx;
        logic.dy.value = global.dy;
      });
      return Container(
        constraints: BoxConstraints(
          minHeight: constraints.minHeight,
          minWidth: constraints.minWidth,
          maxWidth: logic.maxWidth,
          maxHeight: logic.maxHeight,
        ),
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          key: const ValueKey("annotated_region"),
          value: FlexColorScheme.themedSystemNavigationBar(
            context,
            systemNavBarStyle: themeTemplate.sysNavBarStyle.value.style,
            useDivider: themeTemplate.useSysNavDivider.value,
            opacity: themeTemplate.sysNavBarOpacity.value,
          ),
          child: Material(
            key: const ValueKey("material"),
            color: Colors.transparent,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: DeviceInfoHelper.isMobile ? buildMobile(context) : Obx(() => buildDesktop(context)),
            ),
          ),
        ),
      );
    });
  }

  /// 抽屉式菜单
  Widget buildMobile(BuildContext context) {
    return Scrollable(
      physics: const PageScrollPhysics(parent: ClampingScrollPhysics()),
      controller: logic.mobileController,
      axisDirection: AxisDirection.right,
      viewportBuilder: (BuildContext context, ViewportOffset position) {
        return Obx(() {
          Widget? secondaryBody = logic.secondaryBody.value;
          bool isSecondaryOpen = logic.isSecondaryBodyOpen.value;
          return Viewport(
            axisDirection: AxisDirection.right,
            offset: position,
            clipBehavior: Clip.hardEdge,
            slivers: <Widget>[
              // 主页页面
              SliverFillViewport(
                viewportFraction: 1,
                padEnds: false,
                delegate: SliverChildBuilderDelegate(
                  (context, index) => Scaffold(
                    drawer: SizedBox(
                      width: logic.maxWidth * 0.8,
                      child: ClipRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: buildMenu(context),
                        ),
                      ),
                    ),
                    body: Builder(builder: (context) {
                      logic.context = context;
                      if (DeviceInfoHelper.isWeb) {
                        return SimpleGestureDetector(
                          onHorizontalSwipe: (direction) {
                            if (direction == SwipeDirection.right) {
                              logic.openMenu();
                            }
                          },
                          child: buildBody(context),
                        );
                      }
                      return buildBody(context);
                    }),
                    backgroundColor: Colors.transparent,
                  ),
                  childCount: 1,
                ),
              ),
              // 第二页面
              if (secondaryBody != null && isSecondaryOpen == true)
                SliverFillViewport(
                  viewportFraction: 1,
                  padEnds: false,
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => buildSecondaryBody(context),
                    childCount: 1,
                  ),
                )
            ],
          );
        });
      },
    );
  }

  /// 构建菜单项
  Widget buildMenu(BuildContext context) {
    // 调用传入参数构建菜单项
    return SizedBox.expand(child: logic.args.menu);
  }

  /// 展开收起模式菜单
  Widget buildDesktop(BuildContext context) {
    bool isExpandSecondary = logic.isExpandSecondaryBody.value;
    Widget? secondary = logic.secondaryBody.value;
    Duration duration = AppLogic.appConfig.animationConfig.middleAnimationDuration;

    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        // 菜单 和内容
        AnimatedSwitcher(
          duration: duration,
          child: isExpandSecondary && null != secondary
              ? buildDesktopSecondaryBody(context)
              : Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // 菜单
                    AnimatedSwitcher(
                      key: const ValueKey("animated_container_menu"),
                      duration: duration,
                      child: buildDesktopMenu(context),
                      transitionBuilder: (Widget child, Animation<double> animation) {
                        return SizeTransition(sizeFactor: animation, axis: Axis.horizontal, child: child);
                      },
                    ),
                    Expanded(
                      child: Container(
                        constraints: BoxConstraints(minWidth: logic.maxWidth / 3),
                        child: buildBody(context),
                      ),
                    ),
                    // 内容
                    AnimatedSwitcher(
                      key: const ValueKey("animated_container_secondary_body"),
                      duration: duration,
                      transitionBuilder: (Widget child, Animation<double> animation) {
                        return SizeTransition(sizeFactor: animation, axis: Axis.horizontal, child: child);
                      },
                      child: buildDesktopSecondaryBody(context),
                    ),
                  ],
                ),
        ),
        // 菜单展开收起按钮
        isExpandSecondary && null != secondary ? const SizedBox.shrink() : buildDesktopMenuOpenButton(context),
        // 第二内容展开收起按钮
        isExpandSecondary && null != secondary ? const SizedBox.shrink() : buildDesktopSecondaryBodyOpenButton(context),
      ],
    );
  }

  /// 构建菜单
  Widget buildDesktopMenu(BuildContext context) {
    bool isExpand = logic.isMenuOpen.value;
    if (!isExpand) return const SizedBox.shrink();
    return Obx(() {
      return MouseRegion(
        onEnter: (event) => logic.isHoverMenuButton.value = true,
        onExit: (event) => logic.isHoverMenuButton.value = false,
        child: SizedBox(
          width: logic.menuWidth.value,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 菜单
              Expanded(child: buildMenu(context)),
              // 可拖拽的框
              buildDesktopDraggableDivider(context, (detail) {
                Offset offset = detail.globalPosition;
                logic.menuWidth.value = math.max(
                  math.min(offset.dx - logic.dx.value, logic.maxWidth / 3),
                  logic.maxWidth / 8,
                );
              }),
            ],
          ),
        ),
      );
    });
  }

  /// 构建第二内容
  Widget buildDesktopSecondaryBody(BuildContext context) {
    bool isSecondaryBodyOpen = logic.isSecondaryBodyOpen.value;
    Widget? secondaryBody = logic.secondaryBody.value;
    if (!isSecondaryBodyOpen || secondaryBody == null) return const SizedBox.shrink(key: ValueKey("secondary_body_close"));
    bool isExpandSecondary = logic.isExpandSecondaryBody.value;

    return SizedBox(
      key: const ValueKey("secondary_body_open"),
      width: isExpandSecondary ? logic.maxWidth : math.min(logic.secondaryBodyWidth.value, logic.maxWidth / 2),
      child: MouseRegion(
        onEnter: (event) => logic.isHoverSecondaryBodyButton.value = true,
        onExit: (event) => logic.isHoverSecondaryBodyButton.value = false,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 可拖拽的框
            buildDesktopDraggableDivider(context, (detail) {
              Offset offset = detail.globalPosition;
              logic.secondaryBodyWidth.value = math.max(
                math.min(logic.maxWidth - (offset.dx - logic.dx.value), logic.maxWidth / 2),
                logic.maxWidth / 4,
              );
            }),
            // 第二内容
            Expanded(child: buildSecondaryBody(context)),
          ],
        ),
      ),
    );
  }

  /// 菜单展开收起按钮
  Widget buildDesktopMenuOpenButton(BuildContext context) {
    return Obx(() {
      bool isExpand = logic.isMenuOpen.value;
      bool isHover = logic.isHoverMenuButton.value;
      double menuWidth = logic.menuWidth.value;
      double opacity;
      if (isExpand) {
        opacity = isHover ? 1 : 0;
      } else {
        opacity = 1;
      }
      return AnimatedPositioned(
        duration: AppLogic.appConfig.animationConfig.middleAnimationDuration,
        left: isExpand ? math.min(menuWidth, logic.maxWidth / 2) : 0,
        child: MouseRegion(
          cursor: MaterialStateMouseCursor.clickable,
          onEnter: (event) => logic.isHoverMenuButton.value = true,
          onExit: (event) => logic.isHoverMenuButton.value = false,
          child: Visibility(
            visible: opacity == 1,
            child: Clickable(
              tooltip: "${isExpand ? "收起" : "展开"}菜单",
              onTap: () => logic.openCloseMenu(),
              child: Icon(isExpand ? Icons.arrow_left_outlined : Icons.arrow_right_outlined, size: 40),
            ),
          ),
        ),
      );
    });
  }

  /// 第二内容展开收起按钮
  Widget buildDesktopSecondaryBodyOpenButton(BuildContext context) {
    return Obx(() {
      bool isOpen = logic.isSecondaryBodyOpen.value;
      bool isHover = logic.isHoverSecondaryBodyButton.value;
      double bodyWidth = logic.secondaryBodyWidth.value;
      double opacity;
      if (isOpen) {
        opacity = isHover ? 1 : 0;
      } else {
        if (logic.secondaryBody.value == null) {
          opacity = 0;
        } else {
          opacity = 1;
        }
      }
      return AnimatedPositioned(
        duration: AppLogic.appConfig.animationConfig.middleAnimationDuration,
        right: isOpen ? math.min(bodyWidth, logic.maxWidth / 2) : 0,
        child: MouseRegion(
          cursor: MaterialStateMouseCursor.clickable,
          onEnter: (event) => logic.isHoverSecondaryBodyButton.value = true,
          onExit: (event) => logic.isHoverSecondaryBodyButton.value = false,
          child: Visibility(
            visible: opacity == 1,
            child: Clickable(
              tooltip: "${isOpen ? "收起" : "展开"}内容",
              onTap: () => logic.openCloseSecondaryBody(),
              child: Icon(!isOpen ? Icons.arrow_left_outlined : Icons.arrow_right_outlined, size: 40),
            ),
          ),
        ),
      );
    });
  }

  /// 可拖拽分隔符
  Widget buildDesktopDraggableDivider(BuildContext context, void Function(DragUpdateDetails details) onDragUpdate) {
    ThemeData theme = AppLogic.instance.themeData;
    return MouseRegion(
      cursor: SystemMouseCursors.resizeColumn,
      child: Draggable(
        feedback: Container(),
        onDragUpdate: onDragUpdate,
        child: Container(width: 2, color: theme.dividerColor),
      ),
    );
  }

  /// 构建内容
  Widget buildBody(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      body: logic.args.body,
    );
  }

  Widget buildSecondaryBody(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      body: logic.secondaryBody.value,
    );
  }
}
