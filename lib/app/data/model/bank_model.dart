import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meuscheques/app/global/constants.dart';

class Bank {
  num bankNumber;
  String name;
  DocumentReference reference;

  Bank({this.bankNumber,this.name,this.reference});

  factory Bank.fromDocument(DocumentSnapshot doc) {
    return Bank(
      name: doc[BANK_NAME],
      bankNumber: doc[BANK_NUMBER],
      reference: doc.reference,
    );
  }

   Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      BANK_NAME: this.name,
      BANK_NUMBER: this.bankNumber,
    };
    return map;
  }
}
