import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void darkStatusBar() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.black,
    statusBarBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.light,
  ));
}

void lightStatusBar() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.dark,
  ));
}

void statusBarStyle({Brightness brightness = Brightness.light}) {
  final isLight = brightness == Brightness.light;
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: isLight ? Colors.white : Colors.black,
    statusBarBrightness: brightness,
    statusBarIconBrightness: isLight ? Brightness.dark : Brightness.light,
  ));
}
