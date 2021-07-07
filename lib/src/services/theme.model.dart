import 'package:flutter/material.dart';

import 'preference.service.dart';

class ThemeModel extends ChangeNotifier {
  final _darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.grey,
    primaryColor: Colors.black,
    backgroundColor: const Color(0xFF212121),
    accentColor: Colors.white,
    accentIconTheme: IconThemeData(color: Colors.black),
    dividerColor: Colors.black12,
  );

  final _lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.grey,
    primaryColor: Colors.white,
    backgroundColor: const Color(0xFFE5E5E5),
    accentColor: Colors.black,
    accentIconTheme: IconThemeData(color: Colors.white),
    dividerColor: Colors.white54,
  );

  ThemeData? _theme;
  ThemeData get theme => _theme!;

  ThemeModel() {
    _theme = PreferenceService.darkMode ? _darkTheme : _lightTheme;
  }

  bool get darkMode => PreferenceService.darkMode;
  set darkMode(bool v) {
    if (darkMode != v) {
      _theme = v ? _darkTheme : _lightTheme;
      PreferenceService.darkMode = v;
      notifyListeners();
    }
  }
}
