import 'package:flutter/material.dart';
import 'package:weather_app/src/model/weather.dart';

class MainInfo extends StatelessWidget{
  final Weather info;
  const MainInfo ({Key key, this.info}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.cloud,
          color: Colors.black,
          size: 45
        ),
        Text( // city
          "PORTO",
          style: TextStyle(
            color: Colors.black,
            fontSize: 50,
            fontWeight: FontWeight.w500,
          )
        ),
        Text( // weather condition
          "Cloudy",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 30,
          ),
        ),
        createTemperatureWidget(info),
      
      ],

    
    
    );
    
  }

  createTemperatureWidget(Weather info) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "13ºC",
          style: TextStyle(
            fontSize: 30, 
            color: Colors.grey
          ),
        ),
        Column (children: <Widget>[
          Text("Max: 18ºC"),
          Text("Min: 9ºC")
        ],)
      ],
    );
  }

}