import 'package:intl/intl.dart';

enum TemperatureUnit { kelvin, celsius, fahrenheit }

class Temperature {
  final double _kelvin;

  Temperature(this._kelvin) : assert(_kelvin != null);

  double get kelvin => _kelvin;

  double get celsius => _kelvin - 273.15;

  double get fahrenheit => _kelvin * (9 / 5) - 459.67;

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
