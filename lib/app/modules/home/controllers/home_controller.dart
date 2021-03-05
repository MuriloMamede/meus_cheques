import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meuscheques/app/data/model/bank_model.dart';
import 'package:meuscheques/app/repository/bank_repository.dart';

class HomeController extends GetxController {
  BankRepository _bankRepository = BankRepository();

  final banksList = <Bank>[].obs;
  List<Bank> get banks => banksList;

  void saveBank() async {
    
  }

  @override
  void onInit() async {
    banksList.bindStream(await _bankRepository.getBanks());
    super.onInit();
  }
}
