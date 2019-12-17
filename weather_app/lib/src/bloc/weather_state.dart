import 'package:equatable/equatable.dart';
import 'package:weather_app/src/model/weather.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();
}

class WeatherInitial extends WeatherState {
  WeatherInitial();
  @override
  List<Object> get props => [];
}

class WeatherLoading extends WeatherState {
  WeatherLoading();
  @override
  List<Object> get props => [];
}

class WeatherLoaded extends WeatherState {
  final Weather weather;
  WeatherLoaded(this.weather);

  @override
  List<Object> get props => [];
}

class WeatherCollectionLoaded extends WeatherState {
  final List<Weather> weathers;
  WeatherCollectionLoaded(this.weathers);

  @override
  List<Object> get props => [weathers];
}

class WeatherError extends WeatherState {
  final String message;

  WeatherError(this.message);
  @override
  List<Object> get props => [message];
}
