import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/src/model/weather.dart';

class OpenWeatherAPIClient {
  static const baseUrl = 'http://api.openweathermap.org';
  static const apiKey = '24f05e70865dac4f7982395d139fad1e';
  final http.Client httpClient;

  OpenWeatherAPIClient({@required this.httpClient})
      : assert(httpClient != null);

  Future<Weather> fetchWeather(String cityName) async {
    //URL
    final url = '$baseUrl/data/2.5/weather?q=$cityName&appid=$apiKey';
    //print(url);

    //Response
    final response = await this.httpClient.get(url);
    final weatherJson = jsonDecode(response.body);

    // print(weatherJson);
    //map to model
    return Weather.mapFromJson(weatherJson);
  }

  Future<Weather> fetchWeatherByLocation(double lat, double lon) async {
    final url = '$baseUrl/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey';

    final res = await this.httpClient.get(url);
    if (res.statusCode != 200) {
      Logger().e("couldnt get weather by location");
    }
    final weatherJson = json.decode(res.body);
    Weather weather = Weather.mapFromJson(weatherJson);
    return weather;
  }

  Future<List<Weather>> getForecast(String cityName) async {
    //URL
    final url = '$baseUrl/data/2.5/forecast?q=$cityName&appid=$apiKey';

    //print('fetching $url');

    //response
    final res = await this.httpClient.get(url);
    if (res.statusCode != 200) {
      print("error");
    }
    final forecastJson = json.decode(res.body);
    //print(forecastJson);
    // map to model
    List<Weather> weathers = Weather.fromForecastJson(forecastJson);

    return weathers;
  }

  Future<Weather> fetchWeatherByID(int id) async {
    final url = '$baseUrl/data/2.5/weather?id=$id&appid=$apiKey';
    //  print(url);

    //Response
    final response = await this.httpClient.get(url);
    final weatherJson = jsonDecode(response.body);

    return Weather.mapFromJson(weatherJson);
  }

  Future<List<Weather>> getForecastByID(int id) async {
    //URL
    final url = '$baseUrl/data/2.5/forecast?id=$id&appid=$apiKey';

//print('fetching $url');

    //response
    final res = await this.httpClient.get(url);
    if (res.statusCode != 200) {
      print("error");
    }
    final forecastJson = json.decode(res.body);
    //print(forecastJson);
    // map to model
    List<Weather> weathers = Weather.fromForecastJson(forecastJson);
    return weathers;
  }
}
