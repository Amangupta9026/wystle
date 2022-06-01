import 'package:flutter/material.dart';

enum ThemeOption { light, dark, system, trueBlack }

extension ThemeOptionUtils on ThemeOption {
  ThemeMode get themeMode {
    switch (this) {
      case ThemeOption.light:
        return ThemeMode.light;
      case ThemeOption.dark:
      case ThemeOption.trueBlack:
        return ThemeMode.dark;
      case ThemeOption.system:
        return ThemeMode.system;
    }
  }
}
