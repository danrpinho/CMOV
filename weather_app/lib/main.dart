import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/src/api/open_weather_client.dart';
import 'package:weather_app/src/bloc/bloc.dart';
import 'package:weather_app/src/bloc/weather_bloc.dart';
import 'package:weather_app/src/model/supported_citys.dart';
import 'package:weather_app/src/model/weather.dart';
import 'package:weather_app/src/repository/weatherRepository.dart';
import 'package:weather_app/src/ui/screens/local_picker.dart';
import 'package:weather_app/src/ui/screens/settings.dart';
import 'package:weather_app/src/ui/screens/weather_screen.dart';

import 'src/ui/theme/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WeatherApp',
      theme: Themes.lightTheme,
      home: MyHomePage(
        title: 'ACME Weather ',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  final WeatherRepository weatherRepo = WeatherRepository(
      client: OpenWeatherAPIClient(httpClient: http.Client()));

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  dynamic cityNumber = 0;
  SharedPreferences preferences;
  WeatherBloc bloc;
  List<Weather> weathers;
  int itemCount = 1;
  Position position;
  List<City> cities;

  void _incrementCounter() {
    setState(() {
      //bloc.add(FetchWeatherById(2735943));
      List<int> ids = [2735943, 2732438];
      bloc.add(FetchWeatherCollectionById(ids));

      //bloc.add(FetchWeatherCollectionByLatLon(41.3, -7.75));
      //bloc.add(FetchWeather("Vila Real"));
      //widget.weatherRepo.getWeather(0, 0, "Porto");
      //print("hello");
    });
  }

  @override
  void initState() {
    //TODO  Fetch Cities
    // TODO From shared preferences
    super.initState();
    _loadState();

    //bloc.add(FetchWeather("Sobrado"));
  }

  _loadState() async {
    cities = await SavedCities.fromSharedPreferences();
    position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    itemCount = SavedCities.savedCities.length;
    bloc = WeatherBloc(widget.weatherRepo);
    //TODO retires ids do var cities e enviar
    List<int> ids = [2735943, 2732438];
    bloc.add(FetchWeatherCollectionById(ids));
    SupportedCitys.loadCitys();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(cityNumber.toString()),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Settings(),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LocalPicker(),
                ),
              ).then((value) {
                setState(() {
                  cities = SavedCities.savedCities;
                  itemCount = cities.length + 1;
                });
              });
            },
          ),
        ],
      ),
      body: new Swiper(
        itemBuilder: (BuildContext context, int index) {
          return BlocBuilder(
              bloc: bloc,
              builder: (context, state) {
                if (state is WeatherLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    ),
                  );
                }
                if (state is WeatherLoaded) {
                  return WeatherScreen(
                    day: "Sunday, 16 December 2019",
                    weather: state.weather,
                  );
                }
                if (state is WeatherCollectionLoaded) {
                  this.weathers = state.weathers;
                  return WeatherScreen(
                      day: "Sunday, 15 December 2019",
                      weather: this.weathers.elementAt(this.cityNumber));
                }
                return WeatherScreen(day: "Sunday, 15 December 2019");
              });
        },
        pagination: new SwiperPagination(),
        onIndexChanged: (int index) => {
          setState(() {
            this.cityNumber = index;
          })
        },
        itemCount: itemCount,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
