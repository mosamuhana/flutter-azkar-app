import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'pages.dart';
import 'boxes.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable:
          Settings.listen(keys: [ThemeSetting.KEY, LocaleSetting.KEY]),
      builder: (___, __, _) {
        return MaterialApp(
          themeMode: ThemeSetting.instance.themeMode,
          locale: LocaleSetting.instance.locale,
          debugShowCheckedModeBanner: false,
          title: 'Azkar',
          home: HomePage(),
          theme: ThemeSetting.instance.theme,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        );
      },
    );
  }
}
