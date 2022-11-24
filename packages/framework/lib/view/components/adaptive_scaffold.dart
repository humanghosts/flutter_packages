import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hg_framework/hg_framework.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';
import 'package:styled_widget/styled_widget.dart';

@immutable
class AdaptiveScaffoldArgs extends ViewArgs {
  /// 菜单
  final Widget menu;

  /// 内容
  final Widget body;

  /// 获取控制器
  final void Function(AdaptiveScaffoldLogic controller)? controller;

  /// 最大菜单宽度
  final double menuWidthMaxRadio;

  /// 最小菜单宽度
  final double menuWidthMin;

  /// 当菜单宽度超过最大值
  final VoidCallback? onMenuWidthOverMax;

  /// 当菜单宽度超过最小值
  final VoidCallback? onMenuWidthOverMain;

  const AdaptiveScaffoldArgs({
    required this.menu,
    required this.body,
    this.controller,
    this.menuWidthMaxRadio = 0.5,
    this.menuWidthMin = 304,
    this.onMenuWidthOverMax,
    this.onMenuWidthOverMain,
  });
}

class AdaptiveScaffoldLogic extends ViewLogicOnlyArgs<AdaptiveScaffoldArgs> {
  // ----组件参数----

  /// 组件开始起点x
  RxDouble dx = 0.0.obs;

  /// 组件开始起点y
  RxDouble dy = 0.0.obs;

  /// 最大宽度
  double? _maxWidth;

  /// 最大高度
  double? _maxHeight;

  late BuildContext mobileContext;

  double get maxWidth => _maxWidth ?? Get.width;

  double get maxHeight => _maxHeight ?? Get.height;

  set maxWidth(double value) => _maxWidth = value;

  set maxHeight(double value) => _maxHeight = value;

  // ----菜单参数----

  /// 是否初始化过菜单
  bool hasInitMenu = false;

  /// 菜单宽度
  RxDouble menuWidth = 304.0.obs;

  /// 菜单是否打开
  RxBool isMenuOpen = true.obs;

  @override
  void onReady() {
    super.onReady();
    args.controller?.call(this);
  }

  @override
  void afterArgsUpdate() {
    super.afterArgsUpdate();
  }

  /// 组件大小变化回调
  void afterLayoutChanged(BuildContext context) {
    // 组件位置
    final RenderBox stack = context.findRenderObject()! as RenderBox;
    Offset global = stack.localToGlobal(Offset.zero);
    dx.value = global.dx;
    dy.value = global.dy;
    // 菜单宽度
    double menuWidth = this.menuWidth.value;
    if (!hasInitMenu) menuWidth = maxWidth * 0.25;
    // 超过最大值
    if (menuWidth > maxWidth * args.menuWidthMaxRadio) {
      args.onMenuWidthOverMax?.call();
      menuWidth = maxWidth * args.menuWidthMaxRadio;
    }
    // 超过最小值
    if (menuWidth < args.menuWidthMin) {
      args.onMenuWidthOverMain?.call();
      menuWidth = args.menuWidthMin;
    }
    this.menuWidth.value = menuWidth;
    hasInitMenu = true;
  }

  /// 打开或关闭菜单栏
  void toggleMenu() => isMenuOpen.value ? closeMenu() : openMenu();

  /// 打开菜单
  void openMenu() {
    isMenuOpen.value = true;
    if (DeviceInfoHelper().isMobile) {
      Scaffold.of(mobileContext).openDrawer();
    }
  }

  /// 关闭菜单
  void closeMenu() {
    isMenuOpen.value = false;
    if (DeviceInfoHelper().isMobile) {
      Scaffold.of(mobileContext).closeDrawer();
    }
  }

  /// 菜单宽度变化回调
  void afterMenuWidthChanged(double menuWidth) {
    // 超过最大值
    if (menuWidth > maxWidth * args.menuWidthMaxRadio) {
      args.onMenuWidthOverMax?.call();
      menuWidth = maxWidth * args.menuWidthMaxRadio;
    }
    // 超过最小值
    if (menuWidth < args.menuWidthMin) {
      args.onMenuWidthOverMain?.call();
      menuWidth = args.menuWidthMin;
    }
    this.menuWidth.value = menuWidth;
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
    return LayoutBuilder(builder: (context, constraints) {
      logic.maxWidth = math.min(constraints.maxWidth, Get.width);
      logic.maxHeight = math.min(constraints.maxHeight, Get.height);
      Future.delayed(Duration.zero, () => logic.afterLayoutChanged(context));
      return ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: constraints.minHeight,
          minWidth: constraints.minWidth,
          maxWidth: logic.maxWidth,
          maxHeight: logic.maxHeight,
        ),
        child: Material(
          key: getChildLocalKey(Material),
          color: Colors.transparent,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            body: DeviceInfoHelper().isMobile ? buildMobile(context) : buildDesktop(context),
          ),
        ),
      );
    });
  }

  /// 抽屉式菜单
  Widget buildMobile(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      drawer: SizedBox.expand(child: logic.args.menu),
      onDrawerChanged: (isOpened) {
        logic.isMenuOpen.value = isOpened;
      },
      body: Builder(builder: (context) {
        logic.mobileContext = context;
        if (DeviceInfoHelper().isWeb) {
          return SimpleGestureDetector(
            onHorizontalSwipe: (direction) => doWhen(direction == SwipeDirection.right, logic.openMenu),
            child: logic.args.body,
          );
        }
        return logic.args.body;
      }),
    );
  }

  /// 展开收起模式菜单
  Widget buildDesktop(BuildContext context) {
    return [buildDesktopMenu(context), logic.args.body.expanded()].toRow();
  }

  /// 构建菜单
  Widget buildDesktopMenu(BuildContext context) {
    // 构建切换器
    Widget buildSwitcherWithChild(Widget child) {
      return AnimatedSwitcher(
        key: getChildLocalKey(AnimatedSwitcher, "menu_switcher"),
        duration: logic.fastAnimationDuration,
        transitionBuilder: (Widget child, Animation<double> animation) {
          return SizeTransition(sizeFactor: animation, axis: Axis.horizontal, child: child);
        },
        child: child,
      );
    }

    return Obx(() {
      // 菜单是否打开
      bool isMenuOpen = logic.isMenuOpen.value;
      if (!isMenuOpen) return buildSwitcherWithChild(const SizedBox.shrink());
      return buildSwitcherWithChild(Stack(
        alignment: Alignment.centerRight,
        children: [
          // 菜单
          SizedBox.expand(child: logic.args.menu),
          // 可拖拽的框
          buildDesktopDraggableDivider(context, (detail) {
            Offset offset = detail.globalPosition;
            logic.afterMenuWidthChanged(offset.dx - logic.dx.value);
          }),
        ],
      ).width(logic.menuWidth.value));
    });
  }

  /// 可拖拽分隔符
  Widget buildDesktopDraggableDivider(BuildContext context, void Function(DragUpdateDetails details) onDragUpdate) {
    return MouseRegion(
      cursor: SystemMouseCursors.resizeColumn,
      child: Draggable(
        feedback: const SizedBox.shrink(),
        onDragUpdate: onDragUpdate,
        child: Container(width: 2, color: Colors.transparent),
      ),
    );
  }
}
