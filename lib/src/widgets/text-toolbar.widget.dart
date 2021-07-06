import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../services/font-size.model.dart';
import '../services/countdown.model.dart';

class TextToolbar extends StatelessWidget {
  final double splashRadius = 20;
  const TextToolbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Consumer<FontSizeModel>(
          builder: (_, fontSizeModel, __) {
            return IconButton(
              tooltip: t.incrementFontSize,
              icon: Icon(Icons.add),
              onPressed: () => fontSizeModel.increment(),
              splashRadius: splashRadius,
            );
          },
        ),
        SizedBox(width: 5),
        Consumer<FontSizeModel>(
          builder: (_, dontSizeModel, __) {
            return IconButton(
              tooltip: t.decrementFontSize,
              icon: Icon(Icons.remove),
              onPressed: () => dontSizeModel.decrement(),
              splashRadius: splashRadius,
            );
          },
        ),
        SizedBox(width: 5),
        Consumer<CountdownModel>(
          builder: (_, countdownModel, __) {
            return IconButton(
              tooltip: t.resetCounter,
              icon: Icon(Icons.restore),
              onPressed: () => countdownModel.reset(),
              splashRadius: splashRadius,
            );
          },
        ),
      ],
    );
  }
}
