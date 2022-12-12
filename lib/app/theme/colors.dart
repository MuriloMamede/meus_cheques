import 'package:flutter/material.dart';

const Color accentColor = Colors.green;
const Color secondaryColor = Color(0xff004b20);
const Color splashScreenColor = Color(0xff7ed957);
const Color darkPrimaryColor = Color(0xFF05613f);

const MaterialColor primaryColor = Colors.green;
LinearGradient get primaryGradient => const LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [
        accentColor,
        primaryColor,
        primaryColor,
      ],
    );
