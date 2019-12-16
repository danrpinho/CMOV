import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/src/ui/theme/theme.dart';
import 'package:weather_app/src/util/constants.dart';
import 'package:weather_app/src/util/converters.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  static dynamic selectedTheme = 1;
  static dynamic selectedTemperatureUnit = 1;

  SharedPreferences preferences;

  notifyThemeUpdate(int themeCode) {
    setState(() {
      selectedTheme = themeCode;
      preferences.setInt(Constants.PREFS_THEME, themeCode);
    });
  }

  notifyTemperatureUnitUpdate(int tempCode) {
    setState(() {
      selectedTemperatureUnit = tempCode;
      preferences.setInt(Constants.PREFS_TEMPERATURE_UNIT, tempCode);
    });
  }

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  _loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      preferences = prefs;
      selectedTheme = (prefs.getInt(Constants.PREFS_THEME) ?? 1);
      selectedTemperatureUnit =
          (prefs.getInt(Constants.PREFS_TEMPERATURE_UNIT) ?? 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Settings')),
        body: new Container(
          child: ListView(
            children: <Widget>[
              Card(
                margin: EdgeInsets.all(10),
                elevation: 3,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Theme",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    ThemeOption(
                      backgroundColor: Colors.white,
                      textColor: Colors.black,
                      accentColor: Colors.black,
                      themeName: "Light Mode",
                      themeValue: Themes.THEME_LIGHT,
                      updateTheme: notifyThemeUpdate,
                    ),
                    ThemeOption(
                      backgroundColor: Colors.white,
                      textColor: Colors.black,
                      accentColor: Colors.black,
                      themeName: "Dark Mode",
                      themeValue: Themes.THEME_DARK,
                      updateTheme: notifyThemeUpdate,
                    ),
                    ThemeOption(
                      backgroundColor: Colors.white,
                      textColor: Colors.black,
                      accentColor: Colors.black,
                      themeName: "Gradient Mode",
                      themeValue: Themes.THEME_GRADIENT,
                      updateTheme: notifyThemeUpdate,
                    ),
                  ],
                ),
              ),
              Card(
                margin: EdgeInsets.all(10),
                elevation: 3,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 15, left: 8, right: 8, bottom: 8),
                      child: Text(
                        "Temperature Units",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    TemperatureOption(
                      backgroundColor: Colors.white,
                      textColor: Colors.black,
                      accentColor: Colors.black,
                      temperatureUnit: "Kelvin",
                      temperatureValue:
                          Temperature.asRadioOption(TemperatureUnit.kelvin),
                      updateTemperatureUnit: notifyTemperatureUnitUpdate,
                    ),
                    TemperatureOption(
                      backgroundColor: Colors.white,
                      textColor: Colors.black,
                      accentColor: Colors.black,
                      temperatureUnit: "Celsius",
                      temperatureValue:
                          Temperature.asRadioOption(TemperatureUnit.celsius),
                      updateTemperatureUnit: notifyTemperatureUnitUpdate,
                    ),
                    TemperatureOption(
                      backgroundColor: Colors.white,
                      textColor: Colors.black,
                      accentColor: Colors.black,
                      temperatureUnit: "Fahrenheit",
                      temperatureValue:
                          Temperature.asRadioOption(TemperatureUnit.fahrenheit),
                      updateTemperatureUnit: notifyTemperatureUnitUpdate,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class ThemeOption extends StatelessWidget {
  final dynamic backgroundColor;
  final dynamic textColor;
  final dynamic accentColor;
  final dynamic themeName;
  final dynamic themeValue;
  final Function updateTheme;

  const ThemeOption({
    Key key,
    @required this.backgroundColor,
    @required this.textColor,
    @required this.accentColor,
    @required this.themeName,
    @required this.themeValue,
    @required this.updateTheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8), topRight: Radius.circular(8)),
        color: this.backgroundColor,
      ),
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            this.themeName,
            style: TextStyle(color: this.textColor),
          ),
          Radio(
            value: this.themeValue,
            groupValue: _SettingsState.selectedTheme,
            onChanged: (value) {
              this.updateTheme(value);
            },
            activeColor: this.accentColor,
          )
        ],
      ),
    );
  }
}

class TemperatureOption extends StatelessWidget {
  final dynamic backgroundColor;
  final dynamic textColor;
  final dynamic accentColor;
  final dynamic temperatureUnit;
  final dynamic temperatureValue;
  final Function updateTemperatureUnit;

  const TemperatureOption({
    Key key,
    @required this.backgroundColor,
    @required this.textColor,
    @required this.accentColor,
    @required this.temperatureUnit,
    @required this.temperatureValue,
    @required this.updateTemperatureUnit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8), topRight: Radius.circular(8)),
        color: this.backgroundColor,
      ),
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            this.temperatureUnit,
            style: TextStyle(color: this.textColor),
          ),
          Radio(
            value: this.temperatureValue,
            groupValue: _SettingsState.selectedTemperatureUnit,
            onChanged: (value) {
              this.updateTemperatureUnit(value);
            },
            activeColor: this.accentColor,
          )
        ],
      ),
    );
  }
}
