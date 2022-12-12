import 'package:flutter/material.dart';
import 'package:get/get.dart';

warningSnackBar(String title, String message) => Get.snackbar(
      title,
      message,
      backgroundColor: Colors.grey[900],
      snackPosition: SnackPosition.TOP,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(20),
      shouldIconPulse: false,
      icon: const Icon(
        Icons.warning_amber_outlined,
        size: 36.0,
        color: Colors.yellow,
      ),
    );

sucessSnackBar(String title, String message) => Get.snackbar(
      title,
      message,
      backgroundColor: Colors.white,
      snackPosition: SnackPosition.TOP,
      colorText: Colors.black,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(20),
      shouldIconPulse: false,
    );
