import 'package:flutter/material.dart';

import 'color_card.dart';

/// Draw a number of boxes showing the colors of key sub theme color properties
/// in the ColorScheme of the inherited ThemeData and its color properties.
///
/// This widget is just used so we can visually see the active scheme colors
/// in the examples and their used FlexColorScheme based themes.
///
/// These are all Flutter "Universal" Widgets that only depends on the SDK and
/// all the Widgets in this file be dropped into any application. They are
/// however not so generally reusable.
class ShowSubThemeColors extends StatelessWidget {
  const ShowSubThemeColors({
    Key? key,
    this.onBackgroundColor,
    this.showSubtitle = true,
  }) : super(key: key);

  /// The color of the background the color widget are being drawn on.
  ///
  /// Some of the theme colors may have semi transparent fill color. To compute
  /// a legible text color for the sum when it shown on a background color, we
  /// need to alpha merge it with background and we need the exact background
  /// color it is drawn on for that. If not passed in from parent, it is
  /// assumed to be drawn on card color, which usually is close enough.
  final Color? onBackgroundColor;

  /// Show sub-title for the sub-theme colors
  final bool showSubtitle;

  // Return true if the color is light, meaning it needs dark text for contrast.
  static bool _isLight(final Color color) => ThemeData.estimateBrightnessForColor(color) == Brightness.light;

  // On color used when a theme color property does not have a theme onColor.
  static Color _onColor(final Color color, final Color bg) => _isLight(Color.alphaBlend(color, bg)) ? Colors.black : Colors.white;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final bool isDark = colorScheme.brightness == Brightness.dark;

    final MediaQueryData media = MediaQuery.of(context);
    final bool isPhone = media.size.width < 800;
    final double spacing = isPhone ? 3 : 6;

    // Get effective background color.
    final Color background = onBackgroundColor ?? theme.cardTheme.color ?? theme.cardColor;
    // Grab the card border from the theme card shape
    ShapeBorder? border = theme.cardTheme.shape;
    // If we had one, copy in a border side to it.
    if (border is RoundedRectangleBorder) {
      border = border.copyWith(
        side: BorderSide(
          color: theme.dividerColor,
          width: 1,
        ),
      );
      // If
    } else {
      // If border was null, make one matching Card default, but with border
      // side, if it was not null, we leave it as it was.
      border ??= RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        side: BorderSide(
          color: theme.dividerColor,
          width: 1,
        ),
      );
    }

    // Get the themed or default color of all shown components' colors.
    final Color elevatedButtonColor = theme.elevatedButtonTheme.style?.backgroundColor?.resolve(<MaterialState>{}) ?? colorScheme.primary;
    final Color outlinedButtonColor = theme.outlinedButtonTheme.style?.foregroundColor?.resolve(<MaterialState>{}) ?? colorScheme.primary;
    final Color textButtonColor = theme.textButtonTheme.style?.foregroundColor?.resolve(<MaterialState>{}) ?? colorScheme.primary;
    final Color toggleButtonsColor = theme.toggleButtonsTheme.color ?? colorScheme.primary;
    final Color floatingActionButtonColor = theme.floatingActionButtonTheme.backgroundColor ?? colorScheme.secondary;
    final Color switchColor = theme.switchTheme.thumbColor?.resolve(<MaterialState>{MaterialState.selected}) ?? theme.toggleableActiveColor;
    final Color checkboxColor = theme.checkboxTheme.fillColor?.resolve(<MaterialState>{MaterialState.selected}) ?? theme.toggleableActiveColor;
    final Color radioColor = theme.radioTheme.fillColor?.resolve(<MaterialState>{MaterialState.selected}) ?? theme.toggleableActiveColor;
    final Color circleAvatarColor = isDark ? theme.primaryColorLight : theme.primaryColorDark;
    final Color chipColor = theme.chipTheme.backgroundColor ?? colorScheme.primary;
    final Color inputDecoratorColor = theme.inputDecorationTheme.focusColor?.withAlpha(0xFF) ?? colorScheme.primary;
    final Decoration? tooltipDecoration = theme.tooltipTheme.decoration;
    final Color tooltipColor = tooltipDecoration is BoxDecoration ? tooltipDecoration.color ?? colorScheme.surface : colorScheme.surface;
    final Color appBarColor = theme.appBarTheme.backgroundColor ?? (isDark ? colorScheme.surface : colorScheme.primary);
    final Color tabBarColor = theme.tabBarTheme.labelColor ?? (isDark ? colorScheme.onSurface : colorScheme.onPrimary);
    final Color dialogColor = theme.dialogTheme.backgroundColor ?? theme.dialogBackgroundColor;
    final Color defaultSnackBackgroundColor = isDark ? colorScheme.onSurface : Color.alphaBlend(colorScheme.onSurface.withOpacity(0.80), colorScheme.surface);
    final Color snackBarColor = theme.snackBarTheme.backgroundColor ?? defaultSnackBackgroundColor;
    final Color snackForeground =
        theme.snackBarTheme.contentTextStyle?.color ?? (ThemeData.estimateBrightnessForColor(snackBarColor) == Brightness.light ? Colors.black : Colors.white);
    final Color bottomNavBarColor = theme.bottomNavigationBarTheme.backgroundColor ?? colorScheme.background;
    final Color bottomNavBarItemColor = theme.bottomNavigationBarTheme.selectedItemColor ?? (isDark ? colorScheme.secondary : colorScheme.primary);
    final Color navigationBarColor =
        theme.navigationBarTheme.backgroundColor ?? ElevationOverlay.colorWithOverlay(colorScheme.surface, colorScheme.onSurface, 3.0);
    final Color navigationBarItemColor = theme.navigationBarTheme.iconTheme?.resolve(<MaterialState>{MaterialState.selected})?.color ?? colorScheme.onSurface;
    final Color navigationBarIndicatorColor = theme.navigationBarTheme.indicatorColor ?? colorScheme.secondary.withOpacity(.24);
    final Color navigationRailColor = theme.navigationRailTheme.backgroundColor ?? colorScheme.surface;
    final Color navigationRailItemColor = theme.navigationRailTheme.selectedIconTheme?.color ?? colorScheme.primary;
    final Color navigationRailIndicatorColor = theme.navigationRailTheme.indicatorColor ?? colorScheme.secondary.withOpacity(.24);
    final Color textColor = theme.textTheme.titleMedium?.color ?? (isDark ? Colors.white : Colors.black);
    final Color primTextColor = theme.primaryTextTheme.titleMedium?.color ??
        (ThemeData.estimateBrightnessForColor(colorScheme.primary) == Brightness.dark ? Colors.white : Colors.black);

    // Wrap this widget branch in a custom theme where card has a border outline
    // if it did not have one, but retains in ambient themed border radius.
    return Theme(
      data: Theme.of(context).copyWith(
        cardTheme: CardTheme.of(context).copyWith(
          elevation: 0,
          shape: border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              '组件配色',
              style: theme.textTheme.titleMedium,
            ),
          ),
          Wrap(
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: spacing,
            runSpacing: spacing,
            children: <Widget>[
              ColorCard(label: '升高按钮', color: elevatedButtonColor, textColor: _onColor(elevatedButtonColor, background)),
              ColorCard(label: '轮廓按钮', color: outlinedButtonColor, textColor: _onColor(elevatedButtonColor, background)),
              ColorCard(label: '文本按钮', color: textButtonColor, textColor: _onColor(textButtonColor, background)),
              ColorCard(label: '切换按钮', color: toggleButtonsColor, textColor: _onColor(toggleButtonsColor, background)),
              ColorCard(label: '开关', color: switchColor, textColor: _onColor(switchColor, background)),
              ColorCard(label: '复选框', color: checkboxColor, textColor: _onColor(checkboxColor, background)),
              ColorCard(label: '单选框', color: radioColor, textColor: _onColor(radioColor, background)),
              ColorCard(label: '飘浮动作\n按钮', color: floatingActionButtonColor, textColor: _onColor(floatingActionButtonColor, background)),
              ColorCard(label: '圆形头像', color: circleAvatarColor, textColor: _onColor(circleAvatarColor, background)),
              ColorCard(label: '标签', color: chipColor, textColor: _onColor(chipColor, background)),
              ColorCard(label: '输入框', color: inputDecoratorColor, textColor: _onColor(inputDecoratorColor, background)),
              ColorCard(label: '提示', color: tooltipColor, textColor: _onColor(tooltipColor, background)),
              ColorCard(label: '应用栏', color: appBarColor, textColor: _onColor(appBarColor, background)),
              ColorCard(label: '标签栏目', color: tabBarColor, textColor: _onColor(tabBarColor, background)),
              ColorCard(label: '标签栏\n指示器', color: theme.indicatorColor, textColor: _onColor(theme.indicatorColor, background)),
              ColorCard(label: '对话框\n背景', color: dialogColor, textColor: _onColor(dialogColor, background)),
              ColorCard(label: '提示背景', color: snackBarColor, textColor: snackForeground),
              ColorCard(label: '底部导航\n栏背景', color: bottomNavBarColor, textColor: _onColor(bottomNavBarColor, background)),
              ColorCard(label: '底部导航\n栏选中', color: bottomNavBarItemColor, textColor: _onColor(bottomNavBarItemColor, background)),
              ColorCard(label: '导航栏\n背景', color: navigationBarColor, textColor: _onColor(navigationBarColor, background)),
              ColorCard(label: '导航栏\n选中', color: navigationBarItemColor, textColor: _onColor(navigationBarItemColor, background)),
              ColorCard(label: '导航栏\n指示器', color: navigationBarIndicatorColor, textColor: _onColor(navigationBarIndicatorColor, background)),
              ColorCard(label: '导轨背景', color: navigationRailColor, textColor: _onColor(navigationRailColor, background)),
              ColorCard(label: '导轨选中', color: navigationRailItemColor, textColor: _onColor(navigationRailItemColor, background)),
              ColorCard(label: '导轨\n指示器', color: navigationRailIndicatorColor, textColor: _onColor(navigationRailIndicatorColor, background)),
              ColorCard(label: '文本', color: textColor, textColor: _onColor(textColor, background)),
              ColorCard(label: '主要文本', color: primTextColor, textColor: _onColor(primTextColor, background)),
              ColorCard(label: '卡片', color: theme.cardColor, textColor: colorScheme.onSurface),
              ColorCard(label: '禁用', color: theme.disabledColor, textColor: _onColor(theme.disabledColor, background)),
              ColorCard(label: '悬停', color: theme.hoverColor, textColor: _onColor(theme.hoverColor, background)),
              ColorCard(label: '聚焦', color: theme.focusColor, textColor: _onColor(theme.focusColor, background)),
              ColorCard(label: '高亮', color: theme.highlightColor, textColor: _onColor(theme.highlightColor, background)),
              ColorCard(label: '闪', color: theme.splashColor, textColor: _onColor(theme.splashColor, background)),
            ],
          ),
        ],
      ),
    );
  }
}
