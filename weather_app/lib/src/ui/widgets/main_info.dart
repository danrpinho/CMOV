import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:weather_app/src/model/weather.dart';
import 'package:weather_app/src/ui/widgets/temperature_chart.dart';
import 'package:weather_app/src/ui/widgets/value_tile.dart';
import 'package:weather_app/src/util/constants.dart';
import 'package:weather_app/src/util/converters.dart';

import '../theme/theme.dart';

class MainInfo extends StatefulWidget {
  final Weather info;

  const MainInfo({Key key, this.info}) : super(key: key);

  @override
  _MainInfoState createState() => _MainInfoState();
}

class _MainInfoState extends State<MainInfo> {
  SharedPreferences prefs;
  _loadState() async* {
    prefs = await SharedPreferences.getInstance();
    if (prefs.getInt(Constants.PREFS_TEMPERATURE_UNIT) != null) {}
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(Icons.cloud, color: Colors.black, size: 45),
        Text(
          // city
          widget.info.name,
          style: TextStyle(
            color: Colors.black,
            fontSize: 40,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          // weather condition
          widget.info.weatherBio,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 25,
          ),
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: EdgeInsets.all(5),
        ),
        Text(
          // weather condition
          widget.info.weatherInfo,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 15,
          ),
          textAlign: TextAlign.center,
        ),
        createTemperatureWidget(widget.info),
        Padding(
          child: Divider(
            color: Colors.black,
          ),
          padding: EdgeInsets.all(20),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          ValueTile("wind speed", '${widget.info.windSpeed} m/s'),
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Center(
                child: Container(width: 1, height: 30, color: Colors.black45)),
          ),
          ValueTile(
              "sunrise",
              DateFormat('h:m a').format(DateTime.fromMillisecondsSinceEpoch(
                  this.widget.info.sunriseTime * 1000))),
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Center(
                child: Container(width: 1, height: 30, color: Colors.black45)),
          ),
          ValueTile(
              "sunset",
              DateFormat('h:m a').format(DateTime.fromMillisecondsSinceEpoch(
                  this.widget.info.sunsetTime * 1000))),
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Center(
                child: Container(
              width: 1,
              height: 30,
              color: Colors.black45,
            )),
          ),
          ValueTile("humidity", '${this.widget.info.humidity}%'),
        ]),
        TemperatureChart(
          widget.info.forecast,
          TemperatureUnit.celsius,
          animate: true,
        )
      ],
    );
  }

  createTemperatureWidget(Weather info) {
    return Container(
        margin: new EdgeInsets.only(top: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "${info.temp.as(Temperature.fromRadioOption(prefs.getInt(Constants.PREFS_TEMPERATURE_UNIT))).round().toString()}º",
              style: TextStyle(fontSize: 50, color: Colors.black),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Center(
                  child:
                      Container(width: 1, height: 30, color: Colors.black45)),
            ),
            Column(
              children: <Widget>[
                Text("Max : ${info.maxTemp.celsius.round().toString()}º",
                    style: TextStyle(color: Themes.getMaxTempColor())),
                Text(
                  "Min: ${info.minTemp.celsius.round().toString()}º",
                  style: TextStyle(color: Themes.getMinTempColor()),
                )
              ],
            )
          ],
        ));
  }
}
