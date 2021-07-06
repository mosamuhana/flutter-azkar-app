import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets.dart';
import '../services.dart';
import '../models.dart';
import '../services/countdown.model.dart';

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
            //centerTitle: true,
            title: Text(this.widget.title),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextToolbar(),
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
    final items = widget.items;
    return ListView.builder(
      padding: const EdgeInsets.all(18),
      itemCount: items.length,
      itemBuilder: (_, int index) {
        final z = items[index];
        return ZekerCard(
          id: z.id,
          order: index + 1,
          onFavPressed: widget.showFav ? () => onFavPressed(z) : null,
          onCountDownPressed: () async {
            await countdown.decrement(z);
            setState(() {});
          },
        );
      },
    );
  }

  Future<void> onFavPressed(Zeker z) async {
    if (await DataService.favorite(z.id, !z.favorited)) {
      setState(() {});
    }
  }
}
