import 'package:flutter/material.dart';
import 'package:meuscheques/app/theme/colors.dart';

final ThemeData appThemeData = ThemeData(
  primaryColor: primaryColor,
  primarySwatch: primaryColor,
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    titleMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    bodyLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.normal,
      color: Colors.black,
    ),
    bodyMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: Colors.black,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: Colors.black,
    ),
  ),
  brightness: Brightness.light,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryColor, foregroundColor: Colors.white),
  appBarTheme: const AppBarTheme(
    actionsIconTheme: IconThemeData(color: Colors.white),
    color: primaryColor,
    titleTextStyle:
        TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'roboto'),
  ),
  colorScheme: ThemeData().colorScheme.copyWith(
        primary: secondaryColor,
      ),
);
