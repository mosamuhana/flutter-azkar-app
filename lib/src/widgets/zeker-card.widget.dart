import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services.dart';
import '../models.dart';
import '../services/font-size.model.dart';
import '../services/countdown.model.dart';

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
      ZekerCardState(model: DataService.getZeker(id));
}

class ZekerCardState extends State<ZekerCard> {
  final Zeker model;

  ZekerCardState({required this.model}) : super();

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
      child: Consumer<FontSizeModel>(builder: (_, fontSizeModel, __) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (model.header != null)
              Text(
                model.header!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: fontSizeModel.value,
                ),
                textAlign: TextAlign.right,
              ),
            Text(
              model.content,
              style: TextStyle(fontSize: fontSizeModel.value),
            ),
            SizedBox(height: 15),
            if (model.comment != null)
              Text(
                model.comment!,
                style: TextStyle(
                  fontSize: fontSizeModel.value - 4,
                  color: Colors.indigo,
                ),
              ),
          ],
        );
      }),
    );
  }

  Widget get _header {
    return Container(
      height: HEADER_HEIGHT,
      //color: Colors.blueAccent,
      color: Theme.of(context).primaryColor.withAlpha(150),
      child: Row(
        children: [
          Container(
            width: HEADER_HEIGHT,
            height: HEADER_HEIGHT,
            alignment: Alignment.center,
            child: Text('${this.widget.order}', style: _indexTextStyle),
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
      child = IconButton(
        onPressed: this.widget.onFavPressed,
        icon: Icon(
          model.favorited ? Icons.favorite : Icons.favorite_border,
          color: model.favorited ? Colors.red : Colors.white,
          size: HEADER_HEIGHT / 2,
        ),
        splashRadius: 20,
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
    //final countdown = DataService.getCountdown(model);
    //final _cd = Provider.of<CountdownModel>(context);
    //final countdown = _cd.get(model);
    //final isActive = countdown > 0;

    return Container(
      height: HEADER_HEIGHT,
      width: 200,
      child: Consumer<CountdownModel>(
        builder: (__, m, _) {
          final countdown = m.get(model);
          final isActive = countdown > 0;
          return TextButton(
            onPressed: isActive ? this.widget.onCountDownPressed : null,
            child:
                Text('$countdown / ${model.count}', style: _counterTextStyle),
          );
        },
      ),
      /*
      child: TextButton(
        onPressed: isActive ? this.widget.onCountDownPressed : null,
        child: Text('$countdown / ${model.count}', style: _counterTextStyle),
      ),
      */
    );
  }

  final _counterTextStyle = TextStyle(fontSize: 20, color: Colors.white);
  final _indexTextStyle = TextStyle(fontSize: 15, color: Colors.white);
}
