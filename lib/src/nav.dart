import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'pages.dart';
import 'services.dart';
import 'models.dart';

class Nav {
  static Future<void> _showZekrListPage(
    BuildContext context, {
    required String title,
    required List<Zeker> items,
    bool showFav = true,
  }) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ZekrListPage(
          title: title,
          items: items,
          showFav: showFav,
        ),
      ),
    );
  }

  static Future<void> showCategory(BuildContext context, int category) async {
    final c = DataService.categories.firstWhere((x) => x.id == category);
    final items = DataService.getCategory(c.id);

    await _showZekrListPage(
      context,
      title: c.name,
      items: items,
      showFav: true,
    );
  }

  static Future<void> showFav(BuildContext context) async {
    final items = DataService.getFavoriteList();
    await _showZekrListPage(
      context,
      title: AppLocalizations.of(context)!.favorites,
      items: items,
      showFav: false,
    );
  }

  static Future<void> showSettings(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => SettingsPage()),
    );
  }

  static Future<void> showLanguage(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => LanguagePage()),
    );
  }
}
