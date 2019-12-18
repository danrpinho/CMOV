import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ValueTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData iconData;

  ValueTile(this.label, this.value, {this.iconData});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          this.label,
          style: TextStyle(color: Colors.black),
        ),
        SizedBox(
          height: 5,
        ),
        this.iconData != null
            ? Icon(
                iconData,
                color: Colors.black,
                size: 20,
              )
            : EmptyWidget(),
        SizedBox(
          height: 5,
        ),
        Text(
          this.value,
          style: TextStyle(color: Colors.black, fontSize: 15),
        ),
      ],
    );
  }
}

class EmptyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0,
      height: 0,
    );
  }
}
