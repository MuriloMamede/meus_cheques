import 'package:meuscheques/app/global/constants.dart';


class Cheque {
  
  int accountId;
  int number;
  num value;
  DateTime date;
  String status;

  Cheque({this.accountId,this.date,this.number,this.status,this.value});

  factory Cheque.fromMap(Map<String, dynamic> map) {
    return Cheque(
      accountId: map[CHEQUE_ACCOUNT_ID],
      date: DateTime.fromMillisecondsSinceEpoch(map[CHEQUE_DATE]),
      number: map[CHEQUE_NUMBER],
      status: map[CHEQUE_STATUS],
      value: map[CHEQUE_VALUE],
    );
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      CHEQUE_DATE: this.date.millisecondsSinceEpoch,
      CHEQUE_NUMBER: this.number,
      CHEQUE_STATUS: this.status,
      CHEQUE_VALUE:  this.value,
    };
    if (accountId != null) {
      map[CHEQUE_ACCOUNT_ID] = this.accountId;
    }

    return map;
  }
}
