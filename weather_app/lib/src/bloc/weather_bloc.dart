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
        //TODO Refractor this logic
        final weather =
            await weatherRepository.getWeatherbyName(event.cityName);

        final s = await weatherRepository.saveWeatherSharedPreferences(
            weather.name, weather);
        final m =
            await weatherRepository.getWeatherSharedPreferences(weather.name);
        // print(m);
        yield WeatherLoaded(weather);
      } on NetworkError {
        yield WeatherError("Error Weather Bloc");
      }
    } else if (event is FetchWeatherById) {
      try {
        final weather = await weatherRepository.getWeatherById(event.id);
        yield (WeatherLoaded(weather));
      } on NetworkError {
        yield WeatherError("Error Weather Bloc");
      }
    } else if (event is FetchWeatherCollectionById) {
      try {
        final weather =
            await weatherRepository.getWeatherCollectionRemote(event.ids);
        yield (WeatherCollectionLoaded(weather));
      } on NetworkError {
        yield WeatherError("Error Weather Bloc");
      }
    }
  }
}
