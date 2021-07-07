import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../services.dart';

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

  late SingletonFlutterWindow _window;
  ThemeData? _theme;
  ThemeData get theme => _theme!;

  late ThemeMode _themeMode;

  bool get isDark {
    if (_themeMode == ThemeMode.system) {
      return _window.platformBrightness == Brightness.dark;
    }
    return _themeMode == ThemeMode.dark;
  }

  ThemeModel() {
    _window = WidgetsBinding.instance!.window;
    _window.onPlatformBrightnessChanged = () {
      if (_themeMode == ThemeMode.system) {
        print('platformBrightness: ${_window.platformBrightness}');
        _setThemeMode(_themeMode);
      }
    };
    _themeMode = PreferenceService.themeMode;
    _setThemeMode(PreferenceService.themeMode);
  }

  ThemeMode get themeMode => _themeMode;
  set themeMode(ThemeMode v) {
    if (_themeMode != v) {
      _setThemeMode(v);
    }
  }

  void _setThemeMode(ThemeMode v) {
    _themeMode = v;
    PreferenceService.themeMode = _themeMode;
    final isDark = this.isDark;
    _theme = isDark ? _darkTheme : _lightTheme;
    statusBarStyle(isDark);
    notifyListeners();
  }

  static void statusBarStyle(bool isDark) {
    final brightness = isDark ? Brightness.dark : Brightness.light;
    final isLight = brightness == Brightness.light;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: isLight ? Colors.white : Colors.black,
      statusBarBrightness: brightness,
      statusBarIconBrightness: isLight ? Brightness.dark : Brightness.light,
    ));
  }
}
