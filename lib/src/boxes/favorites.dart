import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

const _name = 'favorites';

class Favorites {
  Favorites._();

  static Box<int>? _box;
  static Box<int> get box => _box ??= Hive.box<int>(_name);

  static bool isFavorited(int id) => box.containsKey(id);

  static bool toggle(int id) {
    if (isFavorited(id)) {
      return unfavorite(id);
    } else {
      return favorite(id);
    }
  }

  static bool favorite(int id) {
    if (!box.containsKey(id)) {
      box.put(id, id);
      return true;
    }
    return false;
  }

  static bool unfavorite(int id) {
    if (box.containsKey(id)) {
      box.delete(id);
      return true;
    }
    return false;
  }

  static List<int> get list => box.values.toList();
}
