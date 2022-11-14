import 'package:flutter/material.dart';
import 'package:hg_framework/ability/ability.dart';

Color getOnColor(
  Color bgColor, [
  Color? secondColor,
]) {
  if (bgColor.opacity < 0.3 && secondColor != null) {
    return getOnColor(secondColor);
  }
  double darkness = 1 - (0.299 * bgColor.red + 0.587 * bgColor.green + 0.114 * bgColor.blue) / 255;
  return darkness < 0.5 ? Colors.black : Colors.white;
}

Color getOnAppBarColor() {
  ThemeData theme = ThemeHelper().themeData;
  Color? foreColor = theme.appBarTheme.foregroundColor;
  Color? backColor = theme.appBarTheme.backgroundColor;
  if (backColor != null && backColor.opacity > 0.3 && foreColor != null) {
    return foreColor;
  }
  return getOnColor(
    theme.scaffoldBackgroundColor,
  );
}
