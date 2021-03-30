import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meuscheques/app/data/model/cheque_model.dart';
import 'package:meuscheques/app/global/constants.dart';
import 'package:meuscheques/app/provider/database_provider.dart';

class ChequeApiClient {
  final databaseProvider = DataBaseProvider.db;

  Future<List<Cheque>> getCheques(int accountId) async {
    final db = await databaseProvider.database;
    var itens = await db.query(CHEQUE_TABLE,
        columns: [
          CHEQUE_NUMBER,
          CHEQUE_ACCOUNT_ID,
          CHEQUE_VALUE,
          CHEQUE_DATE,
          CHEQUE_STATUS,
        ],
        where: "$CHEQUE_ACCOUNT_ID = ?",
        whereArgs: [accountId]);

    List<Cheque> itemList = List<Cheque>();

    itens.forEach((currentItem) {
      Cheque item = Cheque.fromMap(currentItem);
      itemList.add(item);
    });

    return itemList;
  }

  Future<Cheque> save(Cheque bank) async {
    final db = await databaseProvider.database;
    try {
      await db.insert(CHEQUE_TABLE, bank.toMap());
      return bank;
    } catch (e) {
      return null;
    }
  }

  Future<int> delete(int chequeNumber, int accountId) async {
    final db = await databaseProvider.database;

    return await db.delete(
      CHEQUE_TABLE,
      where: "$CHEQUE_NUMBER = ? and $CHEQUE_ACCOUNT_ID = ?",
      whereArgs: [chequeNumber, accountId],
    );
  }

  Future<int> edit(Cheque cheque) async {
    final db = await databaseProvider.database;

    return await db.update(
      CHEQUE_TABLE,
      cheque.toMap(),
      where: "$CHEQUE_NUMBER = ? and $CHEQUE_ACCOUNT_ID = ?",
      whereArgs: [cheque.number, cheque.accountId],
    );
  }
}
