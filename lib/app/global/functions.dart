import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

NumberFormat numberForm = NumberFormat.currency(locale: 'pt-br', name: '');
DateFormat dateForm = DateFormat('d/M/y', 'pt-br');
DateFormat dateFormMes = DateFormat('MMMM', 'pt-br');
DateFormat dateFormAno = DateFormat('yyyy', 'pt-br');

showSnackBar(String title, String message) => Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white,
      margin: const EdgeInsets.all(15),
    );
