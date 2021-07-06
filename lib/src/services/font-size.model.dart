import 'package:flutter/material.dart';

import 'preference.service.dart';
import '../constants.dart';

class FontSizeModel extends ValueNotifier<double> {
  FontSizeModel() : super(PreferenceService.fontSize);

  @override
  double get value => super.value;

  @override
  set value(double value) => super.value = value;

  void increment() {
    var n = value + 1;
    if (n < FONTSIZE_MAX) {
      value = n;
      _save();
    }
  }

  void decrement() {
    var n = value - 1;
    if (n > FONTSIZE_MIN) {
      value = n;
      _save();
    }
  }

  void _save() {
    PreferenceService.fontSize = value;
  }
}
