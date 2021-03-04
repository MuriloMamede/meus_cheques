import 'package:cloud_firestore/cloud_firestore.dart';


class Cheque {
  
  num number;
  String bankAccountReference;
  String bankAccountName;
  num value;
  DateTime date;
  String status;

  DocumentReference reference;

  Cheque({this.reference,this.bankAccountReference,this.bankAccountName,this.date,this.number,this.status,this.value});

  factory Cheque.fromDocument(DocumentSnapshot doc) {
    return Cheque(
      bankAccountReference: doc['bankAccountReference'],
      date: doc['date'].toDate(),
      bankAccountName: doc['bankAccountName'],
      number: doc['number'],
      status: doc['status'],
      value: doc['value'],
      reference: doc.reference,
    );
  }
}
