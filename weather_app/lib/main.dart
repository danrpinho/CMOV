import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/src/api/open_weather_client.dart';
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
        itemCount: 3,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.itemCount}) : super(key: key);

  final String title;
  final int itemCount;

  //weather Repository
  final WeatherRepository weatherRepo = WeatherRepository(
      client: OpenWeatherAPIClient(httpClient: http.Client()));
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final WeatherRepository weatherRepo = WeatherRepository(
      client: OpenWeatherAPIClient(httpClient: http.Client()));
  void _incrementCounter() {
    setState(() {
      weatherRepo.getWeather(0, 0, "Porto");
      print("hello");
    });
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
          return WeatherScreen(day: "Sunday, 15 December 2019");
        },
        itemCount: widget.itemCount,
        pagination: new SwiperPagination(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
