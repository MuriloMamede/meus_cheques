import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

NumberFormat numberForm = NumberFormat.currency(locale: 'pt-br', name: '');
DateFormat dateForm = DateFormat('d/M/y', 'pt-br');
DateFormat dateFormddMM = DateFormat(DateFormat.ABBR_MONTH_DAY, 'pt-br');
DateFormat dateFormddMMMyy = DateFormat('yMMMd', 'pt-br');
DateFormat dateFormwddMMyy = DateFormat('E, d/MM/y', 'pt-br');

showSnackBar(String title, String message) => Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white,
      margin: const EdgeInsets.all(15),
    );
