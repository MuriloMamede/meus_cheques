import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:meuscheques/app/data/model/account_filter.dart';
import 'package:meuscheques/app/data/model/filtro_model.dart';
import 'package:meuscheques/app/data/model/status_selected_filter.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'dart:math' as math;
import '../../../data/model/bank_model.dart';
import '../../../data/model/bank_account_model.dart';
import '/app/data/model/cheque_model.dart';
import '/app/data/model/user_model.dart';
import '/app/data/provider/bank_account_provider.dart';
import '/app/data/provider/cheque_provider.dart';
import '/app/data/provider/login_provider.dart';
import '/app/global/constants.dart';
import '/app/modules/home/views/widgets/account_list_tile.dart';

class HomeController extends GetxController {
  final BankAccountProvider _bankAccountProvider = BankAccountProvider();
  final ChequeProvider _chequeProvider = ChequeProvider();
  final Rx<GlobalKey<SideMenuState>> sideMenuKey =
      Rx<GlobalKey<SideMenuState>>(GlobalKey<SideMenuState>());
  List<PopupMenuItem<BankAccount>> accountItens = [];
  List<PopupMenuItem<String>> statusList = [];
  List<PopupMenuItem<DateTime>> monthItens = [];
  final LoginProvider _loginProvider = LoginProvider();
  final accountsList = <BankAccount>[].obs;
  List<BankAccount> get accounts => accountsList;
  UserModel get user => LoginProvider.userModel;

  Rx<Bank> selectedBank =
      Rx<Bank>(const Bank(bankNumber: -1, name: 'Selecione'));

  var selectedChequeStatus = 'Emitido'.obs;
  var selectedStatus = 'Emitido'.obs;
  var chequeAccountSelected = BankAccount().obs;
  final String titleContaFinal = 'Selecione Conta';
  var titleBanco = 'Selecione Banco'.obs;
  var titleConta = 'Todas Contas'.obs;
  var accountsSelected = RxList<AccountFilter>();
  var statusSelected = RxList<StatusFilter>();
  RxList<Cheque> cheques = RxList<Cheque>();
  Rx<Filtro> ordenationSelected = Rx<Filtro>(ORDENATION_LIST[0]);
  RxList<Color> colors = RxList<Color>();
  var dateS = ''.obs;

  DateTime date = DateTime.now();

  var finalDate = DateTime.now().obs;
  var initialDate = DateTime.now().obs;

  var selectedAccount = BankAccount().obs;
  var totalCheques = RxDouble(0.0);

  TextEditingController accountNameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController accountAgencyController = TextEditingController();

  TextEditingController chequeDestController = TextEditingController();
  TextEditingController chequeNumberController = TextEditingController();
  TextEditingController chequeValorController = TextEditingController();

  @override
  void onInit() async {
    initialDate.value = DateTime(date.year, date.month, 1);
    finalDate.value = DateTime(date.year, date.month + 1, 0);
    // banksList.assignAll(await _bankProvider.getBanks());
    accountsList
        .assignAll(await _bankAccountProvider.getUserBankAccounts(user.id));

    for (var element in accountsList) {
      colors.add(Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
          .withOpacity(1.0));
      accountsSelected.add(AccountFilter(element, true));
    }
    for (var status in STATUS_LIST) {
      if (status == 'Emitido') {
        statusSelected.add(StatusFilter(status, true));
      } else {
        statusSelected.add(StatusFilter(status, false));
      }
    }

    getCheques();
    accountItensBuilder();
    statusBuilder();
    super.onInit();
  }

  signOut() {
    _loginProvider.signOut();
  }

  void saveAccount() async {
    BankAccount account = BankAccount(
      bank: selectedBank.value,
      accountNumber: int.tryParse(accountNumberController.text) ?? -1,
      accountName: accountNameController.text,
      agency: int.tryParse(accountAgencyController.text) ?? -1,
      user: user,
    );
    account = await _bankAccountProvider.save(account);
    clearControllers();

    accountsList.add(account);
    accountItensBuilder();

    accountsList.refresh();
  }

  removeCheque(Cheque cheque) {
    _chequeProvider.delete(cheque);
    cheques.remove(cheque);
    setTotalCheques();
    cheques.refresh();
    Get.back();
  }

  bool isInDateRange(DateTime date) {
    if (date.millisecondsSinceEpoch >=
            initialDate.value.millisecondsSinceEpoch &&
        date.millisecondsSinceEpoch <= finalDate.value.millisecondsSinceEpoch) {
      return true;
    }
    return false;
  }

  void saveCheque({Cheque? chque}) async {
    BankAccount account = chequeAccountSelected.value;

    Cheque cheque = Cheque(
        account: account,
        destinatario: chequeDestController.text,
        number: chequeNumberController.text,
        value: double.tryParse(chequeValorController.text
                .replaceAll('R\$ ', '')
                .replaceAll('.', '')
                .replaceAll(',', '.')) ??
            0,
        date: date,
        status: selectedChequeStatus.value);

    if (chque != null) {
      cheque.id = chque.id;
    }
    List<Cheque> listCheques = [];
    listCheques = await _chequeProvider.getUserChequesByNumber(
        user.id, cheque.number, account.id);
    if (listCheques.isNotEmpty && chque == null) {
      showSnackBar('Não foi possível salvar',
          'Cheque já cadastrado para  ${dateForm.format(listCheques[0].date)}, na conta ${cheque.account.accountName}');
      return;
    } else {
      cheque = await _chequeProvider.save(cheque);
      if ((isInDateRange(cheque.date) &&
          (cheque.account.id == selectedAccount.value.id ||
              selectedAccount.value.id == '') &&
          cheque.status == selectedStatus.value)) {
        if (chque != null) {
          for (var i = 0; i < cheques.length; i++) {
            if (cheques[i].id == chque.id) {
              cheques[i] = cheque;
              break;
            }
          }

          cheques.refresh();
          setTotalCheques();
        } else {
          cheques.add(cheque);
          cheques.refresh();
          setTotalCheques();
        }
      } else {
        if (chque != null &&
            ((cheque.account.id != selectedAccount.value.id &&
                    selectedAccount.value.id != '') ||
                cheque.status != selectedStatus.value ||
                !isInDateRange(cheque.date))) {
          var index = 0;
          for (var i = 0; i < cheques.length; i++) {
            if (cheques[i].id == chque.id) {
              index = i;
              break;
            }
          }
          cheques.removeAt(index);
          setTotalCheques();
        }
      }
      Get.back();
      showSnackBar('Sucesso',
          'Cheque salvo para o mês ${cheque.date.month}, na conta ${cheque.account.accountName}');
    }
  }

  selectFilterAccount(account) {
    var list = accountsSelected;
    int index = list.indexOf(account);
    list[index].isSelected = !list[index].isSelected;
    list.refresh();
  }

  selectFilterStatus(status) {
    var list = statusSelected;
    int index = list.indexOf(status);
    list[index].isSelected = !list[index].isSelected;
    list.refresh();
  }

  clearControllers() {
    accountNameController.clear();
    accountNumberController.clear();
    accountAgencyController.clear();
    chequeDestController.clear();
    chequeNumberController.clear();
    chequeValorController.clear();
    selectedBank(const Bank(bankNumber: -1, name: 'Selecione'));
    titleBanco('Selecione Banco');
    // dateS("");
  }

  setControllers(Cheque cheque) {
    chequeDestController.text = cheque.destinatario;
    chequeNumberController.text = cheque.number;
    chequeValorController.text =
        cheque.value.toStringAsFixed(2).replaceAll('.', ',');
    date = cheque.date;
    dateS.value =
        DateFormat(DateFormat.YEAR_MONTH_DAY, 'pt_Br').format(cheque.date);
    chequeAccountSelected.value = cheque.account;
    selectedChequeStatus.value = cheque.status;
  }

  setTotalCheques() {
    totalCheques.value = 0;
    if (cheques.isNotEmpty) {
      for (var element in cheques) {
        totalCheques.value += element.value;
      }
    }
  }

  List<PopupMenuEntry<BankAccount>> accountItensBuilder() {
    accountItens.clear();
    accountItens.add(PopupMenuItem<BankAccount>(
        child: const Text('Todas Contas'), value: BankAccount()));
    for (var account in accounts) {
      accountItens.add(PopupMenuItem<BankAccount>(
          child: AccountListTile(
            accountNumber: account.accountNumber.toString(),
            bankName: account.bank.name,
            showIcon: false,
            name: account.accountName ?? '',
          ),
          value: account));
    }

    return accountItens;
  }

  BankAccount getAccount(String id) {
    for (var account in accounts) {
      if (account.id == id) return account;
    }
    return BankAccount();
  }

  int getAccountIndex(account) {
    for (var i = 0; i < accounts.length; i++) {
      if (accounts[i].id == account.id) return i;
    }
    return 0;
  }

  Future<void> getCheques() async {
    List<String> bankAccountIds = [];
    List<String> statusList = [];
    for (var account in accountsSelected) {
      if (account.isSelected) {
        bankAccountIds.add(account.account.id);
      }
    }
    for (var status in statusSelected) {
      if (status.isSelected) {
        statusList.add(status.status);
      }
    }

    cheques(await _chequeProvider.getChequesOrdered(
        user.id,
        initialDate.value,
        finalDate.value,
        bankAccountIds,
        statusList,
        ordenationSelected.value.value));

    return setTotalCheques();
  }

  statusBuilder() {
    for (var status in STATUS_LIST) {
      statusList.add(PopupMenuItem<String>(
        child: Text(status),
        value: status,
      ));
    }
  }
}
