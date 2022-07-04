import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hg_framework/hg_framework.dart';

/// 外部参数
@immutable
class DraggableArgs extends ViewArgs {
  final Widget child;
  final double? initLeft;
  final double? initTop;
  final double? initRight;
  final double? initBottom;
  final bool isLimitInParent;
  final bool isLongPress;

  const DraggableArgs({
    required this.child,
    this.initLeft,
    this.initTop,
    this.initBottom,
    this.initRight,
    this.isLimitInParent = true,
    this.isLongPress = false,
  });
}

/// 逻辑
class DraggableLogic extends ViewLogicOnlyArgs<DraggableArgs> {
  /// 子组件起始位置
  Offset? childOffset;

  /// 子组件大小
  Size? childSize;

  /// 父组件起始位置
  Offset? parentOffset;

  /// 父组件大小
  Size? parentSize;

  /// 与父组件的边距
  final RxnDouble left = RxnDouble();
  final RxnDouble top = RxnDouble();
  final RxnDouble right = RxnDouble();
  final RxnDouble bottom = RxnDouble();

  @override
  void onReady() {
    left.value = args.initLeft;
    top.value = args.initTop;
    right.value = args.initRight;
    bottom.value = args.initBottom;
  }

  /// 计算边距
  void calculate() {
    List list = [childOffset, childSize, parentSize, parentOffset];
    for (dynamic value in list) {
      if (value == null) return;
    }
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
}

/// 页面
class DraggableWidget extends View<DraggableLogic> {
  DraggableWidget({
    required String key,
    required DraggableArgs args,
  }) : super(key: key, args: args, logic: DraggableLogic());

  @override
  Widget buildView(BuildContext context) {
    GlobalKey childKey = GlobalKey();
    GlobalKey parenKey = GlobalKey();
    Widget child = Container(
      key: childKey,
      child: logic.args.child,
    );
    Future.delayed(Duration.zero, () {
      final RenderBox? parentRenderBox = parenKey.currentContext?.findRenderObject() as RenderBox?;
      if (null != parentRenderBox) {
        Offset global = parentRenderBox.localToGlobal(Offset.zero);
        logic.parentOffset = global;
        logic.parentSize = parentRenderBox.size;
      }
      final RenderBox? childRenderBox = childKey.currentContext?.findRenderObject() as RenderBox?;
      if (null != childRenderBox) {
        logic.childSize = childRenderBox.size;
      }
      logic.calculate();
    });
    return Container(
      key: parenKey,
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
                  child: logic.args.isLongPress
                      ? LongPressDraggable(
                          feedback: child,
                          childWhenDragging: Container(),
                          onDragUpdate: (detail) {
                            final RenderBox childRenderBox = childKey.currentContext!.findRenderObject()! as RenderBox;
                            Offset global = childRenderBox.localToGlobal(Offset.zero);
                            logic.childOffset = global;
                            logic.calculate();
                          },
                          delay: const Duration(milliseconds: 200),
                          child: child,
                        )
                      : Draggable(
                          feedback: child,
                          childWhenDragging: Container(),
                          onDragUpdate: (detail) {
                            final RenderBox childRenderBox = childKey.currentContext!.findRenderObject()! as RenderBox;
                            Offset global = childRenderBox.localToGlobal(Offset.zero);
                            logic.childOffset = global;
                            logic.calculate();
                          },
                          child: child,
                        ),
                )
              ],
            );
          });
        },
      ),
    );
  }
}
