import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/view/component/neumorphic/icon.dart';

class Logo extends StatelessWidget {
  final IconValue iconValue;
  final double? size;
  final bool isExpand;

  const Logo({
    Key? key,
    required this.iconValue,
    this.size = 40,
    this.isExpand = false,
  }) : super(key: key);

  const Logo.fromSize({
    Key? key,
    required this.iconValue,
    required this.size,
  })  : isExpand = false,
        assert(size != null),
        super(key: key);

  const Logo.expand({
    Key? key,
    required this.iconValue,
  })  : isExpand = true,
        size = null,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (isExpand) {
      child = buildExpand();
    } else {
      child = buildSize();
    }
    return child;
  }

  Widget buildSize() {
    return SizedBox(
      width: size,
      height: size,
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          color: Color(iconValue.backgroundColor),
          child: Center(child: buildIcon(null)),
        ),
      ),
    );
  }

  Widget buildExpand() {
    return AspectRatio(
      aspectRatio: 1,
      child: SizedBox.expand(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              color: Color(iconValue.backgroundColor),
              child: Center(child: buildIcon(constraints)),
            );
          },
        ),
      ),
    );
  }

  /// 构建icon
  Widget buildIcon(BoxConstraints? constraints) {
    if (iconValue.iconType == TextIcon) {
      return NeumorphicText(
        (iconValue.iconData as TextIcon).text,
        style: NeumorphicStyle(color: Color(iconValue.iconColor)),
      );
    } else if (iconValue.iconType == SvgIcon) {
      return SvgPicture.asset(
        (iconValue.iconData as SvgIcon).path,
        height: (constraints?.maxWidth ?? size!) * 0.618,
        width: (constraints?.maxWidth ?? size!) * 0.618,
        color: Color(iconValue.iconColor),
      );
    } else {
      return HgNeumorphicIcon(
        (iconValue.iconData as FontIcon).toIconData(),
        iconStyle: NeumorphicStyle(color: Color(iconValue.iconColor), border: const NeumorphicBorder.none()),
        size: (constraints?.maxWidth ?? size!) * 0.618,
      );
    }
  }
}
