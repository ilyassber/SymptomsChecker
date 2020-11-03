class CalcTools {

  double getBiggerValue(List<double> list) {
    double value = 0;
    for (int i = 0; i < list.length; i++) {
      if (value < list[i]) value = list[i];
    }
    return value;
  }
}