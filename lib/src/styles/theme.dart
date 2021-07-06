import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'button.dart';

void statusBarStyle(bool darkMode) {
  final brightness = darkMode ? Brightness.dark : Brightness.light;
  final isLight = brightness == Brightness.light;
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: isLight ? Colors.white : Colors.black,
    statusBarBrightness: brightness,
    statusBarIconBrightness: isLight ? Brightness.dark : Brightness.light,
  ));
}

ThemeData _darkTheme() {
  return ThemeData.from(colorScheme: ColorScheme.dark()).copyWith(
    primaryColor: Colors.green,
    //brightness: Brightness.light,
    textButtonTheme: TextButtonThemeData(style: textButtonStyle),
    elevatedButtonTheme: ElevatedButtonThemeData(style: elevatedButtonStyle),
    outlinedButtonTheme: OutlinedButtonThemeData(style: outlinedButtonStyle),
  );
}

ThemeData _lightTheme() {
  return ThemeData.from(colorScheme: ColorScheme.light()).copyWith(
    primaryColor: Colors.lightGreen,
    //brightness: Brightness.dark,
    textButtonTheme: TextButtonThemeData(style: textButtonStyle),
    elevatedButtonTheme: ElevatedButtonThemeData(style: elevatedButtonStyle),
    outlinedButtonTheme: OutlinedButtonThemeData(style: outlinedButtonStyle),
  );
}

ThemeData getTheme(bool darkMode) {
  return darkMode ? _darkTheme() : _lightTheme();
}
