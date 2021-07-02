import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:meuscheques/app/data/model/user_model.dart';
import 'package:meuscheques/app/global/constants.dart';

class BankAccount {
  int bankNumber;
  int agency;
  int accountNumber;
  String accountName;
  String id;
  UserModel user;

  DocumentReference reference;

  BankAccount(
      {this.accountName,
      this.bankNumber,
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
      bankNumber: map[ACCOUNT_BANK_NUMBER],
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
      bankNumber: map[ACCOUNT_BANK_NUMBER],
      user: UserModel.fromJson(map[BANK_ACCOUNT_USER]),
      reference: docData.reference,
    );
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      BANK_ACCOUNT_NAME: this.accountName,
      ACCOUNT_BANK_NUMBER: this.bankNumber,
      BANK_ACCOUNT_NUMBER: this.accountNumber,
      BANK_ACCOUNT_AGENCY: this.agency,
      BANK_ACCOUNT_USER: this.user.toJson(),
    };
    if (id != null) map[BANK_ACCOUNT_ID] = this.id;
    return map;
  }
}
