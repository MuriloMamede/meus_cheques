import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meuscheques/app/data/model/bankAccount_model.dart';
import 'package:meuscheques/app/data/model/bank_model.dart';
import 'package:meuscheques/app/data/model/cheque_model.dart';
import 'package:meuscheques/app/provider/bank_provider.dart';
import 'package:meuscheques/app/repository/bankAccount_repository.dart';
import 'package:meuscheques/app/repository/bank_repository.dart';
import 'package:meuscheques/app/repository/cheque_repository.dart';

class HomeController extends GetxController {
  BankRepository _bankRepository = BankRepository();
  BankAccountRepository _bankAccountRepository = BankAccountRepository();
  ChequeRepository _chequeRepository = ChequeRepository();

  final banksList = <Bank>[].obs;
  List<Bank> get banks => banksList;
  List<PopupMenuItem<String>> bankItens = [];
  final accountsList = <BankAccount>[].obs;
  List<BankAccount> get accounts => accountsList;
  var bankSelected = ''.obs;
  var titleBanco = 'Selecione Banco'.obs;
  final chequesList = <Cheque>[].obs;
  List<Cheque> get cheques => chequesList;
  TextEditingController accountNameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController accountAgencyController = TextEditingController();

  void saveAccount() async {
    BankAccount account = BankAccount(
      accountNumber: int.tryParse(accountNumberController.text),
      accountName: accountNameController.text,
      bankNumber: int.tryParse(bankSelected.value),
      agency: int.tryParse(accountAgencyController.text),
    );
    account = await _bankAccountRepository.save(account);
    clearControllers();
    if (account != null) {
      accountsList.add(account);
    }
    accountsList.refresh();

    //Cheque cheque = Cheque(bankAccountName: accounts[0].name, bankAccountReference: accounts[0].reference.id, value: 1000, date: DateTime.now(), status: 'Emitido' );
    //_chequeRepository.save(cheque);
  }

  clearControllers() {
    accountNameController.clear();
    accountNumberController.clear();
    accountAgencyController.clear();
    titleBanco('Selecione Banco');
    bankSelected('');
  }

  List<PopupMenuEntry<String>> bankItensBuilder() {
    for (var bank in banks) {
      bankItens.add(PopupMenuItem<String>(
        child: Text(bank.name),
        value: bank.bankNumber.toString(),
      ));
    }

    return bankItens;
  }

  String getBankName(int bankNumber) {
    for (var bank in banks) {
      if (bank.bankNumber == bankNumber) return bank.name;
    }
    return '';
  }

  @override
  void onInit() async {
    banksList.assignAll(await _bankRepository.getBanks());
    accountsList.assignAll(await _bankAccountRepository.getBanksAccounts(1));

    bankItensBuilder();
    //chequesList.bindStream(await _chequeRepository.getCheques(accountReference))
    super.onInit();
  }
}
