import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:hg_logger/config.dart';
import 'package:hg_logger/main.dart';
import 'package:hg_logger/view/export.dart';

@immutable
class ExpandableFabArgs extends ViewArgs {
  /// 初始化状态
  final bool initOpen;

  /// 子按钮
  final List<Widget> children;

  final GlobalKey? tutorialKey;

  const ExpandableFabArgs({
    Key? key,
    this.initOpen = false,
    this.children = const [],
    this.tutorialKey,
  });
}

class ExpandableFabLogic extends ViewLogicOnlyArgs<ExpandableFabArgs> {
  late AnimationController controller;
  late Animation<double> expandAnimation;

  /// 是否展开
  bool isOpen = false;

  @override
  void onWidgetInitState(BuildContext context, GetBuilderState state) {
    isOpen = args.initOpen;
    controller = AnimationController(
      value: args.initOpen ? 1.0 : 0.0,
      duration: AppConfig.animationConfig.fastAnimationDuration,
      vsync: SimpleTickerProvider(),
    );
    expandAnimation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
      parent: controller,
    );
  }

  void toggle() {
    isOpen = !isOpen;
    if (isOpen) {
      controller.forward();
    } else {
      controller.reverse();
    }
    update();
  }
}

/// 可展开的fab按钮
class ExpandableFab extends View<ExpandableFabLogic> {
  ExpandableFab({
    required String key,
    ExpandableFabArgs? args,
  }) : super(key: key, args: args ?? const ExpandableFabArgs(), newLogic: ExpandableFabLogic());

  @override
  Widget buildView(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.bottomRight,
        clipBehavior: Clip.none,
        children: [
          ...buildExpandingActionButtons(),
          buildTapToOpenFab(),
        ],
      ),
    );
  }

  List<Widget> buildExpandingActionButtons() {
    final children = <Widget>[];
    final count = logic.args.children.length;
    for (var i = 0, angleInDegrees = 0.0; i < count; i++, angleInDegrees += 60) {
      children.add(_ExpandingActionButton(
        directionInDegrees: angleInDegrees,
        progress: logic.expandAnimation,
        child: logic.args.children[i],
      ));
    }
    return children;
  }

  Widget buildTapToOpenFab() {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return HgNeumorphicButton(
      key: logic.args.tutorialKey,
      padding: const EdgeInsets.all(16),
      child: AnimatedRotation(
        turns: logic.isOpen ? 0.13 : 0,
        duration: AppConfig.animationConfig.fastAnimationDuration,
        child: HgNeumorphicIcon(Icons.add),
      ),
      style: NeumorphicStyle(depth: logic.isOpen ? -themeData.depth : themeData.depth),
      onPressed: logic.toggle,
    );
  }
}

class _ExpandingActionButton extends StatelessWidget {
  const _ExpandingActionButton({
    Key? key,
    required this.directionInDegrees,
    required this.progress,
    required this.child,
  }) : super(key: key);

  final double directionInDegrees;
  final Animation<double> progress;
  final Widget child;
  final double padding = 16;

  @override
  Widget build(BuildContext context) {
    double distance = 56 + padding;
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        final offset = Offset(0, progress.value * directionInDegrees);
        return Positioned(
          // 位置+间隔
          bottom: 4 + distance + offset.dy,
          child: Transform.translate(
            offset: Offset.zero,
            child: child!,
          ),
        );
      },
      child: FadeTransition(
        opacity: progress,
        child: child,
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  const ActionButton({
    Key? key,
    this.onPressed,
    this.title,
    required this.child,
    this.padding,
    this.margin,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final Widget child;
  final String? title;
  final EdgeInsets? padding;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    if (title != null) {
      children.add(Text(title!));
      children.add(const Padding(padding: EdgeInsets.only(left: 8)));
    }
    children.add(HgNeumorphicButton(
      padding: padding,
      margin: margin,
      onPressed: onPressed,
      child: child,
    ));
    return Row(
      children: children,
    );
  }
}
