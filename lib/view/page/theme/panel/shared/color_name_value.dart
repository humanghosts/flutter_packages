import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

import 'copy_color_to_clipboard.dart';

/// This widget is intended to be wrapped in Material with [color].
/// It shows a [label] describing the theme property name of the [color] and
/// color code name as a Material color, if it is a Material color and a common
/// color name for the color.
class ColorNameValue extends StatelessWidget {
  const ColorNameValue({
    Key? key,
    required this.color,
    required this.textColor,
    required this.label,
    this.fontSize = 12,
    this.tone,
    this.showTone = false,
    this.inputTextColor,
    this.showMaterialName = false,
    this.isLocked,
    this.onLocked,
  }) : super(key: key);

  final Color color;
  final Color textColor;
  final String label;
  final double fontSize;
  final int? tone;
  final bool showTone;
  final Color? inputTextColor;
  final bool showMaterialName;
  final bool? isLocked;
  final ValueChanged<bool?>? onLocked;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          buildLabel(),
          buildColorValue(context),
          buildLocked(context),
        ],
      ),
    );
  }

  Widget buildLabel() {
    return Text(
      label,
      textAlign: TextAlign.start,
      overflow: TextOverflow.clip,
      style: TextStyle(color: textColor, fontSize: fontSize, fontWeight: FontWeight.w600),
    );
  }

  Widget buildColorValue(BuildContext context) {
    const int alpha = 0xFF;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        if (tone != null && showTone)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Expanded(
                child: AnimatedTextKit(
                  key: ValueKey('色调${tone.toString()}'),
                  totalRepeatCount: 1,
                  animatedTexts: [
                    TyperAnimatedText(
                      '色调${tone.toString()}',
                      textAlign: TextAlign.end,
                      speed: const Duration(milliseconds: 100),
                      textStyle: TextStyle(
                        color: textColor.withAlpha(alpha),
                        fontSize: fontSize,
                        fontWeight: FontWeight.w600,
                        overflow: TextOverflow.clip,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        const Padding(padding: EdgeInsets.only(bottom: 4)),
        ElevatedButton(
          onPressed: () async {
            await copyColorToClipboard(context, color);
          },
          style: ElevatedButton.styleFrom(
            primary: color,
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              side: BorderSide(color: textColor, width: 2),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "色彩值",
                        overflow: TextOverflow.clip,
                        textAlign: TextAlign.end,
                        style: TextStyle(color: textColor.withAlpha(alpha), fontSize: fontSize - 1, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: AnimatedTextKit(
                        key: ValueKey('#${color.hexCode}'),
                        totalRepeatCount: 1,
                        animatedTexts: [
                          TyperAnimatedText(
                            '#${color.hexCode}',
                            textAlign: TextAlign.end,
                            textStyle: TextStyle(
                              color: textColor.withAlpha(alpha),
                              fontSize: fontSize,
                              fontWeight: FontWeight.w600,
                              overflow: TextOverflow.clip,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildLocked(BuildContext context) {
    if (null == isLocked || onLocked == null) return Container();
    return Positioned.directional(
      textDirection: Directionality.of(context),
      top: 14,
      start: -6,
      child: Switch(
        value: isLocked!,
        activeColor: Color.alphaBlend(color.withAlpha(0x25), textColor),
        activeTrackColor: Color.alphaBlend(color.withAlpha(0x60), textColor),
        inactiveTrackColor: Color.alphaBlend(color.withAlpha(0xAA), textColor),
        inactiveThumbColor: Color.alphaBlend(color.withAlpha(0xDD), textColor),
        onChanged: onLocked?.call,
        materialTapTargetSize: MaterialTapTargetSize.padded,
      ),
    );
  }
}
