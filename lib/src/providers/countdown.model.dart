import 'package:flutter/material.dart';

import '../services.dart';
import '../models.dart';

class CountdownModel extends ChangeNotifier {
  Map<int, int> _data = PreferenceService.countdown;

  Future<void> decrement(Zeker z) async {
    int n = get(z);
    if (n > 0) {
      n--;
      _data[z.id] = n;
      await _notify();
    }
  }

  int get(Zeker z) {
    return _data.containsKey(z.id) ? (_data[z.id] ?? z.count) : z.count;
  }

  Future<void> reset() async {
    _data.clear();
    await _notify();
  }

  Future<void> _notify() async {
    PreferenceService.countdown = _data;
    notifyListeners();
  }
}