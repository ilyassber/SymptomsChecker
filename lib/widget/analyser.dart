import 'package:anticorona/data/ThisColors.dart';
import 'package:anticorona/data/Labels.dart';
import 'package:anticorona/model/choice.dart';
import 'package:anticorona/widget/WidgetsLib.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class Analyser {
  WidgetsLib widgetsLib = new WidgetsLib();

  Widget responseWidget(
      BuildContext context, Choice choice, int corner, Function f) {
    return Row(
      children: <Widget>[
        InkWell(
          borderRadius: BorderRadius.circular(20),
          highlightColor: ThisColors.red.withOpacity(0.4),
          onTap: () {
            f(context, choice);
          },
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0x00000000),
                borderRadius: BorderRadius.only(
                  topLeft:
                      Radius.circular((corner == 1 || corner == 3) ? 2 : 20),
                  bottomLeft:
                      Radius.circular((corner == 2 || corner == 3) ? 2 : 20),
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                border: Border.all(
                  width: 1,
                  color: ThisColors.red,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 3,
                  bottom: 3,
                ),
                child: widgetsLib.arabicText(
                  ((choice.type == 2 && choice.intValue == null) ||
                          (choice.type == 3 && choice.dateValue == null))
                      ? choice.choice
                      : (choice.type == 2 && choice.action == 2)
                          ? '${choice.intValue} سم'
                          : (choice.type == 2 && choice.action == 3)
                              ? '${choice.intValue} كلغ'
                              : (choice.type == 3)
                                  ? '${choice.dateValue.year}/${choice.dateValue.month}/${choice.dateValue.day}'
                                  : choice.choice,
                  ThisColors.red,
                  16,
                  FontWeight.normal,
                  Alignment.centerRight,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget textWidget(String text) {
    return Align(
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
          child: widgetsLib.arabicText(
            text,
            ThisColors.blue,
            18,
            FontWeight.normal,
            Alignment.bottomRight,
          ),
        ),
      ),
    );
  }

  Widget greyBtnWidget(BuildContext context, String text, Function f) {
    return Row(
      children: <Widget>[
        InkWell(
          borderRadius: BorderRadius.circular(20),
          highlightColor: Colors.grey.withOpacity(0.4),
          onTap: () {
            f(context);
          },
          child: Align(
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0x00000000),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  width: 1,
                  color: ThisColors.blue.withOpacity(0.5),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 3,
                  bottom: 3,
                ),
                child: widgetsLib.arabicText(
                  text,
                  ThisColors.blue.withOpacity(0.5),
                  16,
                  FontWeight.normal,
                  Alignment.center,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget inputField(BuildContext context, TextEditingController textController,
      double width) {
    return Row(
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: Container(
            width: width,
            decoration: BoxDecoration(
              color: Color(0x00000000),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                width: 1,
                color: ThisColors.red,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                left: 10,
                right: 10,
                top: 5,
                bottom: 5,
              ),
              child: TextField(
                controller: textController,
                maxLines: 1,
                decoration: null,
                cursorColor: ThisColors.blue,
                cursorWidth: 1.5,
                maxLength: 16,
                cursorRadius: Radius.circular(5),
                style: TextStyle(
                  color: ThisColors.blue,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void showIntPicker(BuildContext context, Choice choice, int initial, int min,
      int max, Function f) {
    showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return new NumberPickerDialog.integer(
            minValue: min,
            maxValue: max,
            initialIntegerValue: initial,
            title: widgetsLib.arabicText(Labels.chooseNumber, ThisColors.red,
                16, FontWeight.normal, Alignment.centerRight),
            decoration: BoxDecoration(
              color: ThisColors.redWhite.withOpacity(0.7),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                width: 1,
                color: ThisColors.red.withOpacity(0.7),
              ),
            ),
            cancelWidget: widgetsLib.arabicText(Labels.cancel, ThisColors.red,
                16, FontWeight.bold, Alignment.center),
            confirmWidget: widgetsLib.arabicText(Labels.confirm, ThisColors.red,
                16, FontWeight.bold, Alignment.center),
          );
        }).then((value) {
      f(choice, value);
    });
  }

  Future<Null> selectDate(
      BuildContext context, Choice choice, Function f) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime(1980),
      firstDate: DateTime(1900),
      lastDate: DateTime(2020),
    );
    if (picked != null) {
      f(choice, picked);
    }
  }

  Widget alertBox(BuildContext context) {
    return AlertDialog(
      backgroundColor: ThisColors.redWhite,
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            widgetsLib.arabicText(
              Labels.enterData,
              ThisColors.blue,
              16,
              FontWeight.normal,
              Alignment.centerRight,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: widgetsLib.arabicText(
            Labels.confirm,
            ThisColors.red,
            16,
            FontWeight.bold,
            Alignment.center,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
