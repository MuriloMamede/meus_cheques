import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meuscheques/app/data/model/bank_account_model.dart';
import 'package:meuscheques/app/global/constants.dart';

class BankAccountProvider {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference get _bankAccounts =>
      FirebaseFirestore.instance.collection(BANK_ACCOUNT_PATH);

  Future<List<BankAccount>> getUserBankAccounts(String idUser) {
    List<BankAccount> bankAccountList = [];
    
    return _bankAccounts
        .where(BANK_ACCOUNT_USER + '.id', isEqualTo: idUser)
        .orderBy(BANK_ACCOUNT_NAME)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        bankAccountList
            .add(BankAccount.fromDocument(doc.data() as Map<String, dynamic>));
      }
      return bankAccountList;
    });
  }

  Future<BankAccount> save(BankAccount bankAccount) async {
    
    DocumentReference id = _bankAccounts.doc();
    bankAccount.id = id.id;
    id.set(bankAccount.toMap());
    return bankAccount;
  }

  Future edit(BankAccount bankAccount) async {
    DocumentReference id;
    if (bankAccount.id == '') {
      id = _bankAccounts.doc();
      bankAccount.id = id.id;
      id.set(bankAccount.toMap());
      return bankAccount;
    } else {
      id = _bankAccounts.doc(bankAccount.id);
      id.set(bankAccount.toMap());
      return bankAccount;
    }
  }
  /* final databaseProvider = DataBaseProvider.db;

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
        errorDialog('Conta Já Existente');
      else
        errorDialog('Não foi possível salvar essa conta');
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
        whereArgs: [bankAccount.id],
      );
    } catch (e) {
      if (e.getResultCode() == 1555 || e.getResultCode() == 2067)
        Get.defaultDialog(title: "Atenção..", content: Text('Conta já adicionado'));
      return null;
    }
  }*/
}
