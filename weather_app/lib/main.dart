import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/src/api/open_weather_client.dart';
import 'package:weather_app/src/ui/widgets/main_info.dart';

const double _main_info_margin = 40;
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WeatherApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
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

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final clinet = OpenWeatherAPIClient(httpClient: http.Client());

  void _incrementCounter() {
    setState(() {
      clinet.featchWeather("Porto");
      print("hello");
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: new Center(
                child: Column(
              children: <Widget>[
                MainInfo(info: null, key: null),
              ],
            )),
            margin: EdgeInsets.all(_main_info_margin),
          );
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
