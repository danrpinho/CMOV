import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/src/api/open_weather_client.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/src/model/weather.dart';

class WeatherRepository {
  final OpenWeatherAPIClient client;

  //constructor, inject dependency
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

    weather.forecast = weatherForecast;
    return weather;
  }

  Future<Weather> getWeatherById(int id) async {
    if (id == null) {
      print("id null");
    }
    var weather = await client.fetchWeatherByID(id);
    var weatherForecast = await client.getForecastByID(id);
    weather.forecast = weatherForecast;
    return weather;
  }

  Future saveWeatherSharedPreferences(String key, weather) async {
    final prefs = await SharedPreferences.getInstance();
    print(json.encode(weather));

    prefs.setString(weather.name, json.encode(weather));
  }

  Future getWeatherSharedPreferences(name) async {
    final prefs = await SharedPreferences.getInstance();
    return json.decode(prefs.getString(name));
  }

  Future saveWeatherCollection(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  Future getWeatherCollectionShared(String name) async {
    final prefs = await SharedPreferences.getInstance();
    return json.decode(prefs.getString(name));
  }

  Future<List<Weather>> getWeatherCollectionRemote(List<int> ids) async {
    final weathers = List<Weather>();
    var logger = Logger();
    for (var id in ids) {
      Weather weather = await client.fetchWeatherByID(id);
      weathers.add(weather);
      //logger.i(weather);
    }
    return weathers;
  }
}

class NetworkError extends Error {}
