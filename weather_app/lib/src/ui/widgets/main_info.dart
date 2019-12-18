import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/src/model/weather.dart';
import 'package:weather_app/src/ui/widgets/temperature_chart.dart';
import 'package:weather_app/src/ui/widgets/value_tile.dart';
import 'package:weather_app/src/util/converters.dart';

import '../theme/theme.dart';

class MainInfo extends StatelessWidget {
  final Weather info;
  const MainInfo({Key key, this.info}) : super(key: key);

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
            )),
        Text(
          // weather condition
          "Cloudy",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 20,
          ),
        ),
        createTemperatureWidget(info),
        Padding(
          child: Divider(
            color: Colors.black,
          ),
          padding: EdgeInsets.all(15),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          ValueTile("wind speed", '${info.windSpeed} m/s'),
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Center(
                child: Container(width: 1, height: 20, color: Colors.black45)),
          ),
          ValueTile(
              "sunrise",
              DateFormat('h:m a').format(DateTime.fromMillisecondsSinceEpoch(
                  this.info.sunriseTime * 1000))),
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Center(
                child: Container(width: 1, height: 20, color: Colors.black45)),
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
              height: 20,
              color: Colors.black45,
            )),
          ),
          ValueTile("humidity", '${this.info.humidity}%'),
        ]),
        TemperatureChart(
          info.forecast,
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
              "13ºC",
              style: TextStyle(fontSize: 30, color: Colors.grey),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Center(
                  child:
                      Container(width: 1, height: 30, color: Colors.black45)),
            ),
            Column(
              children: <Widget>[
                Text("Max: 18ºC",
                    style: TextStyle(color: Themes.getMaxTempColor())),
                Text(
                  "Min: 9ºC",
                  style: TextStyle(color: Themes.getMinTempColor()),
                )
              ],
            )
          ],
        ));
  }
}
