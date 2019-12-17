import 'dart:convert' show json;

import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class City {
  int id;
  String name;
  String country;
  double lat;
  double long;

  City(this.id, this.name, this.country, this.lat, this.long);

  City.supportedCitys(int id, String name, String country) {
    this.id = id;
    this.name = name;
    this.country = country;
    this.lat = 0.0;
    this.long = 0.0;
  }

  factory City.fromJson(dynamic json) {
    return City.supportedCitys(
        json['id'] as int, json['name'] as String, json['country'] as String);
  }

  factory City.fromSharedPreferences(dynamic json) {
    return City(
        json['id'] as int,
        json['name'] as String,
        json['country'] as String,
        json['lat'] as double,
        json['long'] as double);
  }

  @override
  String toString() {
    return '$name, $country';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is City && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class SupportedCitys {
  static List<City> citys;

  static loadCitys() async {
    if (citys == null || citys.isEmpty) {
      var cityObjsJson = (json.decode(await rootBundle
          .loadString('lib/assets/json/city.list.min.json'))['tag']) as List;
      cityObjsJson = cityObjsJson
          .where((cityJson) =>
              cityJson['country'] == 'PT' &&
              cityJson['name'].startsWith('Distrito'))
          .toList();
      citys = cityObjsJson.map((cityJson) => City.fromJson(cityJson)).toList();
      print('loaded citys');
    }
  }
}

class SavedCities {
  static int max_size = 10;
  static List<City> savedCities = new List();

  static fromSharedPreferences() async {
    try {
      if (savedCities == null || savedCities.isEmpty) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        print(prefs.getString('SavedCities'));
        var cityObjsJson =
            (json.decode(prefs.getString('SavedCities'))['tag']) as List;

        savedCities = cityObjsJson
            .map((cityJson) => City.fromSharedPreferences(cityJson))
            .toList();
        print('loaded citys');
      }
    } catch (Exception) {
      print('from Shared Preferences empty');
    }
    return savedCities;
  }

  static addCity(City city) {
    if (savedCities == null) savedCities = new List();
    if (savedCities.length < max_size) savedCities.add(city);
    toSharedPreferences();
  }

  static removeCity(int pos) {
    savedCities.removeAt(pos);
    toSharedPreferences();
  }

  static toSharedPreferences() async {
    if (savedCities == null || savedCities.isEmpty) return;
    String startJson = '{\"tag\":[';
    String endJson = ']}';
    String contentJson = '';
    SharedPreferences prefs = await SharedPreferences.getInstance();

    for (City city in savedCities) {
      int id = city.id;
      String name = city.name;
      String country = city.country;
      String lat = city.lat.toStringAsPrecision(10);
      String long = city.long.toStringAsPrecision(10);
      contentJson +=
          '{"id": $id, "name": "$name", "country": "$country", "lat": $lat, "long": $long} ,';
    }
    contentJson = contentJson.substring(0, contentJson.length - 2);
    prefs.setString('SavedCities', startJson + contentJson + endJson);
    return startJson + contentJson + endJson;
  }
}
