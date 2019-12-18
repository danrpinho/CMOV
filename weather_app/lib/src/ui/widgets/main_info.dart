import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/src/model/weather.dart';
import 'package:weather_app/src/ui/widgets/temperature_chart.dart';
import 'package:weather_app/src/ui/widgets/value_tile.dart';
import 'package:weather_app/src/util/constants.dart';
import 'package:weather_app/src/util/converters.dart';

import '../theme/theme.dart';

class MainInfo extends StatelessWidget {
  final Weather info;
  final SharedPreferences prefs;

  const MainInfo({Key key, this.info, this.prefs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(Icons.cloud, color: Colors.black, size: 45),
        Text(
          // city
          info.name,
          style: TextStyle(
            color: Colors.black,
            fontSize: 40,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          // weather condition
          info.weatherBio,
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
          info.weatherInfo,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 15,
          ),
          textAlign: TextAlign.center,
        ),
        createTemperatureWidget(info),
        Padding(
          child: Divider(
            color: Colors.black,
          ),
          padding: EdgeInsets.all(20),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          ValueTile("wind speed", '${info.windSpeed} m/s'),
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Center(
                child: Container(width: 1, height: 30, color: Colors.black45)),
          ),
          ValueTile(
              "sunrise",
              DateFormat('h:m a').format(DateTime.fromMillisecondsSinceEpoch(
                  this.info.sunriseTime * 1000))),
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Center(
                child: Container(width: 1, height: 30, color: Colors.black45)),
          ),
          ValueTile(
              "sunset",
              DateFormat('h:m a').format(DateTime.fromMillisecondsSinceEpoch(
                  this.info.sunsetTime * 1000))),
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Center(
                child: Container(
              width: 1,
              height: 30,
              color: Colors.black45,
            )),
          ),
          ValueTile("humidity", '${this.info.humidity}%'),
        ]),
        TemperatureChart(
          info.forecast,
          Temperature.fromRadioOption(
              prefs.getInt(Constants.PREFS_TEMPERATURE_UNIT)),
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
              "${info.temp.tempToString(Temperature.fromRadioOption(prefs.getInt(Constants.PREFS_TEMPERATURE_UNIT)))}",
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
                Text(
                    "Max : ${info.maxTemp.tempToString(Temperature.fromRadioOption(prefs.getInt(Constants.PREFS_TEMPERATURE_UNIT)))}",
                    style: TextStyle(color: Themes.getMaxTempColor())),
                Text(
                  "Min: ${info.minTemp.tempToString(Temperature.fromRadioOption(prefs.getInt(Constants.PREFS_TEMPERATURE_UNIT)))}",
                  style: TextStyle(color: Themes.getMinTempColor()),
                )
              ],
            )
          ],
        ));
  }
}
