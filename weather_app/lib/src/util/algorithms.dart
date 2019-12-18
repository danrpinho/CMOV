import 'dart:math';

class ListAlgo {
  ListAlgo();

  int avg(List<double> lst) {
    return lst.reduce((a, b) => a + b) ~/ lst.length;
  }

  int max(List<double> lst) {
    return lst.reduce((a, b) => a > b ? a : b).toInt();
  }

  dynamic min(List<dynamic> lst) {
    return lst.reduce((a, b) => a < b ? a : b).toInt();
  }

  dynamic mostCommon(List<dynamic> lst) {
    var counter = 0;
    dynamic common = lst.elementAt(0);

    for (var item in lst) {
      var curr_frequency = countElementsinList(lst, item);
      if (curr_frequency > counter) {
        counter = curr_frequency;
        common = item;
      }
    }
    return common;
  }

  int countElementsinList(List<dynamic> lst, dynamic element) {
    var count = 0;
    lst.forEach((f) => {if (f == element) count += 1});
    return count;
  }
}
