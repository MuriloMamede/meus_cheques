import 'package:cloud_firestore/cloud_firestore.dart';

class Bank {
  num bankNumber;
  String name;
  DocumentReference reference;

  Bank({this.bankNumber,this.name,this.reference});

  factory Bank.fromDocument(DocumentSnapshot doc) {
    return Bank(
      name: doc['name'],
      bankNumber: doc['bankNumber'],
      reference: doc.reference,
    );
  }
}
