import 'package:flutter/material.dart';

class RawPopupMenuItem<T> extends PopupMenuItem<T> {
  final EdgeInsetsGeometry? margin;

  const RawPopupMenuItem({
    super.key,
    super.value,
    super.onTap,
    super.enabled = true,
    super.height = kMinInteractiveDimension,
    super.padding,
    super.textStyle,
    super.mouseCursor,
    required super.child,
    this.margin,
  });

  @override
  PopupMenuItemState<T, RawPopupMenuItem<T>> createState() => RawPopupMenuItemState<T, RawPopupMenuItem<T>>();
}

class RawPopupMenuItemState<T, W extends RawPopupMenuItem<T>> extends PopupMenuItemState<T, W> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final PopupMenuThemeData popupMenuTheme = PopupMenuTheme.of(context);
    TextStyle style = widget.textStyle ?? popupMenuTheme.textStyle ?? theme.textTheme.subtitle1!;

    if (!widget.enabled) style = style.copyWith(color: theme.disabledColor);

    final bool isDark = theme.brightness == Brightness.dark;
    return MergeSemantics(
      child: Semantics(
        enabled: widget.enabled,
        button: true,
        child: AnimatedDefaultTextStyle(
          style: style,
          duration: kThemeChangeDuration,
          child: IconTheme.merge(
            data: !widget.enabled ? IconThemeData(opacity: isDark ? 0.5 : 0.38) : const IconThemeData(),
            child: Container(
              margin: widget.margin ?? const EdgeInsets.symmetric(horizontal: 6),
              alignment: AlignmentDirectional.centerStart,
              child: InkWell(
                // borderRadius: BorderRadius.circular(template.defaultRadius.value ?? 12),
                onTap: widget.enabled ? handleTap : null,
                canRequestFocus: widget.enabled,
                mouseCursor: _EffectiveMouseCursor(widget.mouseCursor, popupMenuTheme.mouseCursor),
                child: Container(
                  alignment: AlignmentDirectional.centerStart,
                  padding: widget.padding ?? const EdgeInsets.all(4),
                  child: buildChild(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// This MaterialStateProperty is passed along to the menu item's InkWell which
// resolves the property against MaterialState.disabled, MaterialState.hovered,
// MaterialState.focused.
class _EffectiveMouseCursor extends MaterialStateMouseCursor {
  const _EffectiveMouseCursor(this.widgetCursor, this.themeCursor);

  final MouseCursor? widgetCursor;
  final MaterialStateProperty<MouseCursor?>? themeCursor;

  @override
  MouseCursor resolve(Set<MaterialState> states) {
    return MaterialStateProperty.resolveAs<MouseCursor?>(widgetCursor, states) ??
        themeCursor?.resolve(states) ??
        MaterialStateMouseCursor.clickable.resolve(states);
  }

  @override
  String get debugDescription => 'MaterialStateMouseCursor(PopupMenuItemState)';
}
