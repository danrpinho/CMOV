import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:weather_app/src/model/weather.dart';
import 'package:weather_app/src/util/converters.dart';

class TemperatureChart extends StatelessWidget {
  final List<Weather> weathers;
  final bool animate;
  final TemperatureUnit unit;
  TemperatureChart(this.weathers, this.unit, {this.animate});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 300,
        child: Padding(
            padding:
                const EdgeInsets.only(top: 40, bottom: 40, left: 5, right: 5),
            child: charts.TimeSeriesChart([
              new charts.Series<Weather, DateTime>(
                id: 'Temperature',
                colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
                domainFn: (Weather weather, _) =>
                    DateTime.fromMillisecondsSinceEpoch(
                        weather.currentTime * 1000),
                measureFn: (Weather weather, _) => weather.temp.as(unit),
                data: weathers,
              )
            ],
                animate: animate,
                animationDuration: Duration(milliseconds: 500),
                primaryMeasureAxis: new charts.NumericAxisSpec(
                    tickProviderSpec: new charts.BasicNumericTickProviderSpec(
                        zeroBound: false)))));
  }
}
