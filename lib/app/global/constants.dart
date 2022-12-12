// ignore_for_file: constant_identifier_names

export 'functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meuscheques/app/data/model/filtro_model.dart';

const String BANK_TABLE = 'banks';
const String BANK_NAME = 'name';
const String BANK_NUMBER = 'number';

const String BANK_ACCOUNT_PATH = 'bankAccounts';
const String BANK_ACCOUNT_ID = 'id';
const String BANK_ACCOUNT_NAME = 'accountName';
const String BANK_ACCOUNT_AGENCY = 'agency';
const String BANK_ACCOUNT_NUMBER = 'accountNumber';
const String BANK_ACCOUNT_USER = 'accountUser';
const String ACCOUNT_BANK = 'bank';

const USER_PATH = 'users';
const STATUS_LIST = [
  'Emitido',
  'Valor Depositado',
  'Compensado',
  'Baixado',
  'Sustado',
];


// ignore: non_constant_identifier_names
List<Filtro> ORDENATION_LIST = [
  Filtro('Data compesação menor', 'date_asc'),
  Filtro('Data compesação maior', 'date_desc'),
  Filtro('Destinatário A-Z', 'name_asc'),
  Filtro('Destinatário Z-A', 'name_desc'),
  Filtro('Número maior', 'value_desc'),
  Filtro('Número menor', 'value_asc'),
];

const USER_ID = 'id';
const USER_UID = 'uid';
const USER_DISPLAY_NAME = 'displayName';
const USER_PERMISSAO = 'permissao';
const USER_EMAIL = 'email';

const String CHEQUE_PATH = 'cheques';
const String CHEQUE_NUMBER = 'chequeNumber';
const String CHEQUE_ACCOUNT = 'account';
const String CHEQUE_ID = 'id';
const String CHEQUE_VALUE = 'value';
const String CHEQUE_DATE = 'date';
const String CHEQUE_STATUS = 'status';
const String CHEQUE_DESTINATARIO = 'destinatario';

const List<Map<String, dynamic>> BANCOS = [
  {'number': 001, 'name': 'Banco do Brasil'},
  {'number': 004, 'name': 'Banco do Nordeste'},
  {'number': 104, 'name': 'Caixa Econômica Federal'},
  {'number': 341, 'name': 'Banco Itaú'},
  {'number': 036, 'name': 'Banco Bradesco'},
  {'number': 033, 'name': 'Banco Santander'},
  {'number': 318, 'name': 'Banco BMG'},
  {'number': 208, 'name': 'Banco BTG Pactual'},
  {'number': 025, 'name': 'Banco Alfa'},
  {'number': 745, 'name': 'Citibank'},
  {'number': 707, 'name': 'Banco Daycoval'},
  {'number': 074, 'name': 'Banco Safra'},
  {'number': 249, 'name': 'Banco Unibanco'},
  {'number': 655, 'name': 'Banco Votorantim'},
];

errorDialog(String msg) {
  return Get.defaultDialog(title: 'Atenção..', content: Text(msg));
}
