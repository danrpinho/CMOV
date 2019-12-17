import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:weather_app/src/model/weatherCollection.dart';
import 'package:weather_app/src/repository/weatherRepository.dart';
import './bloc.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc(this.weatherRepository);

  @override
  WeatherState get initialState => WeatherInitial();

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    yield WeatherLoading();
    if (event is FetchWeather) {
      try {
        final weather =
            await weatherRepository.getWeatherbyName(event.cityName);
        final s = await weatherRepository.saveWeatherSharedPreferences(
            weather.name, weather);

        yield WeatherLoaded(weather);
      } on NetworkError {
        yield WeatherError("Error Weather Bloc");
      }
    }
  }
}
