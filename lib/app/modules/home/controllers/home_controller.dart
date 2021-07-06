import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:meuscheques/app/data/model/bankAccount_model.dart';
import 'package:meuscheques/app/data/model/bank_model.dart';
import 'package:meuscheques/app/data/model/cheque_model.dart';
import 'package:meuscheques/app/data/model/user_model.dart';
import 'package:meuscheques/app/data/provider/bank_account_provider.dart';
import 'package:meuscheques/app/data/provider/bank_provider.dart';
import 'package:meuscheques/app/data/provider/cheque_provider.dart';
import 'package:meuscheques/app/global/constants.dart';
import 'package:meuscheques/app/modules/home/views/widgets/account_listTile.dart';
import 'package:meuscheques/app/modules/login/controllers/login_controller.dart';

class HomeController extends GetxController {
  BankProvider _bankProvider = BankProvider();
  BankAccountProvider _bankAccountProvider = BankAccountProvider();
  ChequeProvider _chequeProvider = ChequeProvider();
  LoginController _loginController = LoginController();
  final banksList = <Bank>[].obs;
  List<Bank> get banks => banksList;
  List<PopupMenuItem<Bank>> bankItens = [];
  List<PopupMenuItem<BankAccount>> accountItens = [];
  List<PopupMenuItem<DateTime>> monthItens = [];

  final accountsList = <BankAccount>[].obs;
  List<BankAccount> get accounts => accountsList;
  var bankSelected = Bank().obs;
  var accountSelected = BankAccount().obs;
  final String titleContaFinal = "Selecione Conta";
  var titleBanco = 'Selecione Banco'.obs;
  var titleConta = 'Selecione Conta'.obs;
  var titleMes = DateTime.now().month.obs;
  var titleYear = DateTime.now().year.obs;
  final cheques = <Cheque>[].obs;

  var dateS = ''.obs;

  DateTime date = DateTime.now();
  var selectedMonth = DateTime.now().obs;
  var selectedYear = DateTime.now().obs;
  var selectedDate = DateTime.now().obs;

  GetStorage box = GetStorage('login_firebase');
  UserModel get user => UserModel.fromJson(box.read("user"));

  TextEditingController accountNameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController accountAgencyController = TextEditingController();

  TextEditingController chequeDestController = TextEditingController();
  TextEditingController chequeNumberController = TextEditingController();
  TextEditingController chequeValorController = TextEditingController();

  signOut() {
    _loginController.signOut();
  }

  void saveAccount() async {
    BankAccount account = BankAccount(
      accountNumber: int.tryParse(accountNumberController.text),
      accountName: accountNameController.text,
      bank: bankSelected.value,
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
  }

  void saveCheque() async {
    BankAccount account = accountSelected.value;
    Cheque cheque = Cheque(
        account: account,
        destinatario: chequeDestController.text,
        number: chequeNumberController.text,
        value: double.tryParse(chequeValorController.text
            .replaceAll('R\$ ', '')
            .replaceAll('.', '')
            .replaceAll(',', '.')),
        date: date,
        status: 'Emitido');
    cheque = await _chequeProvider.save(cheque);
    if (cheque != null) {
      cheques.add(cheque);
      cheques.refresh();
    }
  }

  clearControllers() {
    accountNameController.clear();
    accountNumberController.clear();
    accountAgencyController.clear();
    chequeDestController.clear();
    chequeNumberController.clear();
    chequeValorController.clear();
    titleBanco('Selecione Banco');
    dateS("");
    accountSelected(BankAccount());
    titleConta(titleContaFinal);
    bankSelected(Bank());
  }

  List<PopupMenuEntry<Bank>> bankItensBuilder() {
    for (var bank in banks) {
      bankItens.add(PopupMenuItem<Bank>(
        child: Text(bank.name),
        value: bank,
      ));
    }

    return bankItens;
  }

  List<PopupMenuEntry<DateTime>> mesesItensBuilder() {
    for (var i = 1; i <= 12; i++) {
      var mes = DateTime.parse(
          "${selectedYear.value.year}-${i.toString().padLeft(2, '0')}-01");

      monthItens.add(PopupMenuItem<DateTime>(
        child: Text(dateFormMes.format(mes)),
        value: mes,
      ));
    }

    return monthItens;
  }

  List<PopupMenuEntry<BankAccount>> accountItensBuilder() {
    accountItens.clear();

    for (var account in accounts) {
      accountItens.add(PopupMenuItem<BankAccount>(
          child: AccountListTile(
            accountNumber: account.accountNumber.toString(),
            bankName: account.bank.name,
            showIcon: false,
            name: account.accountName,
          ),
          value: account));
    }

    return accountItens;
  }

  BankAccount getAccount(String id) {
    for (var account in accounts) {
      if (account.id == id) return account;
    }
    return null;
  }

  Future<void> getCheques() async {
    selectedDate.value = DateTime.parse(
        "${selectedYear.value.year}-${selectedMonth.value.month.toString().padLeft(2, '0')}-01");
    return cheques(
        await _chequeProvider.getMonthUserCheques(user.id, selectedDate.value));
  }

  @override
  void onInit() async {
    banksList.assignAll(await _bankProvider.getBanks());
    accountsList
        .assignAll(await _bankAccountProvider.getUserBankAccounts(user.id));
    accountItensBuilder();
    getCheques();
    mesesItensBuilder();
    bankItensBuilder();

    super.onInit();
  }
}
