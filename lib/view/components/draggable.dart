import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hg_framework/hg_framework.dart';

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

  /// 是否将拖拽位置限制在父组件内
  final bool isLimitInParent;

  /// 拖拽模式
  final DraggableMode mode;

  const DraggableArgs({
    required this.child,
    this.initPosition,
    this.builder,
    this.isLimitInParent = true,
    this.mode = DraggableMode.tap,
  });
}

/// 逻辑
class DraggableLogic extends ViewLogicOnlyArgs<DraggableArgs> {
  /// 子组件起始位置
  Offset? childOffset;

  /// 子组件大小
  Size? childSize;
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
    left.value = args.initPosition?.left;
    top.value = args.initPosition?.top;
    right.value = args.initPosition?.right;
    bottom.value = args.initPosition?.bottom;
  }

  /// 计算边距
  void calculate(bool force) {
    bool cal = isCalculate(force);
    if (!cal) return;
    double hor = childOffset!.dx - parentOffset!.dx;
    double ver = childOffset!.dy - parentOffset!.dy;
    if (args.isLimitInParent) {
      hor = math.min(parentSize!.width - childSize!.width, math.max(0, hor));
      ver = math.min(parentSize!.height - childSize!.height, math.max(0, ver));
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
      if (value == null) return false;
    }
    if (force) return true;
    bool childrenSizeChanged = !isSizeEquals(oldChildSize, childSize);
    if (childrenSizeChanged) {
      print("childSizeChanged:$oldChildSize->$childSize");
      return true;
    }

    bool parentSizeChanged = !isSizeEquals(oldParentSize, parentSize);
    bool isLimitInParent = args.isLimitInParent;
    if (parentSizeChanged) {
      print("parentSizeChanged:$oldParentSize->$parentSize");
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
    // 子组件
    Widget child = Container(
      key: childKey,
      child: logic.args.child,
    );
    // 初始化组件数据
    initWidgetData(parentKey, childKey);
    return Container(
      key: parentKey,
      child: DragTarget(
        builder: (context, candidateItems, rejectedItems) {
          return Obx(() {
            return Stack(
              children: [
                Positioned(
                  left: logic.left.value,
                  top: logic.top.value,
                  right: logic.right.value,
                  bottom: logic.bottom.value,
                  child: buildChild(context, childKey, child),
                )
              ],
            );
          });
        },
      ),
    );
  }

  // 构建可拖拽的子组件
  Widget buildChild(BuildContext context, GlobalKey childKey, Widget child) {
    DraggableMode mode = logic.args.mode;
    if (logic.args.builder != null) {
      return logic.args.builder!(context, child, (details) {
        onDragUpdate(details, childKey);
      });
    }
    Widget draggable;
    switch (mode) {
      case DraggableMode.tap:
        draggable = Draggable(
          feedback: child,
          childWhenDragging: Container(),
          onDragUpdate: (details) => onDragUpdate(details, childKey),
          child: child,
        );
        break;
      case DraggableMode.longPress:
        draggable = LongPressDraggable(
          feedback: child,
          childWhenDragging: Container(),
          onDragUpdate: (details) => onDragUpdate(details, childKey),
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
        logic.oldParentSize = logic.parentSize;
        logic.parentSize = parentRenderBox.size;
      }
      final RenderBox? childRenderBox = childKey.currentContext?.findRenderObject() as RenderBox?;
      if (null != childRenderBox) {
        logic.oldChildSize = logic.childSize;
        logic.childSize = childRenderBox.size;
      }
      logic.calculate(false);
    });
  }

  /// 拖拽更新
  void onDragUpdate(DragUpdateDetails details, GlobalKey childKey) {
    final RenderBox childRenderBox = childKey.currentContext!.findRenderObject()! as RenderBox;
    Offset global = childRenderBox.localToGlobal(Offset.zero);
    logic.childOffset = global;
    logic.calculate(true);
  }
}
