import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../services.dart';
import '../nav.dart';
import '../models.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(t.azkar),
          actions: [
            IconButton(
              tooltip: t.favorites,
              icon: Icon(Icons.favorite),
              splashRadius: 20,
              onPressed: () => Nav.showFav(context),
            ),
            IconButton(
              tooltip: t.settings,
              icon: Icon(Icons.settings),
              splashRadius: 20,
              onPressed: () => Nav.showSettings(context),
            ),
          ],
        ),
        body: _buildList(context),
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    final categories = DataService.categories;
    return ListView.builder(
      padding: EdgeInsets.all(20),
      itemCount: categories.length,
      itemBuilder: (context, index) => _buildItem(context, categories[index]),
    );
  }

  Widget _buildItem(BuildContext context, Category category) {
    return Card(
      elevation: 0,
      //color: AppColors.primaryColor,
      color: Theme.of(context).primaryColor.withAlpha(150),
      child: ListTile(
        title: Text(
          category.name,
          style: TextStyle(fontSize: 18),
        ),
        onTap: () => Nav.showCategory(context, category.id),
        //tileColor: Colors.blueGrey,
      ),
    );
  }
}
