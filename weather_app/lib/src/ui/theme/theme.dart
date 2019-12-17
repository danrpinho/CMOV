import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Themes {
  //constants for defining the theme.
  static const int THEME_LIGHT = 0;
  static const int THEME_DARK = 1;
  static const int THEME_GRADIENT = 2;

  static get lightTheme => _themeLight;
  static get darkTheme => _themeDark;

  static Color getMaxTempColor() => Colors.yellow[900];
  static Color getMinTempColor() => Colors.lightBlue[400];

  static final _themeLight = ThemeData(
    backgroundColor: Colors.grey[50],
    primaryColor: Colors.grey[50],
    primaryTextTheme: TextTheme(
      body1: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.bold)),
      body2: TextStyle(color: Colors.grey),
      title: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.grey[850], fontWeight: FontWeight.bold)),
      subtitle: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.grey[700])),
    ),
    iconTheme: IconThemeData(
      color: Colors.grey[700]
    )
  );

  static final _themeDark = ThemeData(
    primaryColor: Colors.grey[850],
    backgroundColor: Colors.grey[850],
    primaryTextTheme: TextTheme(
      title: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.grey[50], fontWeight: FontWeight.bold)),
      body1: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.grey[100], fontWeight: FontWeight.bold)),
      body2: TextStyle(color: Colors.grey),
      subtitle: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.grey[100])),
    ),
    iconTheme: IconThemeData(
      color: Colors.grey[100]
    )
  );
}
