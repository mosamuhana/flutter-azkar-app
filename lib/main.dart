import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'src/services.dart';
import 'src/app.dart';
import 'src/styles/theme.dart';
import 'src/services/countdown.model.dart';
import 'src/services/font-size.model.dart';
import 'src/services/busy.model.dart';
import 'src/services/locale.model.dart';
import 'src/services/dark-mode.model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await dotenv.load(fileName: "assets/.env");

  await PreferenceService.init();
  await DataService.init();

  statusBarStyle(PreferenceService.darkMode);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FontSizeModel()),
        ChangeNotifierProvider(create: (_) => CountdownModel()),
        ChangeNotifierProvider(create: (_) => BusyModel()),
        ChangeNotifierProvider(create: (_) => LocaleModel()),
        ChangeNotifierProvider(create: (_) => DarkModeModel()),
      ],
      child: App(),
    ),
  );
}
