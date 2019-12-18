import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/src/api/open_weather_client.dart';
import 'package:weather_app/src/bloc/bloc.dart';
import 'package:weather_app/src/bloc/weather_bloc.dart';
import 'package:weather_app/src/model/supported_citys.dart';
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
      theme: Themes.darkTheme,
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
  SharedPreferences preferences;
  WeatherBloc bloc;
  Position position;
  City city;

  void _incrementCounter() {
    setState(() {
      //List<int> ids = [2735943, 2732438];
      //bloc.add(FetchWeatherCollectionById(ids));
    });
  }

  @override
  void initState() {
    super.initState();
    bloc = WeatherBloc(widget.weatherRepo, new List());
    _loadState();
  }

  _loadState() async {
    position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    if (position == null)
      position = await Geolocator()
          .getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);

    city = City.fromPosition(position.latitude, position.longitude);
    _loadWeather();
    SupportedCitys.loadCitys();
  }

  _loadWeather() {
    if (city != null && city.id != null && city.id > 0)
      bloc.add(FetchWeatherById(city.id));
    else if (city != null && city.long != null && city.lat != null)
      bloc.add(FetchWeatherByLatLon(city.lat, city.long));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
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
                  city = value;
                  _loadWeather();
                });
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: BlocBuilder(
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
                    Logger().d("WeatherLoaded", state);
                    //this.weathers.add(state.weather);
                    return WeatherScreen(
                      day: "Sunday, 16 December 2019",
                      weather: state.weather,
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    ),
                  );
                }),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
