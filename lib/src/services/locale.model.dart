import 'package:flutter/material.dart';

import 'preference.service.dart';

class LocaleModel extends ValueNotifier<Locale> {
  LocaleModel() : super(Locale(PreferenceService.locale));

  String get name => value.languageCode;

  set name(String code) {
    if (code == 'ar') {
      _change('ar');
    } else if (code == 'en') {
      _change('en');
    }
  }

  void _change(String code) {
    this.value = Locale(code);
    PreferenceService.locale = code;
    notifyListeners();
  }

  get direction => name == 'ar' ? TextDirection.rtl : TextDirection.ltr;
}
