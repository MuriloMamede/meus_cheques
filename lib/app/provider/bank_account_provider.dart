import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meuscheques/app/data/model/bankAccount_model.dart';
import 'package:meuscheques/app/global/constants.dart';
import 'package:meuscheques/app/provider/database_provider.dart';

class BankAccountApiClient {
  final databaseProvider = DataBaseProvider.db;

  Future<List<BankAccount>> getBanksAccounts(int bankNumber) async {
    final db = await databaseProvider.database;
    var itens = await db.query(
      BANK_ACCOUNT_TABLE,
      columns: [
        BANK_ACCOUNT_ID,
        BANK_ACCOUNT_NAME,
        BANK_ACCOUNT_AGENCY,
        BANK_ACCOUNT_NUMBER,
        ACCOUNT_BANK_NUMBER
      ],
      where: "$ACCOUNT_BANK_NUMBER = ?",
      whereArgs: [bankNumber],
    );

    List<BankAccount> itemList = List<BankAccount>();

    itens.forEach((currentItem) {
      BankAccount item = BankAccount.fromMap(currentItem);
      itemList.add(item);
    });

    return itemList;
  }

  Future<BankAccount> save(BankAccount bankAccount) async {
    final db = await databaseProvider.database;
    try {
      await db.insert(BANK_ACCOUNT_TABLE, bankAccount.toMap());
      return bankAccount;
    } catch (e) {
      if (e.getResultCode() == 2067)
        Get.defaultDialog(title: "Ops..", content: Text('Conta já adicionado'));
      return null;
    }
  }

  Future<int> delete(int id) async {
    final db = await databaseProvider.database;

    return await db.delete(
      BANK_ACCOUNT_TABLE,
      where: "$BANK_ACCOUNT_ID = ?",
      whereArgs: [id],
    );
  }

  Future<int> edit(BankAccount bankAccount) async {
    final db = await databaseProvider.database;
    try {
      return await db.update(
        BANK_ACCOUNT_TABLE,
        bankAccount.toMap(),
        where: "$BANK_ACCOUNT_ID = ?",
        whereArgs: [bankAccount.accountId],
      );
    } catch (e) {
      if (e.getResultCode() == 1555 || e.getResultCode() == 2067)
        Get.defaultDialog(title: "Ops..", content: Text('Conta já adicionado'));
      return null;
    }
  }
}
