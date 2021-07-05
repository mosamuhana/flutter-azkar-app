import 'package:flutter/material.dart';
//import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'pages.dart';
import 'styles/button.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //print('******************* API_KEY: ${dotenv.env['API_KEY']}');
    return Directionality(
      textDirection: TextDirection.rtl,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Azkar',
        home: HomePage(),
        //theme: ThemeData(primarySwatch: Colors.blue),
        theme: ThemeData.from(colorScheme: ColorScheme.light()).copyWith(
          primaryColor: Colors.green,
          brightness: Brightness.light,
          textButtonTheme: TextButtonThemeData(style: textButtonStyle),
          elevatedButtonTheme:
              ElevatedButtonThemeData(style: elevatedButtonStyle),
          outlinedButtonTheme:
              OutlinedButtonThemeData(style: outlinedButtonStyle),
        ),
      ),
    );
  }
}
