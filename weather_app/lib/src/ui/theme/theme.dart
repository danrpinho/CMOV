import 'package:flutter/material.dart';

class Themes{
  //constants for defining the theme.
  static const int THEME_LIGHT = 0;
  static const int THEME_DARK  = 1;
  static const int THEME_GRADIENT = 2;

  static get lightTheme => _themeLight;
  static get darkTheme => _themeDark;

  static Color getMaxTempColor() => Colors.yellow[900];
  static Color getMinTempColor() => Colors.lightBlue[400];

  static final _themeLight = ThemeData (
    backgroundColor: Colors.grey[50],
    primaryColor: Colors.grey[50],
  );

  static final _themeDark = ThemeData (
    primaryColor: Colors.grey[850],
    backgroundColor: Colors.grey[850],
  );
}