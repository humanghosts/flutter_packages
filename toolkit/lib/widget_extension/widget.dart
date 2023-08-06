part of 'widget_extension.dart';

extension GestureEx on Widget {
  /// 点击事件
  Widget onTap(GestureTapCallback onTap, {Key? key}) {
    return gestures(key: key, onTap: onTap);
  }
}

extension TooltipEx on Widget {
  Widget tooltip({
    Key? key,
    String? message,
    InlineSpan? richMessage,
    double? height,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    double? verticalOffset,
    bool? preferBelow,
    bool? excludeFromSemantics,
    Decoration? decoration,
    TextStyle? textStyle,
    TextAlign? textAlign,
    Duration? waitDuration,
    Duration? showDuration,
    TooltipTriggerMode? triggerMode,
    bool? enableFeedback,
    TooltipTriggeredCallback? onTriggered,
    TooltipThemeData? themeData,
  }) {
    Tooltip tooltip = Tooltip(
      key: key,
      message: message,
      richMessage: richMessage,
      height: height,
      padding: padding,
      margin: margin,
      verticalOffset: verticalOffset,
      preferBelow: preferBelow,
      excludeFromSemantics: excludeFromSemantics,
      decoration: decoration,
      textStyle: textStyle,
      textAlign: textAlign,
      waitDuration: waitDuration,
      showDuration: showDuration,
      triggerMode: triggerMode,
      enableFeedback: enableFeedback,
      onTriggered: onTriggered,
      child: this,
    );
    if (null != themeData) return TooltipTheme(data: themeData, child: tooltip);
    return tooltip;
  }

  Widget withTooltip(Tooltip tooltip) {
    return tooltip.copyWith(child: this);
  }
}

extension TooltipCopy on Tooltip {
  Tooltip copyWith({
    Key? key,
    String? message,
    InlineSpan? richMessage,
    double? height,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    double? verticalOffset,
    bool? preferBelow,
    bool? excludeFromSemantics,
    Decoration? decoration,
    TextStyle? textStyle,
    TextAlign? textAlign,
    Duration? waitDuration,
    Duration? showDuration,
    TooltipTriggerMode? triggerMode,
    bool? enableFeedback,
    TooltipTriggeredCallback? onTriggered,
    TooltipThemeData? themeData,
    Widget? child,
  }) {
    return Tooltip(
      key: key ?? this.key,
      message: message ?? this.message,
      richMessage: richMessage ?? this.richMessage,
      height: height ?? this.height,
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
      verticalOffset: verticalOffset ?? this.verticalOffset,
      preferBelow: preferBelow ?? this.preferBelow,
      excludeFromSemantics: excludeFromSemantics ?? this.excludeFromSemantics,
      decoration: decoration ?? this.decoration,
      textStyle: textStyle ?? this.textStyle,
      textAlign: textAlign ?? this.textAlign,
      waitDuration: waitDuration ?? this.waitDuration,
      showDuration: showDuration ?? this.showDuration,
      triggerMode: triggerMode ?? this.triggerMode,
      enableFeedback: enableFeedback ?? this.enableFeedback,
      onTriggered: onTriggered ?? this.onTriggered,
      child: child ?? this.child,
    );
  }
}
