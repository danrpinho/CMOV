import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/src/api/open_weather_client.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/src/model/weather.dart';

class WeatherRepository {
  final OpenWeatherAPIClient client;
  SharedPreferences preferences;

  WeatherRepository({@required this.client}) : assert(client != null);

  Future<Weather> getWeather(double lat, double lon, String cityName) async {
    if (cityName == null) {
      print("cityName null");
    }
    var weather = await client.fetchWeather(cityName);

    return weather;
  }

  Future<Weather> getWeatherbyName(String cityName) async {
    if (cityName == null) {
      print("cityName null");
    }
    var weather = await client.fetchWeather(cityName);
    var weatherForecast = await client.getForecast(cityName);
    //print(weatherForecast);
    weather.forecast = weatherForecast;
    return weather;
  }

  Future saveWeatherSharedPreferences(String key, weather) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(weather.name, json.encode(weather));
  }

  Future saveWeatherCollection(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  Future getWeatherCollectionShared(String name) async {
    final prefs = await SharedPreferences.getInstance();
    return json.decode(prefs.getString(name));
  }
}

class NetworkError extends Error {}
