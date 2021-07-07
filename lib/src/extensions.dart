import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension ThemeModeExtensions on ThemeMode {
  String asString() {
    switch (this) {
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.light:
        return 'light';
      default:
        return 'system';
    }
  }

  String getLocalizedName([AppLocalizations? t]) {
    if (t != null) {
      switch (this) {
        case ThemeMode.dark:
          return t.dark;
        case ThemeMode.light:
          return t.light;
        default:
          return t.system;
      }
    }
    switch (this) {
      case ThemeMode.dark:
        return 'Dark';
      case ThemeMode.light:
        return 'Light';
      default:
        return 'System';
    }
  }

  static ThemeMode? parse(String? value) {
    if (value != null) {
      switch (value) {
        case 'dark':
          return ThemeMode.dark;
        case 'light':
          return ThemeMode.light;
        case 'system':
          return ThemeMode.system;
      }
    }
    return null;
  }
}
