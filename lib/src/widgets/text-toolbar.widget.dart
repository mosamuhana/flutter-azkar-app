import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../boxes.dart';

class TextToolbar extends StatelessWidget {
  final FontSizeSetting fontSizeSetting = FontSizeSetting();

  final double splashRadius = 20;
  TextToolbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ValueListenableBuilder(
          valueListenable: fontSizeSetting.listen(),
          builder: (___, __, _) {
            return IconButton(
              tooltip: t.incrementFontSize,
              icon: Icon(Icons.add),
              onPressed: fontSizeSetting.incrementCallback,
              splashRadius: splashRadius,
            );
          },
        ),
        SizedBox(width: 5),
        ValueListenableBuilder(
          valueListenable: fontSizeSetting.listen(),
          builder: (___, __, _) {
            return IconButton(
              tooltip: t.incrementFontSize,
              icon: Icon(Icons.remove),
              onPressed: fontSizeSetting.decrementCallback,
              splashRadius: splashRadius,
            );
          },
        ),
        SizedBox(width: 20),
        ValueListenableBuilder(
          valueListenable: Countdown.listenChanges(),
          builder: (___, __, _) {
            return IconButton(
              tooltip: t.resetCounter,
              icon: Icon(Icons.restore),
              onPressed: Countdown.resetCallback,
              splashRadius: splashRadius,
            );
          },
        ),
      ],
    );
  }
}
