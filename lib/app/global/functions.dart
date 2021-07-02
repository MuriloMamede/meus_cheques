import 'package:flutter/material.dart';
import 'package:get/get.dart';

showSnackBar(String title, String message) => Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(15),
    );
