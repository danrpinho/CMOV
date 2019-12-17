import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class FetchWeather extends WeatherEvent {
  final String cityName;
  const FetchWeather(this.cityName);

  @override
  List<Object> get props => [cityName];
}

class FetchWeatherById extends WeatherEvent {
  final int id;
  const FetchWeatherById(this.id);

  @override
  List<Object> get props => [id];
}

class FetchWeatherCollectionById extends WeatherEvent {
  final List<int> ids;
  const FetchWeatherCollectionById(this.ids);

  @override
  List<Object> get props => [ids];
}

class FetchWeatherCollectionByLatLon extends WeatherEvent {
  final int lat;
  final int long;

  const FetchWeatherCollectionByLatLon(this.lat, this.long);
  @override
  List<Object> get props => [lat, long];
}
