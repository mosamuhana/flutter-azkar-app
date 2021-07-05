import 'package:flutter/material.dart';

import 'preference.service.dart';
import '../constants.dart';

class FontSizeModel extends ChangeNotifier {
  double _value = FONTSIZE_DEFAULT;

  FontSizeModel() : super() {
    _value = PreferenceService.getFontSize();
  }

  double get value => _value;

  void increment() {
    var n = _value + 1;
    if (n < FONTSIZE_MAX) {
      _value = n;
      _notifyListeners();
    }
  }

  void decrement() {
    var n = _value - 1;
    if (n > FONTSIZE_MIN) {
      _value = n;
      _notifyListeners();
    }
  }

  void _notifyListeners() {
    PreferenceService.setFontSize(_value);
    notifyListeners();
  }
}
