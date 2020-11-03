import 'package:anticorona/data/ThisColors.dart';
import 'package:flutter/material.dart';

class WidgetsLib {
  Widget arabicText(String label, Color textColor, double textSize,
      FontWeight fontWeight, Alignment alignment) {
    return Align(
      alignment: alignment,
      child: Text(
        label,
        textDirection: TextDirection.rtl,
        style: TextStyle(
          color: textColor,
          fontSize: textSize,
          fontWeight: fontWeight,
        ),
      ),
    );
  }

  Widget normalText(String label, Color textColor, double textSize,
      FontWeight fontWeight, Alignment alignment) {
    return Align(
      alignment: alignment,
      child: Text(
        label,
        textDirection: TextDirection.ltr,
        style: TextStyle(
          color: textColor,
          fontSize: textSize,
          fontWeight: fontWeight,
        ),
      ),
    );
  }

  BoxDecoration neumorphism(Color color) {
    return BoxDecoration(
      boxShadow: [
        /*
        BoxShadow(
          color: Colors.grey.withOpacity(0.15),
          offset: Offset(-6.0, -6.0),
          blurRadius: 6.0,
        ),
         */
        BoxShadow(
          color: Colors.black.withOpacity(0.12),
          offset: Offset(6.0, 6.0),
          blurRadius: 6.0,
        ),
      ],
      color: color,
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(
        color: Colors.black.withOpacity(0.12),
        width: 1,
      ),
    );
  }
}
