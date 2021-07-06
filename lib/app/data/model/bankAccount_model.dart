import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meuscheques/app/data/model/bank_model.dart';

import 'package:meuscheques/app/data/model/user_model.dart';
import 'package:meuscheques/app/global/constants.dart';

class BankAccount {
  Bank bank;
  int agency;
  int accountNumber;
  String accountName;
  String id;
  UserModel user;

  DocumentReference reference;

  BankAccount(
      {this.accountName,
      this.bank,
      this.accountNumber,
      this.agency,
      this.id,
      this.user,
      this.reference});

  factory BankAccount.fromMap(Map<String, dynamic> map) {
    return BankAccount(
      accountNumber: map[BANK_ACCOUNT_NUMBER],
      accountName: map[BANK_ACCOUNT_NAME],
      agency: map[BANK_ACCOUNT_AGENCY],
      id: map[BANK_ACCOUNT_ID],
      bank: Bank.fromMap(map[ACCOUNT_BANK]),
      user: UserModel.fromJson(map[BANK_ACCOUNT_USER]),
    );
  }

  factory BankAccount.fromDocument(DocumentSnapshot docData) {
    var map = docData.data();
    return BankAccount(
      accountNumber: map[BANK_ACCOUNT_NUMBER],
      accountName: map[BANK_ACCOUNT_NAME],
      agency: map[BANK_ACCOUNT_AGENCY],
      id: map[BANK_ACCOUNT_ID],
      bank: Bank.fromMap(map[ACCOUNT_BANK]),
      user: UserModel.fromJson(map[BANK_ACCOUNT_USER]),
      reference: docData.reference,
    );
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      BANK_ACCOUNT_NAME: this.accountName,
      ACCOUNT_BANK: this.bank.toMap(),
      BANK_ACCOUNT_NUMBER: this.accountNumber,
      BANK_ACCOUNT_AGENCY: this.agency,
      BANK_ACCOUNT_USER: this.user.toJson(),
    };
    if (id != null) map[BANK_ACCOUNT_ID] = this.id;
    return map;
  }
}
