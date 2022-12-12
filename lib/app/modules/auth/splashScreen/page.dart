import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meuscheques/app/theme/colors.dart';
import 'package:meuscheques/app/theme/images.dart';
import 'controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    String image = '';
    if (isDarkMode) {
      image = logoDarkMode;
    } else {
      image = logoLightMode;
    }
    return Scaffold(
      backgroundColor: splashScreenColor,
      body: Align(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                width: 232,
                child: Image.asset(image, fit: BoxFit.fitWidth),
              ),
            ],
          ),
        ),
        alignment: Alignment.center,
      ),
    );
  }
}
