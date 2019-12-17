import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/src/api/open_weather_client.dart';
import 'package:weather_app/src/bloc/bloc.dart';
import 'package:weather_app/src/bloc/weather_bloc.dart';
import 'package:weather_app/src/repository/weatherRepository.dart';
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
        title: 'ACME Weather  ',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  final int itemCount = 3;
  SharedPreferences preferences;
  //weather Repository
  final WeatherRepository weatherRepo = WeatherRepository(
      client: OpenWeatherAPIClient(httpClient: http.Client()));
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  dynamic cityNumber = 1;

  WeatherBloc bloc;
  void _incrementCounter() {
    setState(() {
      //widget.weatherRepo.getWeather(0, 0, "Porto");
      //print("hello");
    });
  }

  @override
  void initState() {
    //TODO  Fetch Cities
    // TODO From shared preferences

    super.initState();

    bloc = WeatherBloc(widget.weatherRepo);
    bloc.add(FetchWeather("Porto"));
    //bloc.add(FetchWeather("Sobrado"));
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
            onPressed: () async {},
          )
        ],
      ),
      body: new Swiper(
          itemBuilder: (BuildContext context, int index) {
            return BlocBuilder(
                bloc: bloc,
                builder: (context, state) {
                  if (state is WeatherLoaded) {
                    //TODO  delete for tests purposes
                    print(state.weather);
                    print(state.weather.forecast[0].temp.celsius);

                    print(this.cityNumber);
                    return WeatherScreen(day: "Sunday, 16 December 2019");
                  }
                  return WeatherScreen(day: "Sunday, 15 December 2019");
                });
          },
          itemCount: widget.itemCount,
          pagination: new SwiperPagination(),
          onIndexChanged: (int index) => {
                setState(() {
                  this.cityNumber = index;
                })
              }),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
