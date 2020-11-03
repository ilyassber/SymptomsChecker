import 'package:anticorona/data/Labels.dart';
import 'package:anticorona/data/ThisColors.dart';
import 'package:anticorona/widget/WidgetsLib.dart';
import 'package:anticorona/widget/analyser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SummaryPage extends StatefulWidget {
  SummaryPage();

  SummaryPageState createState() => SummaryPageState();
}

class SummaryPageState extends State<SummaryPage> {

  // Constructors

  Analyser analyser = new Analyser();
  WidgetsLib widgetsLib = new WidgetsLib();

  // General Params

  double height;
  double width;
  String details;

  @override
  void initState() {
    super.initState();
  }

  void goBack(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThisColors.redWhite,
      body: SafeArea(
        child: Align(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: analyser.greyBtnWidget(
                      context, Labels.backPrevPage, goBack),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 30),
                        child: analyser.textWidget(details),
                      ),
                    ],
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