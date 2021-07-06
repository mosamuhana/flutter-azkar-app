import 'package:flutter/material.dart';

import 'preference.service.dart';
import '../styles/theme.dart';

class DarkModeModel extends ValueNotifier<bool> {
  DarkModeModel() : super(PreferenceService.darkMode);

  @override
  bool get value => super.value;

  @override
  set value(bool v) {
    super.value = v;
    PreferenceService.darkMode = v;
    statusBarStyle(v);
  }
}
