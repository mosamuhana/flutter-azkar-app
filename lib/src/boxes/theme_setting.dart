import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'settings.dart';

class ThemeSetting {
  static const KEY = 'theme';
  static ThemeSetting? _instance;
  static ThemeSetting get instance => _instance ??= ThemeSetting._();
  factory ThemeSetting() => instance;
  ThemeSetting._();

  bool _init = false;

  ValueListenable<Box> listen() => Settings.box.listenable(keys: [KEY]);

  ThemeData? _theme;
  ThemeMode? _themeMode;

  ThemeMode get themeMode {
    if (_themeMode == null) {
      bool? res = Settings.box.get(KEY, defaultValue: null);
      if (res == null) {
        _themeMode = ThemeMode.system;
      } else {
        _themeMode = res ? ThemeMode.dark : ThemeMode.light;
      }
    }
    return _themeMode!;
  }

  set themeMode(ThemeMode v) {
    if (_themeMode != v) {
      _setThemeMode(v);
    }
  }

  ThemeData get theme {
    if (_theme == null) {
      _setThemeMode(themeMode);
    }
    return _theme!;
  }

  SingletonFlutterWindow? get _window {
    final win = WidgetsBinding.instance?.window;
    if (!_init) {
      win?.onPlatformBrightnessChanged = () {
        if (themeMode == ThemeMode.system) {
          _setThemeMode(themeMode);
        }
      };
      _init = true;
    }
    return win;
  }

  bool get isDark {
    if (themeMode == ThemeMode.system) {
      return _window?.platformBrightness == Brightness.dark;
    }
    return themeMode == ThemeMode.dark;
  }

  void _setThemeMode(ThemeMode v) {
    bool? d = v == ThemeMode.system ? null : v == ThemeMode.dark;
    Settings.box.put(KEY, d);
    if (v == ThemeMode.system) {
      Settings.box.put(KEY, null);
    } else {
      Settings.box.put(KEY, v == ThemeMode.dark);
    }
    _themeMode = v;
    final _isDark = this.isDark;
    _theme = _isDark ? _darkTheme : _lightTheme;
    _statusBarStyle(_isDark);
  }

  void _statusBarStyle(bool isDark) {
    final brightness = isDark ? Brightness.dark : Brightness.light;
    final isLight = brightness == Brightness.light;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: isLight ? Colors.white : Colors.black,
      statusBarBrightness: brightness,
      statusBarIconBrightness: isLight ? Brightness.dark : Brightness.light,
    ));
  }
}

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
