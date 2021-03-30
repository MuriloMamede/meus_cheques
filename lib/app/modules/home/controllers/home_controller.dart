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

  final accountsList = <BankAccount>[].obs;
  List<BankAccount> get accounts => accountsList;

  final chequesList = <Cheque>[].obs;
  List<Cheque> get cheques => chequesList;

  void saveAccount() async {
    BankAccount account = BankAccount(
      accountNumber: 2,
      accountName: 'Conta 1',
      bankNumber: 1,
      agency: 1,
    );
    account = await _bankAccountRepository.save(account);
    accountsList.add(account);
    accountsList.refresh();

    //Cheque cheque = Cheque(bankAccountName: accounts[0].name, bankAccountReference: accounts[0].reference.id, value: 1000, date: DateTime.now(), status: 'Emitido' );
    //_chequeRepository.save(cheque);
  }

  @override
  void onInit() async {
    banksList.assignAll(await _bankRepository.getBanks());
    accountsList.assignAll(await _bankAccountRepository.getBanksAccounts(1));
    saveAccount();
    //chequesList.bindStream(await _chequeRepository.getCheques(accountReference))
    super.onInit();
  }
}
