import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hg_logger/main.dart';

class HgNeumorphicText extends StatelessWidget {
  final String text;
  final NeumorphicStyle? style;
  final TextAlign textAlign;
  final NeumorphicTextStyle? textStyle;
  final Curve curve;
  final Duration duration;
  final Color? color;
  final double? size;
  final double? depth;

  HgNeumorphicText(
    this.text, {
    Key? key,
    this.duration = Neumorphic.DEFAULT_DURATION,
    this.curve = Neumorphic.DEFAULT_CURVE,
    this.style,
    this.textAlign = TextAlign.center,
    this.textStyle,
    this.color,
    this.size,
    this.depth,
  }) : super(key: key ?? ValueKey(text));

  @override
  Widget build(BuildContext context) {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    final NeumorphicStyle style = (this.style ??
            NeumorphicStyle(
              color: color ?? themeData.defaultTextColor,
            ))
        .copyWithThemeIfNull(
          NeumorphicThemeData(
            depth: depth ?? (themeData.depth == 0 ? 0 : 1),
          ),
        )
        .copyWithThemeIfNull(themeData);

    return SingleChildScrollView(
      clipBehavior: Clip.antiAlias,
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          NeumorphicText(
            text,
            textStyle: textStyle == null ? NeumorphicTextStyle(fontSize: size) : textStyle!.copyWith(fontSize: size),
            textAlign: textAlign,
            duration: duration,
            style: style,
            curve: curve,
          )
        ],
      ),
    );
  }
}
