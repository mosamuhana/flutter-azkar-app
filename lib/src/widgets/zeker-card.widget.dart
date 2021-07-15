import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../services.dart';
import '../models.dart';
import '../boxes.dart';

const HEADER_HEIGHT = 40.0;

class ZekerCard extends StatefulWidget {
  final int id;
  final int order;
  final VoidCallback? onFavPressed;
  final VoidCallback? onCountDownPressed;

  ZekerCard({
    Key? key,
    required this.id,
    required this.order,
    this.onFavPressed,
    this.onCountDownPressed,
  }) : super(key: key);

  @override
  ZekerCardState createState() =>
      ZekerCardState(model: DataService.getItem(id));
}

class ZekerCardState extends State<ZekerCard> {
  final FontSizeSetting fontSizeSetting = FontSizeSetting();
  final Zeker model;

  ZekerCardState({required this.model}) : super();

  bool get isDark => ThemeSetting.instance.isDark;
  Color get color => isDark ? Colors.white : Colors.black;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Card(
        margin: EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _header,
            Divider(thickness: .3, height: 3, color: Colors.grey),
            _content,
          ],
        ),
      ),
    );
  }

  Widget get _content {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
      child: ValueListenableBuilder(
        valueListenable: fontSizeSetting.listen(),
        builder: (___, __, _) {
          return Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (model.header != null)
                Text(
                  model.header!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: fontSizeSetting.value,
                  ),
                  textAlign: TextAlign.right,
                ),
              Text(
                model.content,
                style: TextStyle(fontSize: fontSizeSetting.value),
              ),
              SizedBox(height: 15),
              if (model.comment != null)
                Text(
                  model.comment!,
                  style: TextStyle(
                    fontSize: fontSizeSetting.value - 4,
                    color: isDark ? Colors.yellow : Colors.indigo,
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget get _header {
    return Container(
      height: HEADER_HEIGHT,
      child: Row(
        children: [
          Container(
            width: HEADER_HEIGHT,
            height: HEADER_HEIGHT,
            alignment: Alignment.center,
            child: Text(
              '${this.widget.order}',
              style: TextStyle(fontSize: 15, color: color),
            ),
          ),
          Expanded(child: _counter),
          _favIcon,
        ],
      ),
    );
  }

  Widget get _favIcon {
    Widget? child;

    if (this.widget.onFavPressed != null) {
      child = ValueListenableBuilder(
        valueListenable: Favorites.box.listenable(keys: [model.id]),
        builder: (ctx, Box<int> box, _) {
          final favorited = Favorites.isFavorited(model.id);
          return IconButton(
            onPressed: this.widget.onFavPressed,
            icon: Icon(
              favorited ? Icons.favorite : Icons.favorite_border,
              color: favorited ? Colors.red : color,
              size: HEADER_HEIGHT / 2,
            ),
            splashRadius: 20,
          );
        },
      );
    }

    return Container(
      width: HEADER_HEIGHT,
      height: HEADER_HEIGHT,
      alignment: Alignment.center,
      child: child,
    );
  }

  Widget get _counter {
    return Container(
      height: HEADER_HEIGHT,
      width: 200,
      child: ValueListenableBuilder(
        valueListenable: Countdown.box.listenable(keys: [model.id]),
        builder: (__, Box<int> box, _) {
          final countdown = Countdown.get(model);
          final isActive = countdown > 0;
          return TextButton(
            onPressed: isActive ? this.widget.onCountDownPressed : null,
            child: Text(
              '$countdown / ${model.count}',
              style: TextStyle(fontSize: 20, color: color),
            ),
          );
        },
      ),
    );
  }
}
