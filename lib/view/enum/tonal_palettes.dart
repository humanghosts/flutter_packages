/// Enum to indicate which palette we are using.
///
/// Used to show which TonalPalette a hovered color belongs to.
/// Tucking this ChangeNotifier into the ThemeController is not really kosher
/// it should be in its own Provider/Riverpod or Inherited widget.
///
enum TonalPalettes {
  primary,
  secondary,
  tertiary,
  error,
  neutral,
  neutralVariant,
}
