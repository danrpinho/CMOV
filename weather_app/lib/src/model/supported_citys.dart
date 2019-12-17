import 'dart:convert' show json;

import 'package:flutter/services.dart';

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
  }

  factory City.fromJson(dynamic json) {
    return City.supportedCitys(
        json['id'] as int, json['name'] as String, json['country'] as String);
  }

  @override
  String toString() {
    return 'City{name: $name, country: $country}';
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
    var cityObjsJson = (json.decode(await rootBundle
        .loadString('lib/assets/json/city.list.min.json'))['tag']) as List;
    citys = cityObjsJson.map((cityJson) => City.fromJson(cityJson)).toList();
    return;
  }
}
