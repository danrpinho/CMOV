import 'dart:convert';

import 'package:http/http.dart' as http;
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
    print(url);

    //Response
    final response = await this.httpClient.get(url);
    final weatherJson = jsonDecode(response.body);

    print(weatherJson);
    //map to model
    return Weather.mapFromJson(weatherJson);
  }
}
