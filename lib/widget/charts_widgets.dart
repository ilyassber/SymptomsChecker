import 'package:anticorona/data/ThisColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';

class ChartWidget {
  Widget progressLineChart(
      List<double> data, Color lineColor, Color pointColor, double height, double max) {
    return Container(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: new Sparkline(
                      data: data,
                      lineWidth: 1.5,
                      lineColor: lineColor,
                      pointsMode: PointsMode.all,
                      pointColor: pointColor,
                      pointSize: 6.0,
                      fallbackHeight: (height * (data[data.length - 1] / max)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
