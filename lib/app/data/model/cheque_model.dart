import 'package:meuscheques/app/data/model/bank_account_model.dart';
import 'package:meuscheques/app/global/constants.dart';

class Cheque {
  BankAccount account;
  String? id;
  String destinatario;
  String number;
  num value;
  DateTime date;
  String status;

  Cheque({
    required this.account,
    required this.destinatario,
    required this.date,
    required this.number,
    required this.status,
    required this.value,
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

  factory Cheque.fromDocument(Map<String, dynamic> map) {
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

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      CHEQUE_DATE: date.millisecondsSinceEpoch,
      CHEQUE_NUMBER: number,
      CHEQUE_STATUS: status,
      CHEQUE_ACCOUNT: account.toMap(),
      CHEQUE_DESTINATARIO: destinatario,
      CHEQUE_VALUE: value,
      CHEQUE_ID: id
    };

    return map;
  }
}
