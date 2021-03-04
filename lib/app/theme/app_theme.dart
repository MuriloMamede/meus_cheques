import 'package:flutter/material.dart';

final ThemeData appThemeData = ThemeData(
    primaryColor: Colors.green,
    buttonColor: Colors.green,
    textTheme: TextTheme(bodyText2: TextStyle(color: Colors.black)),
    brightness: Brightness.light,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.green, foregroundColor: Colors.white),
    accentIconTheme: IconThemeData(color: Colors.white),
    accentColor: Colors.greenAccent,
    appBarTheme: AppBarTheme(
      actionsIconTheme: IconThemeData(color: Colors.white),
      color: Colors.green,
      textTheme: TextTheme(
        headline6:
            TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'roboto'),
        subtitle1: TextStyle(color: Colors.white),
        bodyText1: TextStyle(color: Colors.white),
      ),
    ));
