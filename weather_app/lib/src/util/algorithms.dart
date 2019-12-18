class ListAlgo {
  ListAlgo();

  double avg(List<double> lst) {
    return lst.reduce((a, b) => a + b) / lst.length;
  }

  double max(List<double> lst) {
    return lst.reduce((a, b) => a > b ? a : b);
  }

  double min(List<double> lst) {
    return lst.reduce((a, b) => a < b ? a : b);
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

  double rainAverage(List<double> lst) {
    double counter = 0;

    for (double item in lst) {
      if (item != null) counter += item;
    }
    return counter / lst.length;
  }

  int countElementsinList(List<dynamic> lst, dynamic element) {
    var count = 0;
    lst.forEach((f) => {if (f == element) count += 1});
    return count;
  }
}
