import 'package:intl/intl.dart';

enum TemperatureUnit { kelvin, celsius, fahrenheit }

class Temperature {
  final double kelvin;

  Temperature(this.kelvin) : assert(kelvin != null);

  //double get kelvin => kelvin;

  double get celsius => kelvin - 273.15;

  double get fahrenheit => kelvin * (9 / 5) - 459.67;

  static int asRadioOption(TemperatureUnit unit) {
    switch (unit) {
      case TemperatureUnit.kelvin:
        return 0;
        break;
      case TemperatureUnit.celsius:
        return 1;
        break;
      case TemperatureUnit.fahrenheit:
        return 2;
        break;
    }
    return 1;
  }

  static TemperatureUnit fromRadioOption(int option) {
    switch (option) {
      case 0:
        return TemperatureUnit.kelvin;
        break;
      case 1:
        return TemperatureUnit.celsius;
        break;
      case 2:
        return TemperatureUnit.fahrenheit;
        break;
    }
    return TemperatureUnit.celsius;
  }

  double as(TemperatureUnit unit) {
    switch (unit) {
      case TemperatureUnit.kelvin:
        return this.kelvin;
        break;
      case TemperatureUnit.celsius:
        return this.celsius;
        break;
      case TemperatureUnit.fahrenheit:
        return this.fahrenheit;
        break;
    }
    return this.fahrenheit;
  }

  String tempToString(TemperatureUnit unit) {
    switch (unit) {
      case TemperatureUnit.kelvin:
        return this.kelvin.round().toString() + ' K';
        break;
      case TemperatureUnit.celsius:
        return this.celsius.round().toString() + ' º';
        break;
      case TemperatureUnit.fahrenheit:
        return this.fahrenheit.round().toString() + ' ºF';
        break;
    }
    return this.celsius.round().toString() + ' º';
  }
}

int2Double(dynamic val) {
  if (val.runtimeType == double) {
    return val;
  } else if (val.runtimeType == int) {
    return val.toDouble();
  } else {
    throw new Exception("value is not of type 'int' or 'double' got type '" +
        val.runtimeType.toString() +
        "'");
  }
}

class TimeConverter {
  static millisecondsSinceEpochToDay(int time) {
    return DateFormat.yMMMMEEEEd()
        .format(DateTime.fromMillisecondsSinceEpoch(time * 1000))
        .toString();
  }

  static millisecondsSinceEpochToWeekdayHour(int time) {
    return DateFormat('E, ha')
        .format(DateTime.fromMillisecondsSinceEpoch(time * 1000))
        .toString();
  }

  static millisecondsSinceEpochToHourMinutes(int time) {
    return DateFormat('h:m a')
        .format(DateTime.fromMillisecondsSinceEpoch(time * 1000))
        .toString();
  }
}
