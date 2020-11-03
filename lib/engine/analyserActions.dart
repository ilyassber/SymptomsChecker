import 'package:anticorona/model/choice.dart';

class AnalyserActions {

  void getIntValue(Choice choice, int num) {
    choice.intValue = num;
  }

  void getTxtValue(Choice choice, String txt) {
    choice.txtValue = txt;
  }

  void getDoubleValue(Choice choice, double float) {
    choice.doubleValue = float;
  }

  void getDateValue(Choice choice, DateTime date) {
    choice.dateValue = date;
  }
}