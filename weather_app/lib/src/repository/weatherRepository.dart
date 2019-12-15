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
      //TODO get name from location
    }
    var weather = await client.fetchWeather(cityName);
    return weather;
  }

  Future<Weather> getWeatherbyName(String cityName) async {
    if (cityName == null) {
      print("cityName null");
      //TODO get name from location
    }
    var weather = await client.fetchWeather(cityName);
    return weather;
  }
}

class NetworkError extends Error {}
