import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'src/services.dart';
import 'src/providers.dart';
import 'src/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceService.init();
  await DataService.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FontSizeModel()),
        ChangeNotifierProvider(create: (_) => CountdownModel()),
        ChangeNotifierProvider(create: (_) => BusyModel()),
        ChangeNotifierProvider(create: (_) => LocaleModel()),
        ChangeNotifierProvider(create: (_) => ThemeModel()),
      ],
      child: App(),
    ),
  );
}
