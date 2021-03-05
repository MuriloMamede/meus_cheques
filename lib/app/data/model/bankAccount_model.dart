import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meuscheques/app/data/model/bank_model.dart';
import 'package:meuscheques/app/global/constants.dart';

class BankAccount {

  Bank bank;
  num agency;
  num accountNumber;
  String name;
  
  DocumentReference reference;

  BankAccount({this.name,this.bank, this.accountNumber,this.agency,this.reference});

  factory BankAccount.fromDocument(DocumentSnapshot doc) {
    return BankAccount(
      name: doc[BANK_ACCOUNT_NAME],
      bank: Bank.fromDocument(doc[BANK_ACCOUNT_BANK]),
      accountNumber: doc[BANK_ACCOUNT_NUMBER],
      agency: doc[BANK_ACCOUNT_AGENCY],
      reference: doc.reference,
    );
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      BANK_ACCOUNT_NAME: this.name,
      BANK_ACCOUNT_BANK: this.bank.toMap(),
      BANK_ACCOUNT_NUMBER: this.accountNumber,
      BANK_ACCOUNT_AGENCY: this.agency,
    };
    return map;
  }
}
