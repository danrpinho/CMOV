import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weather_app/src/util/converters.dart';
import 'package:weather_app/src/util/weather_icons.dart';

class Weather {
  String name;
  int cityId;
  //int weatherId;

  Temperature temp;

  Temperature minTemp;

  Temperature maxTemp;

  Temperature feelsLike;

  int pressure;
  int humidity;

  int currentTime;
  int sunsetTime;
  int sunriseTime;

  String weatherBio;
  String weatherInfo;
  String weatherIconID;

  double windSpeed;
  List<Weather> forecast;

  Weather(
      {this.cityId,
      this.name,
      this.temp,
      this.maxTemp,
      this.minTemp,
      this.humidity,
      this.feelsLike,
      this.pressure,
      this.currentTime,
      this.sunsetTime,
      this.sunriseTime,
      this.weatherBio,
      this.weatherInfo,
      this.weatherIconID,
      this.windSpeed});

  static Weather mapFromJson(Map<String, dynamic> json) {
    final weather = json['weather'][0];
    return Weather(
        cityId: json['id'],
        name: json['name'],

        //main.temp Temperature. Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit.
        temp: Temperature(int2Double(json['main']['temp'])),

        //main.pressure Atmospheric pressure (on the sea level, if there is no sea_level or grnd_level data), hPa
        pressure: json['main']['pressure'],

        //main.humidity Humidity, %
        humidity: json['main']['humidity'],

        //main.temp_min Minimum temperature at the moment. This is deviation from current temp that is possible for large cities and megalopolises geographically expanded (use these parameter optionally). Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit.
        minTemp: Temperature(int2Double(json['main']['temp_min'])),

        //main.temp_max Maximum temperature at the moment. This is deviation from current temp that is possible for large cities and megalopolises geographically expanded (use these parameter optionally). Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit.
        maxTemp: Temperature(int2Double(json['main']['temp_max'])),

        //dt Time of data calculation, unix, UTC
        currentTime: json['dt'],

        //sys.sunrise Sunrise time, unix, UTC
        sunriseTime: json['sys']['sunrise'],

        //sys.sunset Sunset time, unix, UTC
        sunsetTime: json['sys']['sunset'],

        //weather.main Group of weather parameters (Rain, Snow, Extreme etc.)
        weatherBio: weather['main'],
        //weather.description Weather condition within the group
        weatherInfo: weather['description'],
        //weather.icon Weather icon id
        weatherIconID: weather['icon'],
        // wind
        windSpeed: int2Double(json['wind']['speed']));
  }

  static List<Weather> fromForecastJson(Map<String, dynamic> json) {
    final weathers = List<Weather>();
    for (final item in json['list']) {
      weathers.add(Weather(
          currentTime: item['dt'],
          temp: Temperature(int2Double(
            item['main']['temp'],
          )),
          weatherIconID: item['weather'][0]['icon']));
    }
    return weathers;
  }

  Map<String, dynamic> toJson() => {
        'id': cityId,
        'name': name,
        'main': {
          'temp': temp.kelvin,
          'pressure': pressure,
          'temp_min': minTemp.kelvin,
          'temp_max': maxTemp.kelvin,
        },
        'dt': currentTime,
        'sys': {'sunrise': sunriseTime, 'sunset': sunsetTime},
        'weather': [
          {
            'main': weatherBio,
            'description': weatherInfo,
            'icon': weatherIconID
          }
        ],
        'forecasts': forecast
            .map((f) => {
                  'main': {
                    'temp': temp.kelvin,
                    'pressure': pressure,
                    'temp_min': minTemp.kelvin,
                    'temp_max': maxTemp.kelvin,
                  },
                  'dt': currentTime,
                  'weather': [
                    {
                      'main': weatherBio,
                      'description': weatherInfo,
                      'icon': weatherIconID
                    }
                  ],
                })
            .toList()
      };
  IconData toIcon() {
    switch (this.weatherIconID) {
      case '01d':
        return WeatherIconsConverter.clear_day;
      case '01n':
        return WeatherIconsConverter.clear_night;
      case '02d':
        return WeatherIconsConverter.few_clouds_day;
      case '02n':
        return WeatherIconsConverter.few_clouds_day;
      case '03d':
      case '04d':
        return WeatherIconsConverter.clouds_day;
      case '03n':
      case '04n':
        return WeatherIconsConverter.clear_night;
      case '09d':
        return WeatherIconsConverter.shower_rain_day;
      case '09n':
        return WeatherIconsConverter.shower_rain_night;
      case '10d':
        return WeatherIconsConverter.rain_day;
      case '10n':
        return WeatherIconsConverter.rain_night;
      case '11d':
        return WeatherIconsConverter.thunder_storm_day;
      case '11n':
        return WeatherIconsConverter.thunder_storm_night;
      case '13d':
        return WeatherIconsConverter.snow_day;
      case '13n':
        return WeatherIconsConverter.snow_night;
      case '50d':
        return WeatherIconsConverter.mist_day;
      case '50n':
        return WeatherIconsConverter.mist_night;
      default:
        return WeatherIconsConverter.clear_day;
    }
  }
}
