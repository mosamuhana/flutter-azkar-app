import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../constants.dart';
import 'settings.dart';

class LocaleSetting {
  static const KEY = 'locale';
  static LocaleSetting? _instance;
  static LocaleSetting get instance => _instance ??= LocaleSetting._();
  factory LocaleSetting() => instance;
  LocaleSetting._();

  bool _init = false;

  ValueListenable<Box> listen() => Settings.box.listenable(keys: [KEY]);

  Locale? _locale;
  Locale get locale => _locale ??= Locale(value);

  SingletonFlutterWindow? get _window {
    final win = WidgetsBinding.instance?.window;
    if (!_init) {
      win?.onLocaleChanged = () {
        print('[onLocaleChanged] locale: ${win.locale}');
        _setValue(win.locale.languageCode);
      };
      _init = true;
    }
    return win;
  }

  String get value => Settings.box
      .get(KEY, defaultValue: _window?.locale.languageCode ?? LOCALE_DEFAULT);
  set value(String v) => _setValue(v);

  void _setValue(String code) {
    if (code == 'ar' || code == 'en') {
      _locale = Locale(code);
      Settings.box.put(KEY, code);
    }
  }

  get direction => value == 'ar' ? TextDirection.rtl : TextDirection.ltr;
}
