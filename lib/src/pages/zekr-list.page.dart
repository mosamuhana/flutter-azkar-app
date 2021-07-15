import 'package:flutter/material.dart';

import '../widgets.dart';
import '../models.dart';
import '../boxes.dart';

class ZekrListPage extends StatefulWidget {
  final String title;
  final List<Zeker> items;
  final bool showFav;

  ZekrListPage({
    Key? key,
    required this.title,
    required this.items,
    this.showFav = true,
  }) : super(key: key);

  @override
  _ZekrListPageState createState() => _ZekrListPageState();
}

class _ZekrListPageState extends State<ZekrListPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            //title: Text(this.widget.title),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextToolbar(),
              ),
            ],
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22),
                ),
              ),
              Expanded(child: _buildList()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildList() {
    final items = widget.items;
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
      itemCount: items.length,
      itemBuilder: (_, int index) {
        final z = items[index];
        return ZekerCard(
          id: z.id,
          order: index + 1,
          onFavPressed: widget.showFav ? () => onFavPressed(z) : null,
          onCountDownPressed: () async {
            Countdown.decrement(z);
            setState(() {});
          },
        );
      },
    );
  }

  void onFavPressed(Zeker z) {
    Favorites.toggle(z.id);
    setState(() {});
  }
}
