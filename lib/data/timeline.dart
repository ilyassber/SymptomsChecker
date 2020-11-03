import 'package:date_util/date_util.dart';

class Timeline {
  DateUtil dateUtility = new DateUtil();

  List<double> getLastDaysCases(Map<String, dynamic> map) {
    List<double> data = [];
    int stamp = DateTime.now().microsecondsSinceEpoch;
    int step = 86400 * 1000000;
    int start = stamp - (step * 10);
    for (int i = start; i < stamp; i = i + step) {
      DateTime day = DateTime.fromMicrosecondsSinceEpoch(i);
      print(day);
      double value = double.parse((map['cases']
              ['${day.month}/${day.day}/${day.year - 2000}'])
          .toString());
      data.add(value);
    }
    return data;
  }

  List<double> getLastDaysDeaths(Map<String, dynamic> map) {
    List<double> data = [];
    int stamp = DateTime.now().microsecondsSinceEpoch;
    int step = 86400 * 1000000;
    int start = stamp - (step * 10);
    for (int i = start; i < stamp; i = i + step) {
      DateTime day = DateTime.fromMicrosecondsSinceEpoch(i);
      print(day);
      double value = double.parse((map['deaths']
              ['${day.month}/${day.day}/${day.year - 2000}'])
          .toString());
      data.add(value);
    }
    return data;
  }

  List<double> getLastDaysRecovered(Map<String, dynamic> map) {
    List<double> data = [];
    int stamp = DateTime.now().microsecondsSinceEpoch;
    int step = 86400 * 1000000;
    int start = stamp - (step * 10);
    for (int i = start; i < stamp; i = i + step) {
      DateTime day = DateTime.fromMicrosecondsSinceEpoch(i);
      print(day);
      double value = double.parse((map['recovered']
              ['${day.month}/${day.day}/${day.year - 2000}'])
          .toString());
      data.add(value);
    }
    return data;
  }
}
