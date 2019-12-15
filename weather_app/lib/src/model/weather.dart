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

import 'dart:ffi';

class Weather {
  String name;
  int cityId;
  //int weatherId;
  double temp;
  double minTemp;
  double maxTemp;
  double feelsLike;

  int pressure;
  int humidity;

  int currentTime;
  int sunsetTime;
  int sunriseTime;

  String weatherBio;
  String weatherInfo;
  String weatherIconID;

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
      this.weatherBio, //Todo rename this for something better
      this.weatherInfo,
      this.weatherIconID});

  static Weather mapFromJson(Map<String, dynamic> json) {
    return Weather(
      cityId: json['id'],
      name: json['name'],

      //main.temp Temperature. Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit.
      temp: json['main']['temp'],

      //main.pressure Atmospheric pressure (on the sea level, if there is no sea_level or grnd_level data), hPa
      pressure: json['main']['pressure'],

      //main.humidity Humidity, %
      humidity: json['main']['humidity'],

      //main.temp_min Minimum temperature at the moment. This is deviation from current temp that is possible for large cities and megalopolises geographically expanded (use these parameter optionally). Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit.
      minTemp: json['main']['temp_min'],

      //main.temp_max Maximum temperature at the moment. This is deviation from current temp that is possible for large cities and megalopolises geographically expanded (use these parameter optionally). Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit.
      maxTemp: json['main']['temp_max'],

      //dt Time of data calculation, unix, UTC
      currentTime: json['dt'],
      //sys.sunrise Sunrise time, unix, UTC
      sunriseTime: json['sys']['sunrise'],
      //sys.sunset Sunset time, unix, UTC
      sunsetTime: json['sys']['sunset'],
      //weather.main Group of weather parameters (Rain, Snow, Extreme etc.)
      //TODO code below untested, it should work
      //weatherBio: json['weather']['0']['main'],
      //weather.description Weather condition within the group

      //weatherInfo: json['weather']['0']['description'],
      //weather.icon Weather icon id

      //weatherIconID: json['weather']['0']['icon'],
    );
  }
}
