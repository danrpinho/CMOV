//coord
//coord.lon City geo location, longitude
//coord.lat City geo location, latitude
//weather (more info Weather condition codes)
//weather.id Weather condition id
//weather.main Group of weather parameters (Rain, Snow, Extreme etc.)
//weather.description Weather condition within the group
//weather.icon Weather icon id
//base Internal parameter
//main.sea_level Atmospheric pressure on the sea level, hPa
//main.grnd_level Atmospheric pressure on the ground level, hPa
//wind
//wind.speed Wind speed. Unit Default: meter/sec, Metric: meter/sec, Imperial: miles/hour.
//wind.deg Wind direction, degrees (meteorological)
//clouds
//clouds.all Cloudiness, %
//rain
//rain.1h Rain volume for the last 1 hour, mm
//rain.3h Rain volume for the last 3 hours, mm
//snow
//snow.1h Snow volume for the last 1 hour, mm
//snow.3h Snow volume for the last 3 hours, mm

//sys
//sys.type Internal parameter
//sys.id Internal parameter
//sys.message Internal parameter
//sys.country Country code (GB, JP etc.)
//sys.sunrise Sunrise time, unix, UTC
//sys.sunset Sunset time, unix, UTC
//timezone Shift in seconds from UTC
//id City ID
//name City name
//cod Internal parameter

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weather_app/src/util/converters.dart';
import 'package:weather_app/src/util/weather_icons.dart';
import 'package:json_annotation/json_annotation.dart';

class Weather {
  String name;
  int cityId;
  //int weatherId;
  @JsonKey(name: 'temp')
  Temperature temp;
  @JsonKey(name: 'min_temp')
  Temperature minTemp;
  @JsonKey(name: 'max_temp')
  Temperature maxTemp;
  @JsonKey(name: 'feels_like')
  Temperature feelsLike;

  int pressure;
  int humidity;

  int currentTime;
  int sunsetTime;
  int sunriseTime;

  String weatherBio;
  String weatherInfo;
  String weatherIconID;

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
      this.weatherIconID});

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
    );
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

  // factory Weather.fromJson(Map<String, dynamic> json) =>
  //    _$WeatherFromJson(json);
  // Map<String, dynamic> toJson() => _$WeatherToJson(this);

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
                    'temp': f.temp.kelvin,
                    'pressure': f.pressure,
                    'temp_min': f.minTemp.kelvin,
                    'temp_max': f.maxTemp.kelvin,
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

  //factory Weather.fromJson(Map<String, dynamic> json) =>
  //    _$WeatherFromJson(this);
  //Map<String, dynamic> toJson() => _$WeatherToJson(this);
}
