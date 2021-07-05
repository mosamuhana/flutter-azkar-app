import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets.dart';
import '../services.dart';
import '../services/countdown.model.dart';

class CategoryPage extends StatefulWidget {
  final int category;

  CategoryPage({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    final category =
        DataService.categories.firstWhere((x) => x.id == widget.category);
    return WillPopScope(
      onWillPop: () async => true,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(category.name),
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

    final list = DataService.getCategory(this.widget.category);
    return ListView.builder(
      padding: const EdgeInsets.all(18),
      itemCount: list.length,
      itemBuilder: (_, int index) {
        final z = list[index];
        return ZekerCard(
          id: z.id,
          order: index + 1,
          onFavPressed: () async {
            if (await DataService.favorite(z.id, !z.favorited)) {
              setState(() {});
            }
          },
          onCountDownPressed: () async {
            await countdown.decrement(z);
            setState(() {});
          },
        );
      },
    );
  }
}
