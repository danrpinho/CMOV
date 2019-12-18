import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/src/model/weather.dart';

class Themes {
  //constants for defining the theme.
  static const int THEME_LIGHT = 0;
  static const int THEME_DARK = 1;
  static const int THEME_GRADIENT = 2;

  static get lightTheme => _themeLight;
  static get darkTheme => _themeDark;
  static get gradientThemeSunny => _gradientSunny;
  static get gradientThemeRainyStormy => _gradientRainy;
  static get gradientThemeFoggySnowy => _gradientFoggy;
  static get gradientThemeUnknown => _gradientUnknown;

  static get gradientBackgroundSunny => _backgroundSunny;

  static Color getMaxTempColor() => Colors.yellow[900];
  static Color getMinTempColor() => Colors.lightBlue[400];

  static final _themeLight = ThemeData(
    backgroundColor: Colors.grey[50],
    primaryColor: Colors.grey[50],
    accentColor: Colors.grey[100],
    primaryTextTheme: TextTheme(
      body1: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.bold)),
      body2: TextStyle(color: Colors.grey),
      title: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.grey[850], fontWeight: FontWeight.bold)),
      subtitle: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.grey[700])),
    ),
    iconTheme: IconThemeData(
      color: Colors.grey[700]
    ),
    buttonColor: Colors.grey[850],
  );

  static final _themeDark = ThemeData(
    primaryColor: Colors.grey[850],
    backgroundColor: Colors.grey[850],
    accentColor: Colors.grey[700],
    primaryTextTheme: TextTheme(
      title: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.grey[50], fontWeight: FontWeight.bold)),
      body1: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.grey[100], fontWeight: FontWeight.bold)),
      body2: TextStyle(color: Colors.grey),
      subtitle: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.grey[100])),
    ),
    iconTheme: IconThemeData(
      color: Colors.grey[100]
    ),
    buttonColor: Colors.grey[50],
  );

  static final _gradientSunny = ThemeData(
    primaryColor: Colors.lightBlue[400],
    backgroundColor: Colors.lightBlue[400],
    primaryTextTheme: TextTheme(
      title: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      body1: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      body2: TextStyle(color: Colors.white),
      subtitle: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.white)),
    ),
    iconTheme: IconThemeData(
      color: Colors.white
    ),
    buttonColor: Colors.white,
  );

  static final _gradientRainy = ThemeData(
    primaryColor: Colors.indigo[400],
    backgroundColor: Colors.indigo[400],
    primaryTextTheme: TextTheme(
      title: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      body1: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      body2: TextStyle(color: Colors.white),
      subtitle: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.white)),
    ),
    iconTheme: IconThemeData(
      color: Colors.white
    ),
    buttonColor: Colors.white,
  );

  static final _gradientFoggy = ThemeData(
    primaryColor: Colors.blueGrey[400],
    backgroundColor: Colors.blueGrey[400],
    primaryTextTheme: TextTheme(
      title: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      body1: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      body2: TextStyle(color: Colors.white),
      subtitle: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.white)),
    ),
    iconTheme: IconThemeData(
      color: Colors.white
    ),
    buttonColor: Colors.white,
  );

  static final _gradientUnknown = ThemeData(
    primaryColor: Colors.grey,
    backgroundColor: Colors.grey,
    primaryTextTheme: TextTheme(
      title: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      body1: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      body2: TextStyle(color: Colors.white),
      subtitle: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.white)),
    ),
    iconTheme: IconThemeData(
      color: Colors.white
    ),
    buttonColor: Colors.white,
  );

  static final _backgroundSunny = BoxDecoration(
    gradient: LinearGradient(
      colors: [Colors.lightBlue[400], Colors.lightBlue[900]],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    )
  );

  static ThemeData getGradient(Weather info){
    
  }

}
