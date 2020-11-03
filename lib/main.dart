import 'package:flutter/material.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:anticorona/data/ThisColors.dart';
import 'package:anticorona/page/HomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: ThisColors.red,
        primaryColor: ThisColors.red,
        accentColor: ThisColors.red,
        backgroundColor: ThisColors.redWhite,
        brightness: Brightness.light,
      ),
      home: SplashScreen(
        'assets/animation/splash.flr',
        (context) => HomePage(title: 'Home Page'),
        until: () => Future.delayed(Duration(seconds: 0)),
        startAnimation: 'animation',
        fit: BoxFit.cover,
        backgroundColor: ThisColors.redWhite,
      ),
    );
  }
}