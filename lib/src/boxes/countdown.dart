import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models.dart';

const _name = 'countdown';

class Countdown {
  Countdown._();

  static Box<int>? _box;
  static Box<int> get box => _box ??= Hive.box<int>(_name);

  static int get(Zeker z) => box.get(z.id, defaultValue: z.count)!;

  static void decrement(Zeker z) {
    int n = get(z);
    if (n > 0) {
      n--;
      box.put(z.id, n);
    }
  }

  static void reset() => box.clear();

  static bool get changed => box.keys.length > 0;

  static ValueListenable<Box<int>> listen(int id) => box.listenable(keys: [id]);
  static ValueListenable<Box<int>> listenChanges() => box.listenable();

  static VoidCallback? get resetCallback => !changed ? null : reset;
}
