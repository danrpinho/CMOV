import 'package:weather_app/src/model/weather.dart';

class WeatherCollection {
  List<Weather> weathers;

  WeatherCollection({this.weathers});

  Map<String, dynamic> toJson() => {
        'weathers': weathers,
      };
}
