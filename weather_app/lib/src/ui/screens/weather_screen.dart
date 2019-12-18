import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/src/model/weather.dart';
import 'package:weather_app/src/ui/widgets/main_info.dart';

const double _main_info_margin = 40;

class WeatherScreen extends StatelessWidget {
  final String day;
  final Weather weather;
  final SharedPreferences prefs;
  final Weather forecast24 = new Weather();
  final Weather forecast48 = new Weather();
  final Weather forecast72 = new Weather();
  final Weather forecast96 = new Weather();
  final Weather forecast120 = new Weather();

  WeatherScreen({
    Key key,
    this.day,
    this.weather,
    this.prefs,
  }) : super(key: key);

  _loadForecast() {
    forecast24.fromForecastWidget(
        weather.forecast.getRange(0, 8).toList(), weather.cityId, weather.name);
    forecast48.fromForecastWidget(weather.forecast.getRange(8, 16).toList(),
        weather.cityId, weather.name);
    forecast72.fromForecastWidget(weather.forecast.getRange(16, 24).toList(),
        weather.cityId, weather.name);
    forecast96.fromForecastWidget(weather.forecast.getRange(24, 32).toList(),
        weather.cityId, weather.name);
    forecast120.fromForecastWidget(weather.forecast.getRange(32, 40).toList(),
        weather.cityId, weather.name);
  }

  @override
  Widget build(BuildContext context) {
    _loadForecast();
    return new Swiper(
      itemBuilder: (BuildContext context, int index) {
        switch (index) {
          case 0:
            return SingleChildScrollView(
                child: Center(
                    child: MainInfo(
                        info: weather, prefs: prefs, day: "Current Weather")));
          case 1:
            return SingleChildScrollView(
                child: Center(
                    child: MainInfo(
                        info: forecast24, prefs: prefs, day: "Next 24 Hours")));
          case 2:
            return SingleChildScrollView(
                child: Center(
                    child: MainInfo(
                        info: forecast48,
                        prefs: prefs,
                        day: "Between the next 24 and 48 Hours")));
          case 3:
            return SingleChildScrollView(
                child: Center(
                    child: MainInfo(
                        info: forecast72,
                        prefs: prefs,
                        day: "Between the next 48 and 72 Hours")));
          case 4:
            return SingleChildScrollView(
                child: Center(
                    child: MainInfo(
                        info: forecast96,
                        prefs: prefs,
                        day: "Between the next 72 and 96 Hours")));
          case 5:
            return SingleChildScrollView(
                child: Center(
                    child: MainInfo(
                        info: forecast120,
                        prefs: prefs,
                        day: "Between the next 96 and 120 Hours")));
          default:
            return SingleChildScrollView(
                child: Center(
                    child: MainInfo(
                        info: weather, prefs: prefs, day: "Current Weather")));
        }
      },
      itemCount: 6,
      pagination: new SwiperPagination(
          margin: new EdgeInsets.all(5.0),
          builder: new DotSwiperPaginationBuilder(
              color: Colors.blueGrey, activeColor: Colors.black87)),
    );
  }
//MainInfo(info: weather, prefs: prefs, day: this.day),
}
