import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:hg_logger/main.dart';
import 'package:hg_logger/view/export.dart';

@immutable
class ExpansionArgs extends ViewArgs {
  final Widget? body;
  final Widget? title;
  final Widget? subtitle;
  final ValueChanged<bool>? onExpand;
  final bool initExpand;
  final EdgeInsets? padding;

  const ExpansionArgs({
    this.body,
    this.title,
    this.subtitle,
    this.onExpand,
    this.padding,
    this.initExpand = false,
  });
}

class ExpansionLogic extends ViewLogicOnlyArgs<ExpansionArgs> {
  Rx<bool> isExpand = false.obs;
  late AnimationController _controller;
  late Animation<double> _iconTurns;

  static final Animatable<double> _iconTurnTween = Tween<double>(begin: 0.0, end: 0.5).chain(CurveTween(curve: Curves.fastOutSlowIn));

  ExpansionLogic() {
    _controller = AnimationController(duration: kThemeAnimationDuration, vsync: SimpleTickerProvider());
    _iconTurns = _controller.drive(_iconTurnTween);
  }

  @override
  void onReady() {
    super.onReady();
    isExpand.value = args.initExpand;
    if (isExpand.value) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  void expand() {
    isExpand.value = !isExpand.value;
    if (isExpand.value) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    update();
    args.onExpand?.call(isExpand.value);
  }
}

class Expansion extends View<ExpansionLogic> {
  Expansion({required String key, ExpansionArgs? args})
      : super(
          key: key,
          args: args ?? const ExpansionArgs(),
          newLogic: ExpansionLogic(),
        );

  @override
  Widget buildView(BuildContext context) {
    return Column(
      children: [
        buildHeader(),
        Obx(() {
          if (!logic.isExpand.value) return Container();
          return logic.args.body ?? Container();
        })
      ],
    );
  }

  Widget buildHeader() {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return ListTile(
      contentPadding: logic.args.padding,
      minLeadingWidth: 0,
      title: logic.args.title,
      subtitle: logic.args.subtitle,
      trailing: Obx(
        () => HgNeumorphicButton(
          getTooltip: () => "展开",
          style: NeumorphicStyle(depth: logic.isExpand.value ? -themeData.depth : themeData.depth),
          child: RotationTransition(
            turns: logic._iconTurns,
            child: HgNeumorphicIcon(Icons.expand_more),
          ),
          onPressed: logic.expand,
        ),
      ),
      onTap: () {
        HapticFeedback.lightImpact();
        logic.expand();
      },
    );
  }
}
