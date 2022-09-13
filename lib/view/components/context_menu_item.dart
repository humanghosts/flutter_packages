import 'package:flutter/material.dart';
import 'package:hg_framework/hg_framework.dart';

const double _kMenuHorizontalPadding = 16.0;

class MyPopupMenuItem<T> extends PopupMenuEntry<T> {
  const MyPopupMenuItem({
    Key? key,
    this.value,
    this.onTap,
    this.enabled = true,
    this.height = kMinInteractiveDimension,
    this.padding,
    this.margin,
    this.textStyle,
    this.mouseCursor,
    required this.child,
  }) : super(key: key);

  final T? value;
  final VoidCallback? onTap;
  final bool enabled;
  @override
  final double height;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final TextStyle? textStyle;
  final MouseCursor? mouseCursor;
  final Widget? child;

  @override
  bool represents(T? value) => value == this.value;

  @override
  PopupMenuItemState<T, MyPopupMenuItem<T>> createState() => PopupMenuItemState<T, MyPopupMenuItem<T>>();
}

class PopupMenuItemState<T, W extends MyPopupMenuItem<T>> extends State<W> {
  @protected
  Widget? buildChild() => widget.child;

  @protected
  void handleTap() {
    widget.onTap?.call();
    Navigator.pop<T>(context, widget.value);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final PopupMenuThemeData popupMenuTheme = PopupMenuTheme.of(context);
    TextStyle style = widget.textStyle ?? popupMenuTheme.textStyle ?? theme.textTheme.subtitle1!;
    if (!widget.enabled) style = style.copyWith(color: theme.disabledColor);
    Widget item = AnimatedDefaultTextStyle(
      style: style,
      duration: kThemeChangeDuration,
      child: Container(
        alignment: AlignmentDirectional.centerStart,
        constraints: BoxConstraints(minHeight: widget.height),
        padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: _kMenuHorizontalPadding),
        child: buildChild(),
      ),
    );
    if (!widget.enabled) {
      final bool isDark = theme.brightness == Brightness.dark;
      item = IconTheme.merge(
        data: IconThemeData(opacity: isDark ? 0.5 : 0.38),
        child: item,
      );
    }

    return MergeSemantics(
      child: Semantics(
        enabled: widget.enabled,
        button: true,
        child: Container(
          margin: widget.margin,
          child: Clickable(
            onTap: widget.enabled ? handleTap : null,
            child: item,
          ),
        ),
      ),
    );
  }
}

Widget buildContextMenuItem({
  Widget? icon,
  required Widget text,
  BoxFit iconFit = BoxFit.contain,
  BoxFit textFit = BoxFit.contain,
  double iconSize = 16,
  double fontSize = 20,
}) {
  Widget realIcon = SizedBox(
    height: iconSize,
    child: FittedBox(
      fit: iconFit,
      child: icon,
    ),
  );

  Widget realText = SizedBox(
    height: fontSize,
    child: FittedBox(
      fit: textFit,
      child: text,
    ),
  );

  return Material(
    color: Colors.transparent,
    child: Row(
      children: [
        if (DeviceInfoHelper.isDesktop && null != icon) ...[
          realIcon,
          const SizedBox(width: 12),
        ],
        if (DeviceInfoHelper.isMobile) const SizedBox(width: 12),
        realText,
        if (DeviceInfoHelper.isMobile && null != icon) ...[
          const Spacer(),
          realIcon,
          const SizedBox(width: 12),
        ],
      ],
    ),
  );
}
