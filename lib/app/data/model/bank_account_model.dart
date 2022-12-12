import 'package:flutter/material.dart';
import 'package:meuscheques/app/data/model/bank_model.dart';
import 'package:meuscheques/app/data/model/user_model.dart';
import 'package:meuscheques/app/global/constants.dart';
import 'dart:math' as math;

class BankAccount {
  Bank bank;
  int agency;
  int accountNumber;
  String? accountName;
  String id;
  UserModel? user;
  Color? labelColor;

  BankAccount({
    this.accountName,
    this.bank = const Bank(),
    this.accountNumber = 0,
    this.agency = 0,
    this.id = '',
    this.user,
    this.labelColor,
  });

  factory BankAccount.fromMap(Map<String, dynamic> map) {
    var account = BankAccount(
      accountNumber: map[BANK_ACCOUNT_NUMBER],
      accountName: map[BANK_ACCOUNT_NAME],
      agency: map[BANK_ACCOUNT_AGENCY],
      id: map[BANK_ACCOUNT_ID],
      bank: Bank.fromMap(map[ACCOUNT_BANK]),
      user: UserModel.fromJson(map[BANK_ACCOUNT_USER]),
    );
    if (map['labelColor'] == null) {
      account.labelColor =
          Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
              .withOpacity(1.0);
    } else {
      account.labelColor = Color(int.parse(map['labelColor']));
    }
    return account;
  }
// labelColor: Color(int.parse(map[LABEL_COLOR])),
  factory BankAccount.fromDocument(Map<String, dynamic> map) {
    var account = BankAccount(
      accountNumber: map[BANK_ACCOUNT_NUMBER],
      accountName: map[BANK_ACCOUNT_NAME],
      agency: map[BANK_ACCOUNT_AGENCY],
      id: map[BANK_ACCOUNT_ID],
      bank: Bank.fromMap(map[ACCOUNT_BANK]),
      user: UserModel.fromJson(map[BANK_ACCOUNT_USER]),
    );
    if (map['labelColor'] == null) {
      account.labelColor =
          Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
              .withOpacity(1.0);
    } else {
      account.labelColor = Color(int.parse(map['labelColor']));
    }
    return account;
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      BANK_ACCOUNT_NAME: accountName,
      BANK_ACCOUNT_NUMBER: accountNumber,
      BANK_ACCOUNT_AGENCY: agency,
      BANK_ACCOUNT_ID: id,
      ACCOUNT_BANK: bank.toMap(),
      'labelColor': labelColor!.value.toString(),
    };
    if (user != null) {
      map[BANK_ACCOUNT_USER] = user!.toJson();
    }
    return map;
  }
}
