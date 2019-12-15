import 'package:flutter/material.dart';
import 'package:weather_app/src/model/weather.dart';
import 'package:weather_app/src/ui/widgets/main_info.dart';

const double _main_info_margin = 40;

class WeatherScreen extends StatelessWidget {
  final String day;
  final Weather weather;

  WeatherScreen({
    Key key,
    this.day,
    this.weather,
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
                IconButton(
                  iconSize: 30.0,
                  onPressed: () {},
                  icon: Icon(Icons.keyboard_arrow_left),
                ),
                Text(this.day),
                IconButton(
                  iconSize: 30.0,
                  onPressed: () {},
                  icon: Icon(Icons.keyboard_arrow_right),
                ),
              ],
            ),
          ),
          MainInfo(info: null, key: null),
        ],
      )),
      margin: EdgeInsets.all(_main_info_margin),
    );
  }
}
