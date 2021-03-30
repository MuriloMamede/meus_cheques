import 'package:meuscheques/app/global/constants.dart';

class BankAccount {

  
  int bankNumber;
  int agency;
  int accountNumber;
  String accountName;
  int accountId;
  

  BankAccount({this.accountName,this.bankNumber, this.accountNumber,this.agency, this.accountId});
    
  

  factory BankAccount.fromMap(Map<String, dynamic> map) {
    return BankAccount(
      accountNumber: map[BANK_ACCOUNT_NUMBER],
      accountName: map[BANK_ACCOUNT_NAME],
      agency: map[BANK_ACCOUNT_AGENCY],
      accountId: map[BANK_ACCOUNT_ID],
      bankNumber: map[ACCOUNT_BANK_NUMBER],
    );
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      BANK_ACCOUNT_NAME: this.accountName,
      ACCOUNT_BANK_NUMBER: this.bankNumber,
      BANK_ACCOUNT_NUMBER: this.accountNumber,
      BANK_ACCOUNT_AGENCY: this.agency,
    };
    if(accountId != null)
    map[BANK_ACCOUNT_ID] = this.accountId;
    return map;
  }
}
