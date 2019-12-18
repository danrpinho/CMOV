import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/src/model/weather.dart';
import 'package:weather_app/src/ui/widgets/main_info.dart';

const double _main_info_margin = 40;

class WeatherScreen extends StatelessWidget {
  final String day;
  final Weather weather;
  final SharedPreferences prefs;

  WeatherScreen({
    Key key,
    this.day,
    this.weather,
    this.prefs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Center(
          child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, _main_info_margin),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(this.day),
              ],
            ),
          ),
          MainInfo(info: weather, key: null, prefs: prefs),
        ],
      )),
      margin: EdgeInsets.all(_main_info_margin),
    );
  }
}
