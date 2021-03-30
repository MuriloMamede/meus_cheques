import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meuscheques/app/data/model/bank_model.dart';
import 'package:meuscheques/app/global/constants.dart';
import 'package:meuscheques/app/provider/database_provider.dart';

class BankApiClient {
  final databaseProvider = DataBaseProvider.db;

  Future<List<Bank>> getBanks() async {
    final db = await databaseProvider.database;
    var itens = await db.query(BANK_TABLE, columns: [
      BANK_NAME,
      BANK_NUMBER,
    ]);

    List<Bank> itemList = List<Bank>();

    itens.forEach((currentItem) {
      Bank item = Bank.fromMap(currentItem);
      itemList.add(item);
    });

    return itemList;
  }

  void insertBanks() {
    BANCOS.forEach((element) {
      save(Bank.fromMap(element));
    });
  }

  Future<Bank> save(Bank bank) async {
    final db = await databaseProvider.database;
    try {
      await db.insert(BANK_TABLE, bank.toMap());
      return bank;
    } catch (e) {
      if (e.getResultCode() == 1555)
        Get.defaultDialog(title: "Ops..", content: Text('Banco já adicionado'));
      return null;
    }
  }

  Future<int> delete(int id) async {
    final db = await databaseProvider.database;
    try {
      return await db.delete(
        BANK_TABLE,
        where: "$BANK_NUMBER = ?",
        whereArgs: [id],
      );
    } catch (e) {
      return -1;
    }
  }

  Future<int> edit(Bank bank) async {
    final db = await databaseProvider.database;
    try {
      return await db.update(
        BANK_TABLE,
        bank.toMap(),
        where: "$BANK_NUMBER = ?",
        whereArgs: [bank.bankNumber],
      );
    } catch (e) {
      if (e.getResultCode() == 1555)
        Get.defaultDialog(title: "Ops..", content: Text('Banco já adicionado'));
      return -1;
    }
  }
}
