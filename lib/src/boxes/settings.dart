import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

const _name = 'settings';
Box? _settingsBox;

class Settings {
  Settings._();

  static String get name => name;

  static Box get box => _settingsBox ??= Hive.box(_name);

  static ValueListenable<Box> listen({List<String>? keys}) =>
      box.listenable(keys: keys);
}
