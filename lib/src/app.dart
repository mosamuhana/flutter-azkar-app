import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'services/locale.model.dart';

import 'pages.dart';
import 'styles/theme.dart';
import 'services/dark-mode.model.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<DarkModeModel>(
      builder: (context, darkModeModel, _) {
        return Consumer<LocaleModel>(
          builder: (context, localeModel, _) {
            return MaterialApp(
              locale: localeModel.value,
              debugShowCheckedModeBanner: false,
              title: 'Azkar',
              home: HomePage(),
              theme: getTheme(darkModeModel.value),
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
            );
          },
        );
      },
    );
  }
}
