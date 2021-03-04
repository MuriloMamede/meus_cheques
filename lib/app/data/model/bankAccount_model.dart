import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meuscheques/app/data/model/bank_model.dart';

class BankAccount {

  Bank bank;
  num agency;
  num accountNumber;
  String name;
  
  DocumentReference reference;
  
  BankAccount({this.name,this.bank, this.accountNumber,this.agency,this.reference});

  factory BankAccount.fromDocument(DocumentSnapshot doc) {
    return BankAccount(
      name: doc['name'],
      bank: Bank.fromDocument(doc['bankNumber']),
      accountNumber: doc['accountNumber'],
      agency: doc['agency'],
      reference: doc.reference,
    );
  }
}
