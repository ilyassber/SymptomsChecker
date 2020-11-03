import 'package:anticorona/data/Labels.dart';
import 'package:anticorona/data/ThisColors.dart';
import 'package:anticorona/model/check.dart';
import 'package:anticorona/model/choice.dart';
import 'package:anticorona/model/relation.dart';
import 'package:anticorona/model/user.dart';
import 'package:anticorona/page/DetailsPage.dart';
import 'package:anticorona/widget/WidgetsLib.dart';
import 'package:anticorona/widget/analyser.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AnalyserPage extends StatefulWidget {
  AnalyserPage();

  AnalyserPageState createState() => AnalyserPageState();
}

class AnalyserPageState extends State<AnalyserPage> {
  // Constractors

  Analyser analyser = new Analyser();
  WidgetsLib widgetsLib = new WidgetsLib();

  // General Params

  User user;
  List<Check> checks = [];
  Check currentCheck;
  int currentIndex = 0;
  double globalRate = 0;
  int pass = 0;
  TextEditingController textController = TextEditingController();
  bool loaded = false;
  double height;
  double width;

  // Data variables

  String txtValue;
  int intValue;
  double doubleValue;
  DateTime dateValue;

  @override
  void initState() {
    super.initState();
    user = new User(
      key: 0,
      pseudo: "alpha",
      choices: [],
    );
    loadChecks();
  }


  @override
  void dispose() {
    super.dispose();
  }

  void loadChecks() async {
    var url = 'http://206.189.202.38:5000/api/v1/checks/all';
    var response = await http.get(url);
    print(response);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      print(response.body);
      checks.clear();
      checks.addAll(
          List<Check>.from(jsonResponse['data'].map((x) => Check.fromMap(x))));
      setState(() {
        currentCheck = checks[0];
        loaded = true;
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  void goNext() {
    bool next = true;
    while (next) {
      print("next");
      next = false;
      currentIndex++;
      if (currentIndex < checks.length) {
        currentCheck = checks[currentIndex];
        for (int i = 0; i < currentCheck.relations.length; i++) {
          Relation relation = currentCheck.relations[i];
          if (checks[relation.relatedToC].checked == relation.condition) {
            if (relation.relatedToR != null) {
              print("related to ${relation.relatedToR}");
              Choice choice;
              for (int j = 0; j < user.choices.length; j++) {
                if (user.choices[j].key == relation.relatedToR) {
                  print("true");
                  choice = user.choices[j];
                }
              }
              if (choice == null) {
                print("first n");
                next = true;
              } else {
                print("r not null");
                print(choice.toMap());
                if (relation.less != null) {
                  if (choice.intValue > relation.less) {
                    print("less not null");
                    next = true;
                  }
                }
                if (relation.more != null) {
                  if (choice.intValue < relation.more) {
                    print("more not null");
                    next = true;
                  }
                }
              }
            }
          } else {
            print("last n");
            next = true;
          }
        }
      }
    }
    setState(() {
      initVars();
    });
  }

  void goBack() {
    int len = user.choices.length;
    print(len);
    if (len > 0) {
      Choice choice = user.choices[len - 1];
      initUserValue(choice);
      currentCheck = checks[user.choices[len - 1].pkey];
      for (int i = 0; i < currentCheck.choices.length; i++) {
        initChoiceValue(currentCheck.choices[i]);
      }
      currentCheck.checked = false;
      currentIndex = currentCheck.key;
      user.choices.removeAt(len - 1);
      setState(() {});
    }
  }

  void initVars() {
    intValue = null;
    txtValue = null;
    doubleValue = null;
    dateValue = null;
    textController.clear();
  }

  void fillVars() {
  }

  void initChoiceValue(Choice choice) {
    choice.txtValue = null;
    choice.intValue = null;
    choice.doubleValue = null;
    choice.dateValue = null;
  }

  void initUserValue(Choice choice) {
    if (choice.action == 1)
      user.name = null;
    else if (choice.action == 2)
      user.height = null;
    else if (choice.action == 3)
      user.weight = null;
    else if (choice.action == 4) {
      user.birthday = null;
      user.age = null;
    } else if (choice.action == 5) user.gender = null;
  }

  void initVarsValue(Choice choice) {
    intValue = null;
    txtValue = null;
    doubleValue = null;
    dateValue = null;
    if ((choice.action == 1 || choice.action == 5) && choice.txtValue != null)
      txtValue = choice.txtValue;
    if ((choice.action == 2 || choice.action == 3 || choice.action == 4) &&
        choice.intValue != null) intValue = choice.intValue;
    if (choice.action == 4 && choice.dateValue != null)
      dateValue = choice.dateValue;
  }

  void onBackClick(BuildContext context) {
    if (currentIndex > 0) {
      goBack();
    }
  }

  void goHome(BuildContext context) {
    Navigator.pop(context);
  }

  void goToDetails(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailsPage(
          details: currentCheck.situationL,
        ),
      ),
    );
  }

  List<Widget> getResponsesList(BuildContext context, List<Choice> choices) {
    List<Widget> list = [];
    for (int i = 0; i < choices.length; i++) {
      Choice choice = choices[i];
      list.add(
        new Padding(
          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: responseWidgetBuilder(context, choice),
        ),
      );
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ThisColors.redWhite,
      body: SafeArea(
        child: Align(
          alignment: Alignment.center,
          child: (loaded == false)
              ? CircularProgressIndicator()
              : Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: AnimatedContainer(
                        width: (MediaQuery.of(context).size.width /
                                checks.length) *
                            currentIndex,
                        height: 3,
                        color: ThisColors.red,
                        duration: Duration(milliseconds: 300),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: analyser.greyBtnWidget(
                            context, Labels.home, goHome),
                      ),
                    ),
                    Visibility(
                      visible: (currentIndex == 0) ? false : true,
                      child: Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                          child: analyser.greyBtnWidget(
                              context, Labels.backPrevRes, onBackClick),
                        ),
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
                              child: Column(
                                children: <Widget>[
                                  (currentCheck.key == 1)
                                      ? analyser.textWidget(
                                          Labels.getTxtWithName(
                                              currentCheck.situation,
                                              user.name))
                                      : analyser
                                          .textWidget(currentCheck.situation),
                                  Visibility(
                                    visible: (currentCheck.situationL == null)
                                        ? false
                                        : true,
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: GestureDetector(
                                        onTap: () {
                                          goToDetails(context);
                                        },
                                        child: Align(
                                          alignment: Alignment.bottomRight,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Color(0x00000000),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                                top: 5,
                                                bottom: 5,
                                              ),
                                              child: Align(
                                                alignment: Alignment.bottomRight,
                                                child: Text(
                                                  Labels.more_info,
                                                  textDirection: TextDirection.rtl,
                                                  style: TextStyle(
                                                    //decoration: TextDecoration.underline,
                                                    color: ThisColors.blue
                                                        .withOpacity(0.5),
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: getResponsesList(
                                  context, currentCheck.choices),
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

  // Get Data Functions

  void getTxtValueClick(TextEditingController textController) {
    txtValue = textController.text;
  }

  void getIntValueClick(Choice choice, int value) {
    setState(() {
      intValue = value;
      choice.intValue = value;
    });
  }

  void getDoubleValueClick(Choice choice, double value) {
    setState(() {
      doubleValue = value;
      choice.doubleValue = value;
    });
  }

  void getDateValueClick(Choice choice, DateTime date) {
    setState(() {
      DateTime now = DateTime.now();
      dateValue = date;
      choice.dateValue = date;
      intValue = now.year - dateValue.year;
      if (now.month < dateValue.month ||
          (now.month == dateValue.month && now.day < dateValue.day)) {
        intValue--;
      }
      choice.intValue = intValue;
    });
  }

  void getValueByAction(Choice choice) {
    choice.checked = true;
    if (choice.action == 1) {
      txtValue = textController.text;
      choice.txtValue = txtValue;
    } else if (choice.action == 2 || choice.action == 3) {
      choice.intValue = intValue;
    } else if (choice.action == 4) {
      choice.dateValue = dateValue;
      choice.intValue = intValue;
    } else if (choice.action == 5) {
      txtValue = choice.choice;
      choice.txtValue = choice.choice;
    }
  }

  // onClick Action

  void onClickAction(BuildContext context, Choice choice) {
    getValueByAction(choice);
    if (checkValue(choice)) {
      currentCheck.checked = true;
      user.routeAction(choice);
      user.choices.add(choice);
      goNext();
    } else
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return analyser.alertBox(context);
        },
      );
  }

  void onClickType(BuildContext context, Choice choice) {
    if (choice.type == 2 && choice.action == 2) {
      analyser.showIntPicker(context, choice, 165, 0, 300, getIntValueClick);
    } else if (choice.type == 2 && choice.action == 3) {
      analyser.showIntPicker(context, choice, 70, 0, 300, getIntValueClick);
    } else if (choice.type == 3) {
      analyser.selectDate(context, choice, getDateValueClick);
    }
  }

  // Response Widget Builder

  Widget responseWidgetBuilder(BuildContext context, Choice choice) {
    if (choice.type == 1) {
      return analyser.inputField(context, textController, width * (2 / 3));
    } else if (choice.type == 2 || choice.type == 3) {
      return analyser.responseWidget(context, choice, 0, onClickType);
    }
    return analyser.responseWidget(context, choice, 0, onClickAction);
  }

  // Value Check

  bool checkValue(Choice choice) {
    if (choice.action == 1 && textController.text == "") return false;
    if (choice.action == 5 && txtValue == null) return false;
    if ((choice.action == 2 || choice.action == 3 || choice.action == 4) &&
        intValue == null) return false;
    if (choice.action == 4 && dateValue == null) return false;
    return true;
  }
}
