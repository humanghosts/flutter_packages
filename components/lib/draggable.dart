import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:hgs_framework/framework.dart';

@immutable
class Position {
  final double? left;
  final double? top;
  final double? right;
  final double? bottom;

  const Position({this.left, this.top, this.right, this.bottom});
}

/// 拖拽模式
enum DraggableMode {
  tap,
  longPress,
}

/// 外部参数
@immutable
class DraggableArgs extends ViewArgs {
  /// 子组件
  final Widget child;

  /// 组件构建器
  final Widget Function(BuildContext context, Widget child, void Function(DragUpdateDetails details) onDragUpdate)? builder;

  /// 初始位置
  final Position? initPosition;

  /// 可改变大小的锚点位置
  final Position? resizePosition;

  /// 是否将拖拽位置限制在父组件内
  final bool isLimitInParent;

  /// 拖拽模式
  final DraggableMode mode;

  /// 大小限制
  final BoxConstraints? constraints;

  /// 是否可以调整大小
  final bool resizeable;

  final Size? resizeAreaSize;

  final Widget? resizeIcon;

  const DraggableArgs({
    required this.child,
    this.initPosition,
    this.builder,
    this.isLimitInParent = true,
    this.mode = DraggableMode.tap,
    this.resizePosition,
    this.constraints,
    this.resizeable = false,
    this.resizeAreaSize,
    this.resizeIcon,
  });
}

/// 逻辑
class DraggableLogic extends ViewLogicOnlyArgs<DraggableArgs> {
  /// 子组件起始位置
  Offset? childOffset;

  /// 子组件大小
  Rxn<Size> childSize = Rxn();
  Size? oldChildSize;

  /// 父组件起始位置
  Offset? parentOffset;

  /// 父组件大小
  Size? parentSize;
  Size? oldParentSize;

  /// 与父组件的边距
  final RxnDouble left = RxnDouble();
  final RxnDouble top = RxnDouble();
  final RxnDouble right = RxnDouble();
  final RxnDouble bottom = RxnDouble();

  @override
  void onReady() {
    super.onReady();
    left.value = args.initPosition?.left;
    top.value = args.initPosition?.top;
    right.value = args.initPosition?.right;
    bottom.value = args.initPosition?.bottom;
  }

  /// 重置父组件大小
  void resizeParent(Size size) {
    log("resizeParent:$parentSize->$size");
    oldParentSize = parentSize;
    parentSize = size;
  }

  /// 重置子组件大小
  void resizeChild(Size size) {
    if (childSize.value != null && !args.resizeable) return;
    log("resizeChild:$childSize->$size");
    oldChildSize = childSize.value;
    childSize.value = size;
  }

  /// 计算边距
  void calculate(bool force) {
    bool cal = isCalculate(force);
    if (!cal) return;
    double hor = childOffset!.dx - parentOffset!.dx;
    double ver = childOffset!.dy - parentOffset!.dy;
    if (args.isLimitInParent) {
      hor = math.min(parentSize!.width - childSize.value!.width, math.max(0, hor));
      ver = math.min(parentSize!.height - childSize.value!.height, math.max(0, ver));
    }
    left.value = hor;
    top.value = ver;
    right.value = null;
    bottom.value = null;
  }

  /// 是否计算
  bool isCalculate(bool force) {
    List list = [childOffset, childSize, parentSize, parentOffset];
    for (dynamic value in list) {
      if (value == null) {
        return false;
      }
    }
    if (force) return true;
    bool childrenSizeChanged = !isSizeEquals(oldChildSize, childSize.value);
    if (childrenSizeChanged) {
      log("childSizeChanged:$oldChildSize->$childSize");
      return true;
    }

    bool parentSizeChanged = !isSizeEquals(oldParentSize, parentSize);
    bool isLimitInParent = args.isLimitInParent;
    if (parentSizeChanged) {
      log("parentSizeChanged:$oldParentSize->$parentSize");
    }
    return isLimitInParent && parentSizeChanged;
  }

  bool isSizeEquals(Size? a, Size? b) {
    if (a == null && b == null) return true;
    if (a != null && b != null) return a.width.toStringAsFixed(4) == b.width.toStringAsFixed(4) && a.height.toStringAsFixed(4) == b.height.toStringAsFixed(4);
    return false;
  }
}

/// 页面
class DraggableWidget extends View<DraggableLogic> {
  DraggableWidget({
    required String key,
    required DraggableArgs args,
  }) : super(key: key, args: args, logic: DraggableLogic());

  @override
  Widget buildView(BuildContext context) {
    // 子组件key
    GlobalKey childKey = GlobalKey();
    // 父组件key
    GlobalKey parentKey = GlobalKey();
    Widget resize = Card(
      color: Colors.transparent,
      margin: EdgeInsets.zero,
      child: SizedBox(
        height: logic.args.resizeAreaSize?.height ?? 12,
        width: logic.args.resizeAreaSize?.width ?? 12,
        child: Ink(
          child: InkWell(
            mouseCursor: SystemMouseCursors.resizeUpLeftDownRight,
            onTap: () {},
            onHover: (value) {},
            child: logic.args.resizeIcon,
          ),
        ),
      ),
    );

    // 子组件
    Widget child = !logic.args.resizeable
        ? Container(
            key: childKey,
            child: logic.args.child,
          )
        : Obx(() {
            return AnimatedSize(
              duration: animationConfig.middleAnimationDuration,
              child: Container(
                key: childKey,
                width: logic.childSize.value?.width,
                height: logic.childSize.value?.height,
                constraints: logic.args.constraints,
                child: Stack(
                  children: [
                    logic.args.child,
                    Positioned(
                      bottom: logic.args.resizePosition?.bottom ?? 0,
                      right: logic.args.resizePosition?.right ?? 0,
                      left: logic.args.resizePosition?.left,
                      top: logic.args.resizePosition?.top,
                      child: Draggable(
                        childWhenDragging: const SizedBox.shrink(),
                        feedback: resize,
                        child: resize,
                        onDragUpdate: (details) {
                          final RenderBox? childRenderBox = childKey.currentContext?.findRenderObject() as RenderBox?;
                          if (null == childRenderBox) return;
                          Offset global = childRenderBox.localToGlobal(Offset.zero);
                          Offset pos = details.globalPosition;
                          logic.resizeChild(Size(math.max(10, pos.dx - global.dx), math.max(10, pos.dy - global.dy)));
                        },
                      ),
                    )
                  ],
                ),
              ),
            );
          });
    // 初始化组件数据
    return LayoutBuilder(
      builder: (context, constraints) {
        initWidgetData(parentKey, childKey);
        logic.resizeParent(Size(constraints.maxWidth, constraints.maxHeight));
        return Container(
          key: parentKey,
          constraints: constraints,
          alignment: Alignment.center,
          child: DragTarget(
            key: getChildLocalKey(DragTarget),
            hitTestBehavior: HitTestBehavior.deferToChild,
            builder: (context, candidateItems, rejectedItems) {
              return Obx(() {
                return Stack(
                  children: [
                    Positioned(
                      left: logic.left.value,
                      top: logic.top.value,
                      right: logic.right.value,
                      bottom: logic.bottom.value,
                      child: buildChild(context, parentKey, childKey, child),
                    )
                  ],
                );
              });
            },
          ),
        );
      },
    );
  }

  // 构建可拖拽的子组件
  Widget buildChild(BuildContext context, GlobalKey parentKey, GlobalKey childKey, Widget child) {
    DraggableMode mode = logic.args.mode;
    if (logic.args.builder != null) {
      return logic.args.builder!(context, child, (details) {
        onDragUpdate(details, parentKey, childKey);
      });
    }
    Widget draggable;
    switch (mode) {
      case DraggableMode.tap:
        draggable = Draggable(
          key: getChildLocalKey(Draggable),
          feedback: child,
          childWhenDragging: const SizedBox.shrink(),
          onDragUpdate: (details) => onDragUpdate(details, parentKey, childKey),
          child: child,
        );
        break;
      case DraggableMode.longPress:
        draggable = LongPressDraggable(
          key: getChildLocalKey(LongPressDraggable),
          feedback: child,
          childWhenDragging: const SizedBox.shrink(),
          onDragUpdate: (details) => onDragUpdate(details, parentKey, childKey),
          delay: const Duration(milliseconds: 200),
          child: child,
        );
        break;
    }
    return draggable;
  }

  /// 初始化组件数据
  void initWidgetData(GlobalKey parentKey, GlobalKey childKey) {
    Future.delayed(Duration.zero, () {
      final RenderBox? parentRenderBox = parentKey.currentContext?.findRenderObject() as RenderBox?;
      if (null != parentRenderBox) {
        Offset global = parentRenderBox.localToGlobal(Offset.zero);
        logic.parentOffset = global;
        logic.resizeParent(parentRenderBox.size);
      }
      final RenderBox? childRenderBox = childKey.currentContext?.findRenderObject() as RenderBox?;
      if (null != childRenderBox) {
        logic.resizeChild(childRenderBox.size);
      }
      logic.calculate(false);
    });
  }

  /// 拖拽更新
  void onDragUpdate(DragUpdateDetails details, GlobalKey parentKey, GlobalKey childKey) {
    final RenderBox? parentRenderBox = parentKey.currentContext?.findRenderObject() as RenderBox?;
    if (null != parentRenderBox) {
      Offset global = parentRenderBox.localToGlobal(Offset.zero);
      logic.parentOffset = global;
    }
    final RenderBox childRenderBox = childKey.currentContext!.findRenderObject()! as RenderBox;
    Offset global = childRenderBox.localToGlobal(Offset.zero);
    logic.childOffset = global;
    logic.calculate(true);
  }
}
