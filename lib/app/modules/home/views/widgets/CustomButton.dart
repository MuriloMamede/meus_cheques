import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meuscheques/app/theme/colors.dart';

MaterialButton customButton(
        {String title, Function onPressed, Color color, double borderRadius, double height}) =>
    MaterialButton(
      minWidth: Get.width,
      height: height == null? Get.height * 0.06: Get.height * height,
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(borderRadius != null ? borderRadius : 5)),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
      onPressed: onPressed,
      color: color != null ? color : primaryColor,
    );
