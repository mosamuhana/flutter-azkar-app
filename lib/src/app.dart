import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'services/locale.model.dart';

import 'pages.dart';
import 'services/theme.model.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //return Consumer<DarkModeModel>
    return Consumer<ThemeModel>(
      builder: (context, darkModeModel, _) {
        return Consumer<LocaleModel>(
          builder: (context, localeModel, _) {
            return MaterialApp(
              //themeMode: ThemeMode.dark,
              locale: localeModel.value,
              debugShowCheckedModeBanner: false,
              title: 'Azkar',
              home: HomePage(),
              //theme: getTheme(darkModeModel.value),
              theme: darkModeModel.theme,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
            );
          },
        );
      },
    );
  }
}
