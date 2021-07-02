import 'package:flutter/material.dart';

const Color accentColor = Colors.greenAccent;
const Color primaryColor = Colors.green;

LinearGradient get primaryGradient => LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [
        accentColor,
        primaryColor,
        primaryColor,
      ],
    );
