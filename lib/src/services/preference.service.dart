import 'dart:convert';
import 'dart:async' show Future;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

const FAV_KEY = 'FAV';
const FONT_SIZE_KEY = 'FONT_SIZE';
const COUNTDOWN_KEY = 'COUNTDOWN';

class PreferenceService {
  static SharedPreferences? _instance;

  PreferenceService._();

  static Future<void> init() async {
    if (_instance == null) {
      _instance = await SharedPreferences.getInstance();
    }
  }

  static SharedPreferences get instance => _instance!;

  static List<int> getFavorites() {
    final favList = _instance!.getString(FAV_KEY) ?? '';
    if (favList.length == 0) return [];
    return favList.split(',').map((x) => int.parse(x)).toList();
  }

  static Future<void> setFavorites(List<int> list) async {
    await _instance!.setString(FAV_KEY, list.join(','));
  }

  static double getFontSize() {
    return _instance!.getDouble(FONT_SIZE_KEY) ?? FONTSIZE_DEFAULT;
  }

  static Future<void> setFontSize(double value) async {
    await _instance!.setDouble(FONT_SIZE_KEY, value);
  }

  static Map<int, int> getCountdown() {
    final value = _instance!.getString(COUNTDOWN_KEY);
    if (value == null) {
      return Map<int, int>();
    }
    final rawData = jsonDecode(value) as Map<String, dynamic>;
    final data = rawData
        .map((key, value) => MapEntry<int, int>(int.parse(key), value as int));
    return data;
  }

  static Future<void> setCountdown(Map<int, int> value) async {
    final data =
        value.map((key, value) => MapEntry<String, int>('$key', value));
    await _instance!.setString(COUNTDOWN_KEY, jsonEncode(data));
  }
}
