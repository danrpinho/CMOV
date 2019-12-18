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
  final List<Weather> forecast24 = new List();
  final List<Weather> forecast48 = new List();
  final List<Weather> forecast72 = new List();
  final List<Weather> forecast96 = new List();
  final List<Weather> forecast120 = new List();

  WeatherScreen({
    Key key,
    this.day,
    this.weather,
    this.prefs,
  }) : super(key: key);

  _loadForecast() {
    forecast24.addAll(weather.forecast.getRange(0, 8));
    forecast48.addAll(weather.forecast.getRange(8, 16));
    forecast72.addAll(weather.forecast.getRange(16, 24));
    forecast96.addAll(weather.forecast.getRange(24, 32));
    forecast120.addAll(weather.forecast.getRange(32, 40));
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
                        info: weather, prefs: prefs, day: "Next 24 Hours")));
          case 2:
            return SingleChildScrollView(
                child: Center(
                    child: MainInfo(
                        info: weather,
                        prefs: prefs,
                        day: "Between the next 24 and 48 Hours")));
          case 3:
            return SingleChildScrollView(
                child: Center(
                    child: MainInfo(
                        info: weather,
                        prefs: prefs,
                        day: "Between the next 48 and 72 Hours")));
          case 4:
            return SingleChildScrollView(
                child: Center(
                    child: MainInfo(
                        info: weather,
                        prefs: prefs,
                        day: "Between the next 72 and 96 Hours")));
          case 5:
            return SingleChildScrollView(
                child: Center(
                    child: MainInfo(
                        info: weather,
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
      pagination: new SwiperPagination(),
    );
  }
//MainInfo(info: weather, prefs: prefs, day: this.day),
}
