import 'package:flutter/material.dart';
import 'package:meuscheques/app/theme/colors.dart';

final ThemeData appThemeData = ThemeData(
    primaryColor: primaryColor,
    buttonColor: primaryColor,
    textTheme: TextTheme(bodyText2: TextStyle(color: Colors.black)),
    brightness: Brightness.light,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryColor, foregroundColor: Colors.white),
    accentIconTheme: IconThemeData(color: Colors.white),
    accentColor: accentColor,
    appBarTheme: AppBarTheme(
      actionsIconTheme: IconThemeData(color: Colors.white),
      color: primaryColor,
      textTheme: TextTheme(
        headline6:
            TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'roboto'),
        subtitle1: TextStyle(color: Colors.white),
        bodyText1: TextStyle(color: Colors.white),
      ),
    ));
