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

  const DraggableArgs({
    required this.child,
    this.initLeft,
    this.initTop,
    this.initBottom,
    this.initRight,
  });
}

/// 逻辑
class DraggableLogic extends ViewLogicOnlyArgs<DraggableArgs> {
  /// 浮动按钮需要的参数
  double? dx;
  double? dy;
  double? buttonWidth;
  double? buttonHeight;
  double? parentDx;
  double? parentDy;
  double? parentWidth;
  double? parentHeight;
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

  void calculate() {
    List<double?> list = [dx, dy, buttonWidth, buttonHeight, parentDx, parentDy, parentWidth, parentHeight];
    for (double? value in list) {
      if (value == null) return;
    }
    left.value = math.min(parentWidth! - buttonWidth!, math.max(dx! - parentDx! - buttonWidth! / 2, 0));
    top.value = math.min(parentHeight! - buttonHeight!, math.max(dy! - parentDy! - buttonWidth! / 2, 0));
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
    return DragTarget(
      builder: (context, candidateItems, rejectedItems) {
        Future.delayed(Duration.zero, () {
          final RenderBox stack = context.findRenderObject()! as RenderBox;
          Offset global = stack.localToGlobal(Offset.zero);
          logic.parentDx = global.dx;
          logic.parentDy = global.dy;
          logic.parentWidth = stack.size.width;
          logic.parentHeight = stack.size.height;
          logic.calculate();
        });
        return Stack(
          children: [
            Obx(() {
              Widget button = Builder(builder: (context) {
                Future.delayed(Duration.zero, () {
                  final RenderBox button = context.findRenderObject()! as RenderBox;
                  logic.buttonWidth = button.size.width;
                  logic.buttonHeight = button.size.height;
                  logic.calculate();
                });
                return args.child;
              });
              return Stack(
                children: [
                  Positioned(
                    left: logic.left.value,
                    top: logic.top.value,
                    right: logic.right.value,
                    bottom: logic.bottom.value,
                    child: Draggable(
                      child: button,
                      feedback: button,
                      childWhenDragging: Container(),
                      onDragUpdate: (detail) {
                        logic.dx = detail.localPosition.dx;
                        logic.dy = detail.localPosition.dy;
                        logic.calculate();
                      },
                    ),
                  )
                ],
              );
            }),
          ],
        );
      },
    );
  }
}
