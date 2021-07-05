import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets.dart';
import '../services.dart';
import '../services/countdown.model.dart';

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('المفضلة'),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextSizeButtons(),
              ),
            ],
          ),
          body: Container(
            child: _buildList(context),
          ),
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    final countdown = Provider.of<CountdownModel>(context);
    final list = DataService.getFavoriteList();
    return ListView.builder(
      padding: const EdgeInsets.all(18),
      itemCount: list.length,
      itemBuilder: (_, int index) {
        final z = list[index];
        return ZekerCard(
          id: z.id,
          order: index + 1,
          onCountDownPressed: () {
            countdown.decrement(z);
            setState(() {});
          },
        );
      },
    );
  }
}
