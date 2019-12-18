import 'package:flutter/material.dart';
import 'package:weather_app/src/util/algorithms.dart';
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

  double rain;
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
      this.windSpeed,
      this.rain});

  fromForecastWidget(List<Weather> weathers, int cityId, String name) {
    this.forecast = weathers;

    this.temp = new Temperature(
        ListAlgo().avg(weathers.map((f) => f.temp.kelvin).toList()));
    this.maxTemp = new Temperature(
        ListAlgo().max(weathers.map((f) => f.maxTemp.kelvin).toList()));
    this.minTemp = new Temperature(ListAlgo()
        .min(weathers.map((f) => f.minTemp.kelvin).toList()) as double);
    this.windSpeed = (ListAlgo()
        .avg(weathers.map((f) => f.windSpeed).toList())
        .roundToDouble());
    this.sunriseTime = null;
    this.sunsetTime = null;

    this.humidity =
        (ListAlgo().avg(weathers.map((f) => f.humidity.toDouble()).toList()))
            .round();
    this.pressure = 1;
    this.weatherIconID =
        ListAlgo().mostCommon(weathers.map((f) => f.weatherIconID).toList());
    this.weatherBio =
        ListAlgo().mostCommon(weathers.map((f) => f.weatherBio).toList());
    this.weatherInfo =
        ListAlgo().mostCommon(weathers.map((f) => f.weatherInfo).toList());
    this.name = name;
    this.pressure = ListAlgo()
        .avg(weathers.map((f) => f.pressure.toDouble()).toList())
        .round();
    this.cityId = cityId;
    this.rain = ListAlgo()
        .rainAverage(weathers.map((f) => f.rain).toList())
        .roundToDouble();
    //TODO Process data
  }

  static Weather mapFromJson(Map<String, dynamic> json) {
    final weather = json['weather'][0];
    var rain;
    if (json['rain'] != null) {
      if (json['rain']['1h'] != null) {
        rain = int2Double(json['rain']['1h']);
      } else if (json['rain']['3h'] != null) {
        rain = int2Double(json['rain']['3h']);
      }
    }
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
        rain: rain,
        // wind
        windSpeed: int2Double(json['wind']['speed']));
  }

  static List<Weather> fromForecastJson(Map<String, dynamic> json) {
    final weathers = List<Weather>();
    for (final item in json['list']) {
      weathers.add(mapFromJson(item));

      // Weather(

/*          currentTime: item['dt'],
          temp: Temperature(int2Double(
            item['main']['temp'],
          )),
          minTemp: Temperature(int2Double(
            item['main']['maxTemp'],
          )),
          maxTemp: Temperature(int2Double(
            item['main']['minTemp'],
          )),
          weatherIconID: item['weather'][0]['icon']));*/

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
