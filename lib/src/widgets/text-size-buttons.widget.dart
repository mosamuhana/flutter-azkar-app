import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/font-size.model.dart';
import '../services/countdown.model.dart';

class TextSizeButtons extends StatelessWidget {
  final double splashRadius = 20;
  const TextSizeButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Consumer<FontSizeModel>(
          builder: (_, appModel, __) {
            return IconButton(
              tooltip: 'Increase Font Size',
              icon: Icon(Icons.add),
              onPressed: () => appModel.increment(),
              splashRadius: splashRadius,
            );
          },
        ),
        SizedBox(width: 5),
        Consumer<FontSizeModel>(
          builder: (_, appModel, __) {
            return IconButton(
              tooltip: 'Decrease Font Size',
              icon: Icon(Icons.remove),
              onPressed: () => appModel.decrement(),
              splashRadius: splashRadius,
            );
          },
        ),
        SizedBox(width: 5),
        Consumer<CountdownModel>(
          builder: (_, m, __) {
            return IconButton(
              tooltip: 'Reset',
              icon: Icon(Icons.restore),
              onPressed: () => m.reset(),
              splashRadius: splashRadius,
            );
          },
        ),
      ],
    );
  }
}
