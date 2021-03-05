import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meuscheques/app/global/constants.dart';


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
      bankAccountReference: doc[CHEQUE_ACCOUNT_REFERENCE],
      date: doc[CHEQUE_DATE].toDate(),
      bankAccountName: doc[CHEQUE_ACCOUNT_NAME],
      number: doc[CHEQUE_NUMBER],
      status: doc[CHEQUE_STATUS],
      value: doc[CHEQUE_VALUE],
      reference: doc.reference,
    );
  }


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      CHEQUE_ACCOUNT_NAME: this.bankAccountName,
      CHEQUE_ACCOUNT_REFERENCE: this.bankAccountReference,
      CHEQUE_DATE: this.date,
      CHEQUE_NUMBER: this.number,
      CHEQUE_STATUS: this.status,
      CHEQUE_VALUE:  this.value,
    };
    return map;
  }
}
