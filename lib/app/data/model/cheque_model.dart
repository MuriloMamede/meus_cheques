import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meuscheques/app/data/model/bankAccount_model.dart';
import 'package:meuscheques/app/data/model/user_model.dart';
import 'package:meuscheques/app/global/constants.dart';

class Cheque {
  BankAccount account;
  String id;
  String destinatario;
  String number;
  num value;
  DateTime date;
  String status;

  DocumentReference reference;

  Cheque({
    this.account,
    this.destinatario,
    this.date,
    this.number,
    this.status,
    this.value,
    this.reference,
    this.id,
  });

  factory Cheque.fromMap(Map<String, dynamic> map) {
    return Cheque(
      account: BankAccount.fromMap(map[CHEQUE_ACCOUNT]),
      date: DateTime.fromMillisecondsSinceEpoch(map[CHEQUE_DATE]),
      number: map[CHEQUE_NUMBER],
      status: map[CHEQUE_STATUS],
      destinatario: map[CHEQUE_DESTINATARIO],
      value: map[CHEQUE_VALUE],
      id: map[CHEQUE_ID],
    );
  }

  factory Cheque.fromDocument(DocumentSnapshot docData) {
    var map = docData.data();
    return Cheque(
      account: BankAccount.fromMap(map[CHEQUE_ACCOUNT]),
      date: DateTime.fromMillisecondsSinceEpoch(map[CHEQUE_DATE]),
      number: map[CHEQUE_NUMBER],
      status: map[CHEQUE_STATUS],
      destinatario: map[CHEQUE_DESTINATARIO],
      value: map[CHEQUE_VALUE],
      reference: docData.reference,
      id: map[CHEQUE_ID],
    );
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      CHEQUE_DATE: this.date.millisecondsSinceEpoch,
      CHEQUE_NUMBER: this.number,
      CHEQUE_STATUS: this.status,
      CHEQUE_DESTINATARIO: this.destinatario,
      CHEQUE_VALUE: this.value,
      CHEQUE_ACCOUNT: this.account.toMap(),
      CHEQUE_ID: this.id
    };

    return map;
  }
}
