import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meuscheques/app/data/model/cheque_model.dart';
import 'package:meuscheques/app/global/constants.dart';

class ChequeProvider {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference get cheques =>
      FirebaseFirestore.instance.collection(CHEQUE_PATH);

  Future<List<Cheque>> getUserCheques(String idUser) {
    List<Cheque> chequeList = List();

    return cheques
        .where(CHEQUE_ACCOUNT + "." + BANK_ACCOUNT_USER + ".id",
            isEqualTo: idUser)
        .orderBy(CHEQUE_NUMBER)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        chequeList.add(Cheque.fromDocument(doc));
      });
      return chequeList;
    });
  }

  Future<List<Cheque>> getMonthUserCheques(String idUser, DateTime date) {
    List<Cheque> chequeList = List();

    var start = DateTime(date.year, date.month, 1).millisecondsSinceEpoch;
    var end = DateTime(date.year, date.month + 1, 0).millisecondsSinceEpoch;
    return cheques
        .where(CHEQUE_ACCOUNT + "." + BANK_ACCOUNT_USER + ".id",
            isEqualTo: idUser)
        .where(CHEQUE_DATE, isGreaterThanOrEqualTo: start)
        .where(CHEQUE_DATE, isLessThanOrEqualTo: end)
        .orderBy(CHEQUE_DATE)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        chequeList.add(Cheque.fromDocument(doc));
      });
      return chequeList;
    });
  }

  Future<List<Cheque>> getBankAccountCheques(String bankAccountId) {
    List<Cheque> chequeList = List();

    return cheques
        .where(CHEQUE_ACCOUNT + BANK_ACCOUNT_ID, isEqualTo: bankAccountId)
        .orderBy(CHEQUE_NUMBER)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        chequeList.add(Cheque.fromDocument(doc));
      });
      return chequeList;
    });
  }

  Future<Cheque> save(Cheque cheque) async {
    DocumentReference id = cheques.doc();
    cheque.id = id.id;
    id.set(cheque.toMap());
    return cheque;
  }

  Future edit(Cheque cheque) async {
    await cheque.reference.set(cheque.toMap());
  }
  /*final databaseProvider = DataBaseProvider.db;

  Future<List<Cheque>> getCheques(int accountId) async {
    final db = await databaseProvider.database;
    var itens = await db.query(CHEQUE_TABLE,
        columns: [
          CHEQUE_NUMBER,
          CHEQUE_ACCOUNT,
          CHEQUE_VALUE,
          CHEQUE_DATE,
          CHEQUE_STATUS,
        ],
        where: "$CHEQUE_ACCOUNT= ?",
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
      where: "$CHEQUE_NUMBER = ? and $CHEQUE_ACCOUNT = ?",
      whereArgs: [chequeNumber, accountId],
    );
  }

  Future<int> edit(Cheque cheque) async {
    final db = await databaseProvider.database;

    return await db.update(
      CHEQUE_TABLE,
      cheque.toMap(),
      where: "$CHEQUE_NUMBER = ? and $CHEQUE_ACCOUNT = ?",
      whereArgs: [cheque.number, cheque.account.id],
    );
  }*/
}
