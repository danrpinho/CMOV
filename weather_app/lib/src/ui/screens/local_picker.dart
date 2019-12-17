import 'package:flutter/material.dart';
import 'package:weather_app/src/model/supported_citys.dart';

class LocalPicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var body;
    if (true)
      body = new NormalPicker();
    else
      body = new Container();

    return Scaffold(
      appBar: AppBar(title: Text('Add City')),
      body: body,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          City city = SupportedCitys.citys[_NormalPickerState.selectedCity];
          SavedCities.addCity(city);
          //TODO addcity
          Navigator.pop(context);
        },
        tooltip: 'Add',
        child: Icon(Icons.add),
      ),
    );
  }
}

class NormalPicker extends StatefulWidget {
  @override
  _NormalPickerState createState() => new _NormalPickerState();
}

class _NormalPickerState extends State<NormalPicker> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: listMyWidgets(),
    );
  }

  static dynamic selectedCity = 0;

  notifyCityUpdate(int position) {
    setState(() {
      selectedCity = position;
    });
  }

  listMyWidgets() {
    List<Widget> widgets = new List();
    widgets.add(
      Padding(
        padding: const EdgeInsets.only(top: 15, left: 8, right: 8, bottom: 8),
      ),
    );
    for (int i = 0; i < SupportedCitys.citys.length; i++)
      widgets.add(
        CityOption(
          backgroundColor: Colors.white,
          textColor: Colors.black,
          accentColor: Colors.black,
          city: SupportedCitys.citys[i].toString(),
          value: i,
          updateCity: notifyCityUpdate,
        ),
      );
    widgets.add(
      Padding(
        padding: const EdgeInsets.all(50),
      ),
    );
    return widgets;
  }
}

class CityOption extends StatelessWidget {
  final dynamic backgroundColor;
  final dynamic textColor;
  final dynamic accentColor;
  final dynamic city;
  final dynamic value;
  final Function updateCity;

  const CityOption({
    Key key,
    @required this.backgroundColor,
    @required this.textColor,
    @required this.accentColor,
    @required this.city,
    @required this.value,
    @required this.updateCity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8), topRight: Radius.circular(8)),
        color: this.backgroundColor,
      ),
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            this.city,
            style: TextStyle(color: this.textColor),
          ),
          Radio(
            value: this.value,
            groupValue: _NormalPickerState.selectedCity,
            onChanged: (value) {
              this.updateCity(value);
            },
            activeColor: this.accentColor,
          )
        ],
      ),
    );
  }
}
