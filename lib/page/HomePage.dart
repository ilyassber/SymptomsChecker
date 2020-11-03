import 'dart:convert';

import 'package:anticorona/data/Labels.dart';
import 'package:anticorona/data/timeline.dart';
import 'package:anticorona/model/day_stats.dart';
import 'package:anticorona/page/AnalyserPage.dart';
import 'package:anticorona/tools/calc_tools.dart';
import 'package:anticorona/widget/WidgetsLib.dart';
import 'package:anticorona/widget/charts_widgets.dart';
import 'package:flutter/material.dart';
import 'package:anticorona/data/ThisColors.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Constractors

  WidgetsLib widgetsLib = new WidgetsLib();
  Timeline timeline = new Timeline();
  ChartWidget chartWidget = new ChartWidget();
  CalcTools calcTools = new CalcTools();

  // General vars

  List<double> casesData = [];
  List<double> deathsData = [];
  List<double> recoveredData = [];
  double yesterday;
  bool loaded = false;
  DayStats dayStats;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    var statsUrl = 'https://corona.lmao.ninja/countries/morocco';
    var timelineUrl = 'https://corona.lmao.ninja/v2/historical/morocco';
    var statsResponse = await http.get(statsUrl);
    var timelineResponse = await http.get(timelineUrl);
    if (statsResponse.statusCode == 200) {
      var jsonResponse = jsonDecode(statsResponse.body);
      setState(() {
        dayStats = DayStats.fromMap(jsonResponse);
      });
    } else {
      print('Request failed with status: ${statsResponse.statusCode}.');
    }
    if (timelineResponse.statusCode == 200) {
      var jsonResponse = jsonDecode(timelineResponse.body);
      setState(() {
        casesData.addAll(timeline.getLastDaysCases(jsonResponse['timeline']));
        deathsData.addAll(timeline.getLastDaysDeaths(jsonResponse['timeline']));
        recoveredData.addAll(timeline.getLastDaysRecovered(jsonResponse['timeline']));
        yesterday = casesData[casesData.length - 1];
      });
    } else {
      print('Request failed with status: ${timelineResponse.statusCode}.');
    }
    setState(() {
      loaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThisColors.redWhite,
      body: Center(
        child: SafeArea(
          child: (loaded == false)
              ? CircularProgressIndicator()
              : Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width - 20,
                        decoration: widgetsLib.neumorphism(ThisColors.redWhite),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
                          child: Column(
                            children: <Widget>[
                              widgetsLib.arabicText(
                                Labels.cases,
                                ThisColors.blue,
                                16,
                                FontWeight.bold,
                                Alignment.centerRight,
                              ),
                              widgetsLib.normalText(
                                '${dayStats.cases}',
                                ThisColors.blue,
                                20,
                                FontWeight.bold,
                                Alignment.center,
                              ),
                              widgetsLib.arabicText(
                                Labels.deaths,
                                ThisColors.red,
                                16,
                                FontWeight.bold,
                                Alignment.centerRight,
                              ),
                              widgetsLib.normalText(
                                '${dayStats.deaths}',
                                ThisColors.red,
                                16,
                                FontWeight.bold,
                                Alignment.center,
                              ),
                              widgetsLib.arabicText(
                                Labels.recovered,
                                Colors.green,
                                16,
                                FontWeight.bold,
                                Alignment.centerRight,
                              ),
                              widgetsLib.normalText(
                                '${dayStats.recovered}',
                                Colors.green,
                                16,
                                FontWeight.bold,
                                Alignment.center,
                              ),
                              widgetsLib.arabicText(
                                Labels.cpom,
                                ThisColors.blue,
                                16,
                                FontWeight.bold,
                                Alignment.centerRight,
                              ),
                              widgetsLib.normalText(
                                '${dayStats.casesPerOneMillion}',
                                ThisColors.blue,
                                16,
                                FontWeight.bold,
                                Alignment.center,
                              ),
                              widgetsLib.arabicText(
                                Labels.dpom,
                                ThisColors.blue,
                                16,
                                FontWeight.bold,
                                Alignment.centerRight,
                              ),
                              widgetsLib.normalText(
                                '${dayStats.deathsPerOneMillion}',
                                ThisColors.blue,
                                16,
                                FontWeight.bold,
                                Alignment.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width - 20,
                        child: Padding(
                          padding: EdgeInsets.all(0),
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: <Widget>[
                              chartWidget.progressLineChart(deathsData, ThisColors.blue, ThisColors.red, 100, yesterday),
                              chartWidget.progressLineChart(recoveredData, ThisColors.blue, Colors.green, 100, yesterday),
                              chartWidget.progressLineChart(casesData, ThisColors.blue, ThisColors.blue, 100, yesterday),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AnalyserPage()),
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width - 20,
                          decoration:
                              widgetsLib.neumorphism(ThisColors.redWhite),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: widgetsLib.arabicText(
                              Labels.diagnosis,
                              ThisColors.red,
                              22,
                              FontWeight.bold,
                              Alignment.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
