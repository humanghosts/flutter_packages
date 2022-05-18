import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hg_logger/ability/export.dart';
import 'package:hg_logger/main.dart';
import 'package:hg_logger/view/export.dart';

/// 按钮
class HgNeumorphicButton extends StatelessWidget {
  static const double pressedScale = 0.98;
  static const double unpressedScale = 1.0;

  final Widget? child;
  final NeumorphicStyle? style;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final bool? pressed; //null, true, false
  final Duration duration;
  final Curve curve;
  final NeumorphicButtonClickListener? onPressed;
  final bool drawSurfaceAboveChild;
  final bool provideHapticFeedback;
  final String Function()? getTooltip;
  final bool fullScreenTooltip;
  final NeumorphicThemeData? themeData;

  const HgNeumorphicButton({
    Key? key,
    this.padding,
    this.margin = EdgeInsets.zero,
    this.child,
    this.getTooltip,
    this.drawSurfaceAboveChild = true,
    this.pressed,
    this.duration = Neumorphic.DEFAULT_DURATION,
    this.curve = Neumorphic.DEFAULT_CURVE,
    this.onPressed,
    this.style,
    this.provideHapticFeedback = true,
    this.fullScreenTooltip = false,
    this.themeData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NeumorphicThemeData themeData = this.themeData ?? MainLogic.instance.neumorphicThemeData;
    return GestureDetector(
      child: NeumorphicButton(
        padding: padding,
        margin: margin,
        child: child,
        // tooltip: tooltip,
        drawSurfaceAboveChild: drawSurfaceAboveChild,
        pressed: pressed,
        duration: duration,
        curve: curve,
        onPressed: onPressed,
        minDistance: -themeData.depth,
        style: style,
        provideHapticFeedback: provideHapticFeedback,
      ),
      onLongPress: () {
        if (getTooltip == null) return;
        String tooltip = getTooltip!.call();
        if (tooltip.isEmpty) return;
        HapticFeedback.lightImpact();
        if (fullScreenTooltip) {
          RouteHelper.overlay(SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Center(
                child: SingleChildScrollView(
                  clipBehavior: Clip.none,
                  child: Text(
                    tooltip,
                    style: TextStyle(
                      overflow: TextOverflow.visible,
                      color: themeData.defaultTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ));
        } else {
          RouteHelper.toast(msg: tooltip, gravity: ToastGravity.CENTER);
        }
      },
    );
  }
}

/// 后退按钮
class HgNeumorphicBackButton extends StatelessWidget {
  final void Function()? onPressed;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final NeumorphicThemeData? themeData;

  const HgNeumorphicBackButton({
    Key? key,
    this.onPressed,
    this.padding,
    this.margin,
    this.themeData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HgNeumorphicButton(
      padding: padding,
      margin: margin,
      getTooltip: () => "后退",
      style: const NeumorphicStyle(
        boxShape: NeumorphicBoxShape.circle(),
      ),
      child: HgNeumorphicIcon(Icons.navigate_before, themeData: themeData),
      onPressed: onPressed,
    );
  }
}

/// 前进按钮
class HgNeumorphicNextButton extends StatelessWidget {
  final void Function()? onPressed;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final NeumorphicThemeData? themeData;

  const HgNeumorphicNextButton({
    Key? key,
    this.onPressed,
    this.padding,
    this.margin,
    this.themeData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NeumorphicThemeData themeData = this.themeData ?? MainLogic.instance.neumorphicThemeData;
    return HgNeumorphicButton(
      padding: padding,
      margin: margin,
      getTooltip: () => "前进",
      style: const NeumorphicStyle(
        boxShape: NeumorphicBoxShape.circle(),
      ),
      child: HgNeumorphicIcon(Icons.navigate_next, color: themeData.accentColor, themeData: themeData),
      onPressed: onPressed,
    );
  }
}

/// 关闭按钮
class HgNeumorphicCloseButton extends StatelessWidget {
  final void Function()? onPressed;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final NeumorphicThemeData? themeData;

  const HgNeumorphicCloseButton({
    Key? key,
    this.onPressed,
    this.padding,
    this.margin,
    this.themeData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HgNeumorphicButton(
      padding: padding,
      margin: margin,
      getTooltip: () => "关闭",
      style: const NeumorphicStyle(boxShape: NeumorphicBoxShape.circle()),
      child: HgNeumorphicIcon(Icons.close, themeData: themeData),
      onPressed: onPressed,
    );
  }
}

/// 确认按钮
class HgNeumorphicDoneButton extends StatelessWidget {
  final void Function()? onPressed;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final NeumorphicThemeData? themeData;

  const HgNeumorphicDoneButton({
    Key? key,
    this.onPressed,
    this.padding,
    this.margin,
    this.themeData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NeumorphicThemeData themeData = this.themeData ?? MainLogic.instance.neumorphicThemeData;
    return HgNeumorphicButton(
      padding: padding,
      margin: margin,
      getTooltip: () => "保存",
      style: const NeumorphicStyle(
        boxShape: NeumorphicBoxShape.circle(),
      ),
      child: HgNeumorphicIcon(Icons.done, color: themeData.accentColor, themeData: themeData),
      onPressed: onPressed,
    );
  }
}

@immutable
class HgNeumorphicExpandedButtonArgs extends ViewArgs {
  final ValueChanged<bool>? onExpanded;
  final bool initExpanded;
  final EdgeInsets? padding;
  final EdgeInsets? containerPadding;
  final EdgeInsets? rowPadding;
  final Widget? left;
  final Widget? child;
  final NeumorphicStyle? buttonStyle;
  final NeumorphicThemeData? themeData;
  final String Function()? getTooltip;
  final bool fullScreenTooltip;
  final bool disabled;

  const HgNeumorphicExpandedButtonArgs({
    this.onExpanded,
    this.getTooltip,
    this.fullScreenTooltip = false,
    this.initExpanded = false,
    this.padding,
    this.containerPadding,
    this.rowPadding,
    this.left,
    this.child,
    this.buttonStyle,
    this.themeData,
    this.disabled = false,
  });
}

class HgNeumorphicExpandedButtonLogic extends ViewLogicOnlyArgs<HgNeumorphicExpandedButtonArgs> {
  static final Animatable<double> _iconTurnTween = Tween<double>(begin: 0.0, end: 0.5).chain(CurveTween(curve: Curves.fastOutSlowIn));
  late final AnimationController _controller;
  late final Animation<double> _iconTurns;
  bool isExpand = false;

  HgNeumorphicExpandedButtonLogic() {
    _controller = AnimationController(duration: kThemeAnimationDuration, vsync: SimpleTickerProvider());
    _iconTurns = _controller.drive(_iconTurnTween);
  }

  @override
  void afterArgsUpdate() {
    isExpand = args.initExpanded;
    if (isExpand) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  void expand() {
    isExpand = !isExpand;
    if (isExpand) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    update();
    args.onExpanded?.call(isExpand);
  }
}

/// 展开按钮
class HgNeumorphicExpandedButton extends View<HgNeumorphicExpandedButtonLogic> {
  HgNeumorphicExpandedButton({
    required String key,
    HgNeumorphicExpandedButtonArgs? args,
  }) : super(key: key, args: args ?? const HgNeumorphicExpandedButtonArgs(), newLogic: HgNeumorphicExpandedButtonLogic());

  @override
  Widget buildView(BuildContext context) {
    if (null == logic.args.left && null == logic.args.child) return buildExpanded(context);
    Widget row = Container(
      clipBehavior: Clip.none,
      padding: logic.args.rowPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          logic.args.left ?? Container(),
          buildExpanded(context),
        ],
      ),
    );
    NeumorphicThemeData themeData = logic.args.themeData ?? MainLogic.instance.neumorphicThemeData;
    bool isExpand = logic.isExpand;
    NeumorphicStyle style = (logic.args.buttonStyle ?? const NeumorphicStyle()).copyWith(
      depth: isExpand ? -themeData.depth : themeData.depth,
    );
    return HgNeumorphicButton(
      padding: logic.args.containerPadding,
      style: style,
      getTooltip: logic.args.getTooltip,
      fullScreenTooltip: logic.args.fullScreenTooltip,
      child: Column(
        children: [
          row,
          logic.isExpand && logic.args.child != null ? logic.args.child! : Container(),
        ],
      ),
      onPressed: logic.args.disabled ? null : logic.expand,
    );
  }

  Widget buildExpanded(BuildContext context) {
    bool isExpand = logic.isExpand;
    NeumorphicThemeData themeData = logic.args.themeData ?? MainLogic.instance.neumorphicThemeData;
    return HgNeumorphicButton(
      padding: logic.args.padding,
      getTooltip: () => logic.args.disabled
          ? "禁用"
          : logic.isExpand
              ? "收起"
              : "展开",
      style: NeumorphicStyle(depth: isExpand ? -themeData.depth : themeData.depth),
      child: RotationTransition(
        turns: logic._iconTurns,
        child: HgNeumorphicIcon(logic.args.disabled ? Icons.chevron_right : Icons.expand_more, themeData: themeData),
      ),
      onPressed: logic.args.disabled ? null : logic.expand,
    );
  }
}
