import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/src/api/open_weather_client.dart';
import 'package:weather_app/src/bloc/bloc.dart';
import 'package:weather_app/src/bloc/weather_bloc.dart';
import 'package:weather_app/src/model/supported_citys.dart';
import 'package:weather_app/src/repository/weatherRepository.dart';
import 'package:weather_app/src/ui/screens/local_picker.dart';
import 'package:weather_app/src/ui/screens/settings.dart';
import 'package:weather_app/src/ui/screens/weather_screen.dart';
import 'package:weather_app/src/util/constants.dart';

import 'src/ui/theme/theme.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyApp();
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeData theme = Themes.getTheme(0);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ACK Weather',
      debugShowCheckedModeBanner: false,
      theme: this.theme,
      home: MyHomePage(
        title: 'ACK Weather  ',
        updateTheme: (ThemeData data) {
          setState(() {
            this.theme = data;
          });
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.updateTheme}) : super(key: key);

  final String title;
  final Function updateTheme;

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

  @override
  void initState() {
    super.initState();
    bloc = WeatherBloc(widget.weatherRepo, new List());
    _loadState();
  }

  _loadState() async {
    SupportedCitys.loadCitys();
    preferences = await SharedPreferences.getInstance();
    widget.updateTheme(
        Themes.getTheme(preferences.getInt(Constants.PREFS_THEME)));
    position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    if (position == null)
      position = await Geolocator()
          .getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);

    city = City.fromPosition(position.latitude, position.longitude);

    _loadWeather();
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
                  builder: (context) =>
                      Settings(onThemeDataChange: widget.updateTheme),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              bool useGoogleMaps =
                  preferences.getBool(Constants.LOCATION_PICKER_BOOL);
              if (useGoogleMaps == null) useGoogleMaps = true;
              if (useGoogleMaps) {
                LocationPicker.pickLocation(
                  context,
                  "AIzaSyADLxOw8IbWrGne5PaE7Zz59Z3CqguGhh0",
//                      mapStylePath: 'assets/mapStyle.json',
                  myLocationButtonEnabled: true,
                  layersButtonEnabled: true,
                ).then((LocationResult result) {
                  setState(() {
                    city = City.fromPosition(
                        result.latLng.latitude, result.latLng.longitude);
                    _loadWeather();
                  });
                });
              } else
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
      body: Container(
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
                // Logger().d("WeatherLoaded", state);
                //this.weathers.add(state.weather);
                return WeatherScreen(
                  day: "Sunday, 16 December 2019",
                  weather: state.weather,
                  prefs: preferences,
                );
              }
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              );
            }),
        alignment: Alignment.center,
      ),
    );
  }
}
