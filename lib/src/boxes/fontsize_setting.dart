import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../constants.dart';
import 'settings.dart';

class FontSizeSetting {
  static const KEY = 'fontsize';
  static FontSizeSetting? _instance;
  static FontSizeSetting get instance => _instance ??= FontSizeSetting._();
  factory FontSizeSetting() => instance;
  FontSizeSetting._();

  ValueListenable<Box> listen() => Settings.box.listenable(keys: [KEY]);

  double get value => Settings.box.get(KEY, defaultValue: FONTSIZE_DEFAULT);

  void _setValue(double v) {
    if (v >= FONTSIZE_MIN && v <= FONTSIZE_MAX) {
      Settings.box.put(KEY, v);
    }
  }

  VoidCallback? get incrementCallback =>
      !(value < FONTSIZE_MAX) ? null : () => _setValue(value + 1);

  VoidCallback? get decrementCallback =>
      !(value > FONTSIZE_MIN) ? null : () => _setValue(value - 1);
}
