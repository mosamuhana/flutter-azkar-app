import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:flutter/services.dart';

import '../models.dart';
import 'preference.service.dart';

const CATEGORIES_KEY = 'categories';
const LIST_KEY = 'list';
const DATA_FILE = 'assets/data_min.json';

class DataService {
  static List<Category> _categories = [];
  static List<Zeker> _list = [];
  static bool _init = false;

  DataService._();

  static Future<void> init() async {
    if (_init) return;
    final content = await rootBundle.loadString(DATA_FILE);
    final data = jsonDecode(content) as Map<String, dynamic>;
    final categories = data[CATEGORIES_KEY] as List<dynamic>;
    final azkar = data[LIST_KEY] as List<dynamic>;

    _categories = categories
        .map((obj) => Category(id: obj['id'], name: obj['name']))
        .toList();

    final favs = PreferenceService.getFavorites();

    _list = azkar.map((data) {
      final id = data['id'] as int;
      return Zeker(
        id: id,
        order: data['order'],
        category: data['category'],
        count: data['count'],
        header: data.containsKey('header') ? data['header'] : '',
        content: data['content'],
        comment: data.containsKey('comment') ? data['comment'] : '',
        favorited: favs.indexOf(id) != -1,
      );
    }).toList();
    _init = true;
  }

  static List<Category> get categories => _categories;
  static List<Zeker> get list => _list;

  static Zeker getZeker(int id) => _list.firstWhere((x) => x.id == id);

  static List<Zeker> getCategory(int categoryId) =>
      _list.where((x) => x.category == categoryId).toList();

  static List<Zeker> getFavoriteList() =>
      _list.where((x) => x.favorited).toList();

  static Future<bool> favorite(int id, bool favorited) async {
    final zeker = _list.firstWhere((x) => x.id == id);
    if (zeker.favorited == favorited) return false;
    zeker.favorited = favorited;
    await PreferenceService.setFavorites(
      _list.where((x) => x.favorited).map((x) => x.id).toList(),
    );
    return true;
  }
}