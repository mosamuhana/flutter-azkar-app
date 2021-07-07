import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../extensions.dart';

import '../constants.dart';

const FAV_KEY = 'FAV';
const FONT_SIZE_KEY = 'FONT_SIZE';
const COUNTDOWN_KEY = 'COUNTDOWN';
const LOCALE_KEY = 'LOCALE';
const DARK_MODE_KEY = 'DARK_MODE';
const THEME_MODE_KEY = 'THEME_MODE';

class PreferenceService {
  static late SharedPreferences _instance;

  PreferenceService._();

  static Future<void> init() async {
    _instance = await SharedPreferences.getInstance();
  }

  static SharedPreferences get instance => _instance;

  static List<int> get favorites {
    final favList = _instance.getString(FAV_KEY) ?? '';
    if (favList.length == 0) return <int>[];
    return favList.split(',').map((x) => int.parse(x)).toList();
  }

  static set favorites(List<int> list) {
    _instance.setString(FAV_KEY, list.join(','));
  }

  static double get fontSize {
    return _instance.getDouble(FONT_SIZE_KEY) ?? FONTSIZE_DEFAULT;
  }

  static set fontSize(double value) {
    _instance.setDouble(FONT_SIZE_KEY, value);
  }

  static Map<int, int> get countdown {
    final value = _instance.getString(COUNTDOWN_KEY);
    if (value == null) {
      return Map<int, int>();
    }
    final rawData = jsonDecode(value) as Map<String, dynamic>;
    final data = rawData
        .map((key, value) => MapEntry<int, int>(int.parse(key), value as int));
    return data;
  }

  static set countdown(Map<int, int> value) {
    final data =
        value.map((key, value) => MapEntry<String, int>('$key', value));
    _instance.setString(COUNTDOWN_KEY, jsonEncode(data));
  }

  static String get locale {
    return _instance.getString(LOCALE_KEY) ?? LOCALE_DEFAULT;
  }

  static set locale(String value) {
    _instance.setString(LOCALE_KEY, value);
  }

  static ThemeMode get themeMode {
    var mode = _instance.getString(DARK_MODE_KEY);
    if (mode != null) {
      //final tm = mode.toThemeMode();
      final tm = ThemeModeExtensions.parse(mode);
      if (tm != null) {
        return tm;
      }
    }
    return ThemeMode.system;
  }

  static set themeMode(ThemeMode value) {
    _instance.setString(DARK_MODE_KEY, value.asString());
  }
}
