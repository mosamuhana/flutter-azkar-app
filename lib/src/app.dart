import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'pages.dart';
import 'providers.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModel>(
      builder: (context, themeModel, _) {
        return Consumer<LocaleModel>(
          builder: (context, localeModel, _) {
            return MaterialApp(
              themeMode: themeModel.themeMode,
              locale: localeModel.value,
              debugShowCheckedModeBanner: false,
              title: 'Azkar',
              home: HomePage(),
              theme: themeModel.theme,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
            );
          },
        );
      },
    );
  }
}
