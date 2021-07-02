export 'functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const String BANK_TABLE = 'banks';
const String BANK_NAME = 'name';
const String BANK_NUMBER = 'number';

const String BANK_ACCOUNT_PATH = 'bankAccounts';
const String BANK_ACCOUNT_ID = 'id';
const String BANK_ACCOUNT_NAME = 'accountName';
const String BANK_ACCOUNT_AGENCY = 'agency';
const String BANK_ACCOUNT_NUMBER = 'accountNumber';
const String BANK_ACCOUNT_USER = 'accountUser';
const String ACCOUNT_BANK_NUMBER = 'bankNumber';

const USER_PATH = "users";

const USER_ID = "id";
const USER_UID = "uid";
const USER_DISPLAY_NAME = "displayName";
const USER_PERMISSAO = "permissao";
const USER_EMAIL = "email";

const String CHEQUE_PATH = 'cheques';
const String CHEQUE_NUMBER = 'chequeNumber';
const String CHEQUE_ACCOUNT = 'account';
const String CHEQUE_ID = 'id';
const String CHEQUE_VALUE = 'value';
const String CHEQUE_DATE = 'date';
const String CHEQUE_STATUS = 'status';
const String CHEQUE_DESTINATARIO = 'destinatario';

const List<Map<String, dynamic>> BANCOS = [
  {"number": 001, "name": "Banco do Brasil"},
  {"number": 004, "name": "Banco do Nordeste"},
  {"number": 104, "name": "Caixa Econômica Federal"},
  {"number": 341, "name": "Banco Itaú"},
  {"number": 036, "name": "Banco Bradesco"},
  {"number": 033, "name": "Banco Santander"},
  {"number": 318, "name": "Banco BMG"},
  {"number": 208, "name": "Banco BTG Pactual"},
  {"number": 025, "name": "Banco Alfa"},
  {"number": 745, "name": "Citibank"},
  {"number": 707, "name": "Banco Daycoval"},
  {"number": 074, "name": "Banco Safra"},
  {"number": 249, "name": "Banco Unibanco"},
  {"number": 655, "name": "Banco Votorantim"},
];

errorDialog(String msg) {
  return Get.defaultDialog(title: 'Ops..', content: Text(msg));
}
