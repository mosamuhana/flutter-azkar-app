import 'dart:ui';
import 'package:flutter/material.dart';

class UI {
  UI._();

  static SingletonFlutterWindow? _window;
  static SingletonFlutterWindow get window =>
      _window ??= WidgetsBinding.instance!.window;

  static final List<ValueChanged<Brightness>> _platformBrightnessList = [];
  static final List<ValueChanged<Locale>> _localeChangedList = [];

  static void _onPlatformBrightnessChanged() {
    final brightness = window.platformBrightness;
    for (var cb in _platformBrightnessList) cb(brightness);
  }

  static void addPlatformBrightnessChanged(ValueChanged<Brightness> cb) {
    if (window.onPlatformBrightnessChanged == null) {
      window.onPlatformBrightnessChanged = _onPlatformBrightnessChanged;
    }
    if (_platformBrightnessList.indexOf(cb) == -1) {
      _platformBrightnessList.add(cb);
    }
  }

  static void removePlatformBrightnessChanged(ValueChanged<Brightness> cb) {
    if (window.onPlatformBrightnessChanged == null) return;
    if (_platformBrightnessList.indexOf(cb) != -1) {
      _platformBrightnessList.removeWhere((x) => x == cb);
    }
    if (_platformBrightnessList.length == 0)
      window.onPlatformBrightnessChanged = null;
  }

  static void _onLocaleChanged() {
    final v = window.locale;
    for (var cb in _localeChangedList) cb(v);
  }

  static void addLocaleChanged(ValueChanged<Locale> cb) {
    if (window.onLocaleChanged == null) {
      window.onLocaleChanged = _onLocaleChanged;
    }
    if (_localeChangedList.indexOf(cb) == -1) {
      _localeChangedList.add(cb);
    }
  }

  static void removeLocaleChanged(ValueChanged<Locale> cb) {
    if (window.onLocaleChanged == null) return;
    if (_localeChangedList.indexOf(cb) != -1) {
      _localeChangedList.removeWhere((x) => x == cb);
    }
    if (_localeChangedList.length == 0) window.onLocaleChanged = null;
  }

  static void clean() {
    window.onPlatformBrightnessChanged = null;
    window.onLocaleChanged = null;
  }
}
