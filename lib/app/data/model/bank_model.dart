import 'package:meuscheques/app/global/constants.dart';

class Bank {
  final num bankNumber;
  final String name;

  const Bank({this.bankNumber = 0, this.name = ''});

  factory Bank.fromMap(Map<String, dynamic> doc) {
    return Bank(
      name: doc[BANK_NAME] ?? '',
      bankNumber: doc[BANK_NUMBER] ?? -1,
    );
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      BANK_NAME: name,
      BANK_NUMBER: bankNumber,
    };
    return map;
  }
}
