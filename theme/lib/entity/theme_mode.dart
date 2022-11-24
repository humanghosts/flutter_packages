import 'package:flutter/material.dart';

extension ThemeModeExtension on ThemeMode {
  String get title {
    switch (this) {
      case ThemeMode.system:
        return "跟随系统";
      case ThemeMode.light:
        return "浅色模式";
      case ThemeMode.dark:
        return "深色模式";
    }
  }

  Widget get icon {
    switch (this) {
      case ThemeMode.system:
        return const Icon(Icons.phone_iphone_outlined);
      case ThemeMode.light:
        return const Icon(Icons.light_mode_outlined);
      case ThemeMode.dark:
        return const Icon(Icons.dark_mode_outlined);
    }
  }
}
