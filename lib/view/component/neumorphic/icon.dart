import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/main.dart';

@immutable
class HgNeumorphicIcon extends StatelessWidget {
  final IconValue iconValue;
  final NeumorphicStyle? iconStyle;
  final Curve curve;
  final double? size;
  final Duration duration;
  final Color? color;
  final double? opacity;
  final NeumorphicThemeData? themeData;
  final double? depth;

  HgNeumorphicIcon(
    IconData icon, {
    Key? key,
    this.color,
    this.duration = Neumorphic.DEFAULT_DURATION,
    this.curve = Neumorphic.DEFAULT_CURVE,
    this.iconStyle,
    this.size,
    this.opacity,
    this.themeData,
    this.depth,
  })  : iconValue = IconValue.fontIcon(iconData: icon),
        super(key: key);

  HgNeumorphicIcon.fromIconValue(
    this.iconValue, {
    Key? key,
    NeumorphicStyle? style,
    this.size,
    this.duration = Neumorphic.DEFAULT_DURATION,
    this.curve = Neumorphic.DEFAULT_CURVE,
    this.color,
    this.opacity,
    this.themeData,
    this.depth,
  })  : iconStyle = style ??
            NeumorphicStyle(
              border: NeumorphicBorder(color: Color(iconValue.backgroundColor)),
              color: Color(iconValue.iconColor),
            ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = this.themeData ?? MainLogic.instance.neumorphicThemeData;
    final iconTheme = themeData.iconTheme;
    final NeumorphicStyle style = (iconStyle ?? const NeumorphicStyle())
        .copyWithThemeIfNull(
          NeumorphicThemeData(
            baseColor: color ?? iconTheme.color ?? themeData.baseColor,
            depth: depth ?? (themeData.depth == 0 ? 0 : 1),
          ),
        )
        .copyWithThemeIfNull(themeData);
    Widget child;
    if (iconValue.iconType == TextIcon) {
      child = buildTextIcon(iconValue.iconData as TextIcon, iconTheme, style);
    } else if (iconValue.iconType == SvgIcon) {
      child = buildSvgIcon(iconValue.iconData as SvgIcon, iconTheme, style);
    } else {
      child = buildFontIcon(iconValue.iconData as FontIcon, iconTheme, style);
    }
    return Opacity(opacity: opacity ?? iconTheme.opacity ?? 1, child: child);
  }

  Widget buildTextIcon(TextIcon icon, IconThemeData iconTheme, NeumorphicStyle style) {
    return NeumorphicText(
      icon.text,
      textStyle: NeumorphicTextStyle(fontSize: size ?? iconTheme.size),
      duration: duration,
      style: style,
      curve: curve,
    );
  }

  Widget buildFontIcon(FontIcon icon, IconThemeData iconTheme, NeumorphicStyle style) {
    return NeumorphicText(
      String.fromCharCode(icon.codePoint),
      textStyle: NeumorphicTextStyle(fontSize: size ?? iconTheme.size, fontFamily: icon.fontFamily, package: icon.fontPackage),
      duration: duration,
      style: style,
      curve: curve,
    );
  }

  Widget buildSvgIcon(SvgIcon icon, IconThemeData iconTheme, NeumorphicStyle style) {
    return SvgPicture.asset(
      icon.path,
      height: size ?? iconTheme.size,
      width: size ?? iconTheme.size,
      color: Color(iconValue.iconColor),
    );
  }
}
