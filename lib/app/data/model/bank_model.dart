import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meuscheques/app/global/constants.dart';

class Bank {
  num bankNumber;
  String name;

  Bank({this.bankNumber, this.name});

  factory Bank.fromMap(Map<String, dynamic> doc) {
    return Bank(
      name: doc[BANK_NAME],
      bankNumber: doc[BANK_NUMBER],
    );
  }

  factory Bank.fromDocument(DocumentSnapshot docData) {
    var doc = docData.data();
    return Bank(
      name: doc[BANK_NAME],
      bankNumber: doc[BANK_NUMBER],
    );
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      BANK_NAME: this.name,
      BANK_NUMBER: this.bankNumber,
    };
    if (bankNumber != null) map[BANK_NUMBER] = this.bankNumber;
    return map;
  }
}
