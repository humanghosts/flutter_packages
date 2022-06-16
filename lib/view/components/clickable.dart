import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:hg_framework/hg_framework.dart';

class Clickable extends StatelessWidget {
  const Clickable({
    Key? key,
    required this.child,
    this.cursor = MaterialStateMouseCursor.clickable,
    this.tooltip,
    this.forceTooltip = false,
    this.tooltipBelow,
    this.onTapDown,
    this.onTapUp,
    this.onTap,
    this.onPressed,
    this.onTapCancel,
    this.onSecondaryTap,
    this.onSecondaryTapDown,
    this.onSecondaryTapUp,
    this.onSecondaryTapCancel,
    this.onTertiaryTapDown,
    this.onTertiaryTapUp,
    this.onTertiaryTapCancel,
    this.onDoubleTapDown,
    this.onDoubleTap,
    this.onDoubleTapCancel,
    this.onLongPressDown,
    this.onLongPressCancel,
    this.onLongPress,
    this.onLongPressStart,
    this.onLongPressMoveUpdate,
    this.onLongPressUp,
    this.onLongPressEnd,
    this.onSecondaryLongPressDown,
    this.onSecondaryLongPressCancel,
    this.onSecondaryLongPress,
    this.onSecondaryLongPressStart,
    this.onSecondaryLongPressMoveUpdate,
    this.onSecondaryLongPressUp,
    this.onSecondaryLongPressEnd,
    this.onTertiaryLongPressDown,
    this.onTertiaryLongPressCancel,
    this.onTertiaryLongPress,
    this.onTertiaryLongPressStart,
    this.onTertiaryLongPressMoveUpdate,
    this.onTertiaryLongPressUp,
    this.onTertiaryLongPressEnd,
    this.onVerticalDragDown,
    this.onVerticalDragStart,
    this.onVerticalDragUpdate,
    this.onVerticalDragEnd,
    this.onVerticalDragCancel,
    this.onHorizontalDragDown,
    this.onHorizontalDragStart,
    this.onHorizontalDragUpdate,
    this.onHorizontalDragEnd,
    this.onHorizontalDragCancel,
    this.onForcePressStart,
    this.onForcePressPeak,
    this.onForcePressUpdate,
    this.onForcePressEnd,
    this.onPanDown,
    this.onPanStart,
    this.onPanUpdate,
    this.onPanEnd,
    this.onPanCancel,
    this.onScaleStart,
    this.onScaleUpdate,
    this.onScaleEnd,
    this.behavior,
    this.excludeFromSemantics = false,
    this.dragStartBehavior = DragStartBehavior.start,
    this.onHover,
  }) : super(key: key);

  final String? tooltip;
  final bool forceTooltip;
  final bool? tooltipBelow;

  final Widget child;

  final GestureTapDownCallback? onTapDown;

  final GestureTapUpCallback? onTapUp;

  final GestureTapCallback? onTap;
  final GestureTapCallback? onPressed;

  final GestureTapCancelCallback? onTapCancel;

  final GestureTapCallback? onSecondaryTap;

  final GestureTapDownCallback? onSecondaryTapDown;

  final GestureTapUpCallback? onSecondaryTapUp;

  final GestureTapCancelCallback? onSecondaryTapCancel;

  final GestureTapDownCallback? onTertiaryTapDown;

  final GestureTapUpCallback? onTertiaryTapUp;

  final GestureTapCancelCallback? onTertiaryTapCancel;

  final GestureTapDownCallback? onDoubleTapDown;

  final GestureTapCallback? onDoubleTap;

  final GestureTapCancelCallback? onDoubleTapCancel;

  final GestureLongPressDownCallback? onLongPressDown;

  final GestureLongPressCancelCallback? onLongPressCancel;

  final GestureLongPressCallback? onLongPress;

  final GestureLongPressStartCallback? onLongPressStart;

  final GestureLongPressMoveUpdateCallback? onLongPressMoveUpdate;

  final GestureLongPressUpCallback? onLongPressUp;

  final GestureLongPressEndCallback? onLongPressEnd;

  final GestureLongPressDownCallback? onSecondaryLongPressDown;

  final GestureLongPressCancelCallback? onSecondaryLongPressCancel;

  final GestureLongPressCallback? onSecondaryLongPress;

  final GestureLongPressStartCallback? onSecondaryLongPressStart;

  final GestureLongPressMoveUpdateCallback? onSecondaryLongPressMoveUpdate;

  final GestureLongPressUpCallback? onSecondaryLongPressUp;

  final GestureLongPressEndCallback? onSecondaryLongPressEnd;

  final GestureLongPressDownCallback? onTertiaryLongPressDown;

  final GestureLongPressCancelCallback? onTertiaryLongPressCancel;

  final GestureLongPressCallback? onTertiaryLongPress;

  final GestureLongPressStartCallback? onTertiaryLongPressStart;

  final GestureLongPressMoveUpdateCallback? onTertiaryLongPressMoveUpdate;

  final GestureLongPressUpCallback? onTertiaryLongPressUp;

  final GestureLongPressEndCallback? onTertiaryLongPressEnd;

  final GestureDragDownCallback? onVerticalDragDown;

  final GestureDragStartCallback? onVerticalDragStart;

  final GestureDragUpdateCallback? onVerticalDragUpdate;

  final GestureDragEndCallback? onVerticalDragEnd;

  final GestureDragCancelCallback? onVerticalDragCancel;

  final GestureDragDownCallback? onHorizontalDragDown;

  final GestureDragStartCallback? onHorizontalDragStart;

  final GestureDragUpdateCallback? onHorizontalDragUpdate;

  final GestureDragEndCallback? onHorizontalDragEnd;

  final GestureDragCancelCallback? onHorizontalDragCancel;

  final GestureDragDownCallback? onPanDown;

  final GestureDragStartCallback? onPanStart;

  final GestureDragUpdateCallback? onPanUpdate;

  final GestureDragEndCallback? onPanEnd;

  final GestureDragCancelCallback? onPanCancel;

  final GestureScaleStartCallback? onScaleStart;

  final GestureScaleUpdateCallback? onScaleUpdate;

  final GestureScaleEndCallback? onScaleEnd;

  final GestureForcePressStartCallback? onForcePressStart;

  final GestureForcePressPeakCallback? onForcePressPeak;

  final GestureForcePressUpdateCallback? onForcePressUpdate;

  final GestureForcePressEndCallback? onForcePressEnd;

  final HitTestBehavior? behavior;

  final bool excludeFromSemantics;

  final DragStartBehavior dragStartBehavior;

  final MouseCursor cursor;

  final ValueChanged<bool>? onHover;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = AppLogic.instance.themeData;
    ThemeTemplate template = AppLogic.currentThemeTemplate;
    Widget widget;
    if (null == tooltip) {
      widget = child;
    } else if (AppLogic.isDesktop) {
      widget = Tooltip(child: child, message: tooltip, preferBelow: tooltipBelow);
    } else {
      if (forceTooltip) {
        widget = Tooltip(child: child, message: tooltip, preferBelow: tooltipBelow);
      } else {
        widget = child;
      }
    }
    return GestureDetector(
      child: Bounceable(
        onTap: onTap ?? onPressed,
        child: Ink(
          child: InkWell(
            mouseCursor: cursor,
            borderRadius: BorderRadius.circular(template.defaultRadius.value ?? 12),
            child: widget,
            hoverColor: theme.highlightColor,
            onTap: onTap ?? onPressed,
            onDoubleTap: onDoubleTap,
            onHover: onHover,
            onTapDown: onTapDown,
            onTapUp: onTapUp,
            onTapCancel: onTapCancel,
            onLongPress: onLongPress,
          ),
        ),
      ),
      onSecondaryTap: onSecondaryTap,
      onSecondaryTapDown: onSecondaryTapDown,
      onSecondaryTapUp: onSecondaryTapUp,
      onSecondaryTapCancel: onSecondaryTapCancel,
      onTertiaryTapDown: onTertiaryTapDown,
      onTertiaryTapUp: onTertiaryTapUp,
      onTertiaryTapCancel: onTertiaryTapCancel,
      onDoubleTapDown: onDoubleTapDown,
      onDoubleTapCancel: onDoubleTapCancel,
      onLongPressDown: onLongPressDown,
      onLongPressCancel: onLongPressCancel,
      onLongPressStart: onLongPressStart,
      onLongPressMoveUpdate: onLongPressMoveUpdate,
      onLongPressUp: onLongPressUp,
      onLongPressEnd: onLongPressEnd,
      onSecondaryLongPressDown: onSecondaryLongPressDown,
      onSecondaryLongPressCancel: onSecondaryLongPressCancel,
      onSecondaryLongPress: onSecondaryLongPress,
      onSecondaryLongPressStart: onSecondaryLongPressStart,
      onSecondaryLongPressMoveUpdate: onSecondaryLongPressMoveUpdate,
      onSecondaryLongPressUp: onSecondaryLongPressUp,
      onSecondaryLongPressEnd: onSecondaryLongPressEnd,
      onTertiaryLongPressDown: onTertiaryLongPressDown,
      onTertiaryLongPressCancel: onTertiaryLongPressCancel,
      onTertiaryLongPress: onTertiaryLongPress,
      onTertiaryLongPressStart: onTertiaryLongPressStart,
      onTertiaryLongPressMoveUpdate: onTertiaryLongPressMoveUpdate,
      onTertiaryLongPressUp: onTertiaryLongPressUp,
      onTertiaryLongPressEnd: onTertiaryLongPressEnd,
      onVerticalDragDown: onVerticalDragDown,
      onVerticalDragStart: onVerticalDragStart,
      onVerticalDragUpdate: onVerticalDragUpdate,
      onVerticalDragEnd: onVerticalDragEnd,
      onVerticalDragCancel: onVerticalDragCancel,
      onHorizontalDragDown: onHorizontalDragDown,
      onHorizontalDragStart: onHorizontalDragStart,
      onHorizontalDragUpdate: onHorizontalDragUpdate,
      onHorizontalDragEnd: onHorizontalDragEnd,
      onHorizontalDragCancel: onHorizontalDragCancel,
      onForcePressStart: onForcePressStart,
      onForcePressPeak: onForcePressPeak,
      onForcePressUpdate: onForcePressUpdate,
      onForcePressEnd: onForcePressEnd,
      onPanDown: onPanDown,
      onPanStart: onPanStart,
      onPanUpdate: onPanUpdate,
      onPanEnd: onPanEnd,
      onPanCancel: onPanCancel,
      onScaleStart: onScaleStart,
      onScaleUpdate: onScaleUpdate,
      onScaleEnd: onScaleEnd,
      behavior: behavior,
      excludeFromSemantics: excludeFromSemantics,
      dragStartBehavior: dragStartBehavior,
    );
  }
}
