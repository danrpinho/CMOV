class Weather {
  String name;
  int cityId;
  //int weatherId;

  Weather({this.cityId, this.name});

  static Weather mapFromJson(Map<String, dynamic> json) {
    return Weather(cityId: json['id'], name: json['name']);
  }
}
