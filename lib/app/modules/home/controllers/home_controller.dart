import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:meuscheques/app/data/model/bankAccount_model.dart';
import 'package:meuscheques/app/data/model/bank_model.dart';
import 'package:meuscheques/app/data/model/cheque_model.dart';
import 'package:meuscheques/app/data/model/user_model.dart';
import 'package:meuscheques/app/modules/home/views/widgets/account_listTile.dart';
import 'package:meuscheques/app/modules/login/controllers/login_controller.dart';
import 'package:meuscheques/app/provider/bank_account_provider.dart';
import 'package:meuscheques/app/provider/bank_provider.dart';
import 'package:meuscheques/app/provider/cheque_provider.dart';

class HomeController extends GetxController {
  BankProvider _bankProvider = BankProvider();
  BankAccountProvider _bankAccountProvider = BankAccountProvider();
  ChequeProvider _chequeProvider = ChequeProvider();
  LoginController _loginController = LoginController();
  final banksList = <Bank>[].obs;
  List<Bank> get banks => banksList;
  List<PopupMenuItem<String>> bankItens = [];
  List<PopupMenuItem<BankAccount>> accountItens = [];
  final accountsList = <BankAccount>[].obs;
  List<BankAccount> get accounts => accountsList;
  var bankSelected = ''.obs;
  var accountSelected = BankAccount().obs;
  final String titleContaFinal = "Selecione Conta";
  var titleBanco = 'Selecione Banco'.obs;
  var titleConta = 'Selecione Conta'.obs;
  final chequesList = <Cheque>[].obs;

  GetStorage box = GetStorage('login_firebase');
  UserModel get user => UserModel.fromJson(box.read("user"));

  List<Cheque> get cheques => chequesList;
  TextEditingController accountNameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController accountAgencyController = TextEditingController();

  signOut() {
    _loginController.signOut();
  }

  void saveAccount() async {
    BankAccount account = BankAccount(
      accountNumber: int.tryParse(accountNumberController.text),
      accountName: accountNameController.text,
      bankNumber: int.tryParse(bankSelected.value),
      agency: int.tryParse(accountAgencyController.text),
      user: user,
    );
    account = await _bankAccountProvider.save(account);
    clearControllers();
    if (account != null) {
      accountsList.add(account);
      accountItensBuilder();
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
    accountSelected(null);
    titleConta(titleContaFinal);
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

  List<PopupMenuEntry<BankAccount>> accountItensBuilder() {
    accountItens.clear();

    for (var account in accounts) {
      accountItens.add(PopupMenuItem<BankAccount>(
          child: AccountListTile(
            accountNumber: account.accountNumber.toString(),
            bankName: getBankName(account.bankNumber),
            showIcon: false,
            name: account.accountName,
          ),
          value: account));
    }

    return accountItens;
  }

  String getBankName(int bankNumber) {
    for (var bank in banks) {
      if (bank.bankNumber == bankNumber) return bank.name;
    }
    return '';
  }

  BankAccount getAccount(String id) {
    for (var account in accounts) {
      if (account.id == id) return account;
    }
    return null;
  }

  @override
  void onInit() async {
    banksList.assignAll(await _bankProvider.getBanks());
    //id do user
    accountsList
        .assignAll(await _bankAccountProvider.getUserBankAccounts(user.id));

    bankItensBuilder();
    accountItensBuilder();
    //chequesList.bindStream(await _chequeRepository.getCheques(accountReference))
    super.onInit();
  }
}
