import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hg_logger/main.dart';
import 'package:hg_logger/view/component/export.dart';

class HgNeumorphicChip extends StatelessWidget {
  final Function()? onTap;
  final Widget? avatar;
  final Widget? label;
  final NeumorphicStyle? style;
  final String Function()? getTooltip;
  final bool fullScreenTooltip;
  final NeumorphicThemeData? themeData;

  const HgNeumorphicChip({
    Key? key,
    this.avatar,
    this.label,
    this.onTap,
    this.style,
    this.getTooltip,
    this.fullScreenTooltip = false,
    this.themeData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NeumorphicThemeData themeData = this.themeData ?? MainLogic.instance.neumorphicThemeData;
    NeumorphicStyle style = (this.style ?? const NeumorphicStyle()).copyWithThemeIfNull(
      themeData.copyWith(boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(16))),
    );
    return HgNeumorphicButton(
      padding: const EdgeInsets.all(6),
      style: style,
      getTooltip: getTooltip,
      fullScreenTooltip: fullScreenTooltip,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          avatar ?? Container(),
          label ?? Container(),
        ],
      ),
      onPressed: onTap,
    );
  }
}
