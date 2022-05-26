import 'package:flutter/material.dart';

import 'color_card.dart';

/// Draw a number of boxes showing the colors of key theme color properties
/// in the ColorScheme of the inherited ThemeData and its color properties.
///
/// This widget is just used so we can visually see the active scheme colors
/// in the examples and their used FlexColorScheme based themes.
///
/// It also shows warning labels when using surface branding that is too
/// strong and makes the surface require reverse contrasted text in relation to
/// text normally associated with the active theme mode.
///
/// These are all Flutter "Universal" Widgets that only depends on the SDK and
/// all the Widgets in this file be dropped into any application. They are
/// however not so generally reusable.
class ShowColorSchemeColors extends StatelessWidget {
  const ShowColorSchemeColors({Key? key, this.onBackgroundColor}) : super(key: key);

  /// The color of the background the color widget are being drawn on.
  ///
  /// Some of the theme colors may have semi transparent fill color. To compute
  /// a legible text color for the sum when it shown on a background color, we
  /// need to alpha merge it with background and we need the exact background
  /// color it is drawn on for that. If not passed in from parent, it is
  /// assumed to be drawn on card color, which usually is close enough.
  final Color? onBackgroundColor;

  // Return true if the color is light, meaning it needs dark text for contrast.
  static bool _isLight(final Color color) => ThemeData.estimateBrightnessForColor(color) == Brightness.light;

  // Return true if the color is dark, meaning it needs light text for contrast.
  static bool _isDark(final Color color) => ThemeData.estimateBrightnessForColor(color) == Brightness.dark;

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

    // Get effective background color.
    final Color background = onBackgroundColor ?? theme.cardTheme.color ?? theme.cardColor;

    // Warning label for scaffold background when it uses to much blend.
    final String surfaceTooHigh = isDark
        ? _isLight(theme.colorScheme.surface)
            ? '\nTOO HIGH'
            : ''
        : _isDark(theme.colorScheme.surface)
            ? '\nTOO HIGH'
            : '';

    // Warning label for scaffold background when it uses to much blend.
    final String backTooHigh = isDark
        ? _isLight(theme.colorScheme.background)
            ? '\nTOO HIGH'
            : ''
        : _isDark(theme.colorScheme.background)
            ? '\nTOO HIGH'
            : '';

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
              '配色方案色彩',
              style: theme.textTheme.titleMedium,
            ),
          ),
          Wrap(
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: spacing,
            runSpacing: spacing,
            children: <Widget>[
              ColorCard(label: '主要', color: colorScheme.primary, textColor: colorScheme.onPrimary),
              ColorCard(label: '主要\n文本图标', color: colorScheme.onPrimary, textColor: colorScheme.primary),
              ColorCard(label: '主要\n容器', color: colorScheme.primaryContainer, textColor: colorScheme.onPrimaryContainer),
              ColorCard(label: '主要容器\n文本图标', color: colorScheme.onPrimaryContainer, textColor: colorScheme.primaryContainer),
              ColorCard(label: '次要', color: colorScheme.secondary, textColor: colorScheme.onSecondary),
              ColorCard(label: '次要\n文本图标', color: colorScheme.onSecondary, textColor: colorScheme.secondary),
              ColorCard(label: '次要\n容器', color: colorScheme.secondaryContainer, textColor: colorScheme.onSecondaryContainer),
              ColorCard(label: '次要容器\n文本图标', color: colorScheme.onSecondaryContainer, textColor: colorScheme.secondaryContainer),
              ColorCard(label: '辅助', color: colorScheme.tertiary, textColor: colorScheme.onTertiary),
              ColorCard(label: '辅助\n文本图标', color: colorScheme.onTertiary, textColor: colorScheme.tertiary),
              ColorCard(label: '辅助\n容器', color: colorScheme.tertiaryContainer, textColor: colorScheme.onTertiaryContainer),
              ColorCard(label: '辅助容器\n文本图标', color: colorScheme.onTertiaryContainer, textColor: colorScheme.tertiaryContainer),
              ColorCard(label: '错误', color: colorScheme.error, textColor: colorScheme.onError),
              ColorCard(label: '错误\n文本图标', color: colorScheme.onError, textColor: colorScheme.error),
              ColorCard(label: '错误\n容器', color: colorScheme.errorContainer, textColor: colorScheme.onErrorContainer),
              ColorCard(label: '错误容器\n文本图标', color: colorScheme.onErrorContainer, textColor: colorScheme.errorContainer),
              ColorCard(label: '背景$backTooHigh', color: colorScheme.background, textColor: colorScheme.onBackground),
              ColorCard(label: '背景\n文本图标', color: colorScheme.onBackground, textColor: colorScheme.background),
              ColorCard(label: '前景$surfaceTooHigh', color: colorScheme.surface, textColor: colorScheme.onSurface),
              ColorCard(label: '前景\n文本图标', color: colorScheme.onSurface, textColor: colorScheme.surface),
              ColorCard(label: '前景变体', color: colorScheme.surfaceVariant, textColor: colorScheme.onSurfaceVariant),
              ColorCard(label: '前景变体\n文本图标', color: colorScheme.onSurfaceVariant, textColor: colorScheme.surfaceVariant),
              ColorCard(label: '轮廓', color: colorScheme.outline, textColor: colorScheme.background),
              ColorCard(label: '阴影', color: colorScheme.shadow, textColor: _onColor(colorScheme.shadow, background)),
              ColorCard(label: '前景反色', color: colorScheme.inverseSurface, textColor: colorScheme.onInverseSurface),
              ColorCard(label: '前景反色\n文本图标', color: colorScheme.onInverseSurface, textColor: colorScheme.inverseSurface),
              ColorCard(label: '主要配色\n反色', color: colorScheme.inversePrimary, textColor: colorScheme.primary),
            ],
          ),
        ],
      ),
    );
  }
}
