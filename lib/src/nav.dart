import 'package:flutter/material.dart';

import 'pages.dart';

class Nav {
  static Future<void> showCategory(
    BuildContext context,
    int category,
  ) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CategoryPage(category: category),
      ),
    );
  }

  static Future<void> showFav(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FavoritesPage(),
      ),
    );
  }
}
