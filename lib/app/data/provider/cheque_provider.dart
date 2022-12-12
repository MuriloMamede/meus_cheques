import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meuscheques/app/data/model/cheque_model.dart';
import 'package:meuscheques/app/global/constants.dart';

class ChequeProvider {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference get cheques => firestore.collection(CHEQUE_PATH);

  Future<List<Cheque>> getUserCheques(String idUser) {
    List<Cheque> chequeList = [];

    return cheques
        .where(CHEQUE_ACCOUNT + '.' + BANK_ACCOUNT_USER + '.id',
            isEqualTo: idUser)
        .orderBy(CHEQUE_NUMBER)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        chequeList.add(Cheque.fromDocument(doc.data() as Map<String, dynamic>));
      }
      return chequeList;
    });
  }

  Future<List<Cheque>> getMonthUserCheques(String idUser, DateTime date) {
    List<Cheque> chequeList = [];

    var start = DateTime(date.year, date.month, 1).millisecondsSinceEpoch;
    var end = DateTime(date.year, date.month + 1, 0).millisecondsSinceEpoch;
    return cheques
        .where(CHEQUE_ACCOUNT + '.' + BANK_ACCOUNT_USER + '.id',
            isEqualTo: idUser)
        .where(CHEQUE_DATE, isGreaterThanOrEqualTo: start)
        .where(CHEQUE_DATE, isLessThanOrEqualTo: end)
        .orderBy(CHEQUE_DATE)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        chequeList.add(Cheque.fromDocument(doc.data() as Map<String, dynamic>));
      }
      return chequeList;
    });
  }

  Future<List<Cheque>> getAccountMonthUserCheques(
      String idUser, DateTime date, String bankAccountId) {
    List<Cheque> chequeList = [];

    var start = DateTime(date.year, date.month, 1).millisecondsSinceEpoch;
    var end = date.millisecondsSinceEpoch;
    return cheques
        .where(CHEQUE_ACCOUNT + '.' + BANK_ACCOUNT_USER + '.id',
            isEqualTo: idUser)
        .where(CHEQUE_ACCOUNT + '.' + BANK_ACCOUNT_ID, isEqualTo: bankAccountId)
        .where(CHEQUE_DATE, isGreaterThanOrEqualTo: start)
        .where(CHEQUE_DATE, isLessThanOrEqualTo: end)
        .orderBy(CHEQUE_DATE)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        chequeList.add(Cheque.fromDocument(doc.data() as Map<String, dynamic>));
      }
      return chequeList;
    });
  }

  Future<List<Cheque>> getUserChequesByNumber(
      String idUser, String chequeNumber, String bankAccountId) {
    List<Cheque> chequeList = [];

    return cheques
        .where(CHEQUE_ACCOUNT + '.' + BANK_ACCOUNT_USER + '.id',
            isEqualTo: idUser)
        .where(CHEQUE_ACCOUNT + '.' + BANK_ACCOUNT_ID, isEqualTo: bankAccountId)
        .where(CHEQUE_NUMBER, isEqualTo: chequeNumber)
        .orderBy(CHEQUE_DATE)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        chequeList.add(Cheque.fromDocument(doc.data() as Map<String, dynamic>));
      }
      return chequeList;
    });
  }

  Future<List<Cheque>> getAccountMonthStatusUserCheques(
      String idUser,
      DateTime initialDate,
      DateTime finalDate,
      String bankAccountId,
      String status) {
    List<Cheque> chequeList = [];
    String? accountId;
    if (bankAccountId == '') {
      accountId = null;
    } else {
      accountId = bankAccountId;
    }
    var start = initialDate.millisecondsSinceEpoch;
    var end = finalDate.millisecondsSinceEpoch;
    return cheques
        .where(CHEQUE_ACCOUNT + '.' + BANK_ACCOUNT_USER + '.id',
            isEqualTo: idUser)
        .where(CHEQUE_STATUS, isEqualTo: status)
        .where(CHEQUE_ACCOUNT + '.' + BANK_ACCOUNT_ID, isEqualTo: accountId)
        .where(CHEQUE_DATE, isGreaterThanOrEqualTo: start)
        .where(CHEQUE_DATE, isLessThanOrEqualTo: end)
        .orderBy(CHEQUE_DATE)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        chequeList.add(Cheque.fromDocument(doc.data() as Map<String, dynamic>));
      }
      return chequeList;
    });
  }

  Future<List<Cheque>> getChequesOrdered(
    String idUser,
    DateTime initialDate,
    DateTime finalDate,
    List<String> bankAccountIds,
    List<String> statusList,
    String order,
  ) {
    List<Cheque> chequeList = [];

    var start = initialDate.millisecondsSinceEpoch;
    var end = finalDate.millisecondsSinceEpoch;
    Query<Object?> query = cheques
        .where(CHEQUE_ACCOUNT + '.' + BANK_ACCOUNT_USER + '.id',
            isEqualTo: idUser)
        .where(CHEQUE_DATE, isGreaterThanOrEqualTo: start)
        .where(CHEQUE_DATE, isLessThanOrEqualTo: end);
    //query = query.where(CHEQUE_STATUS, whereIn: statusList);
    //query = query.where(CHEQUE_ACCOUNT + "." + BANK_ACCOUNT_ID, whereIn: bankAccountIds);
    /*for (var status in statusList) {
      query = query.where(CHEQUE_STATUS, isEqualTo: status);
    }
    for (var bankAccountID in bankAccountIds) {
      query = query.where(CHEQUE_ACCOUNT + "." + BANK_ACCOUNT_ID,
          isEqualTo: bankAccountID);
    }*/
    return query.get().then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        chequeList.add(Cheque.fromDocument(doc.data() as Map<String, dynamic>));
      }
      chequeList = applyStatusFilter(chequeList, statusList);
      chequeList = applyAccountFilter(chequeList, bankAccountIds);
      chequeList = applyOrdernation(chequeList, order);
      return chequeList;
    });
  }

  List<Cheque> applyStatusFilter(
      List<Cheque> chequeList, List<String> statusList) {
    List<Cheque> tempChequeList = [];
    for (var cheque in chequeList) {
      for (var status in statusList) {
        if (cheque.status == status) {
          tempChequeList.add(cheque);
        }
      }
    }
    return tempChequeList;
  }

  List<Cheque> applyAccountFilter(
      List<Cheque> chequeList, List<String> idAccountList) {
    List<Cheque> tempChequeList = [];
    for (var cheque in chequeList) {
      for (var accountId in idAccountList) {
        if (cheque.account.id == accountId) {
          tempChequeList.add(cheque);
        }
      }
    }
    return tempChequeList;
  }

  List<Cheque> applyOrdernation(List<Cheque> chequeList, String order) {
    switch (order) {
      case 'date_asc':
        chequeList.sort((a, b) => a.date.compareTo(b.date));

        break;
      case 'date_desc':
        chequeList.sort((b, a) => a.date.compareTo(b.date));
        break;
      case 'name_asc':
        chequeList.sort((a, b) => a.destinatario.compareTo(b.destinatario));
        break;
      case 'name_desc':
        chequeList.sort((b, a) => a.destinatario.compareTo(b.destinatario));
        break;
      case 'value_desc':
        chequeList.sort((b, a) => (int.tryParse(a.number) ?? 0)
            .compareTo(int.tryParse(b.number) ?? 0));
        break;
      case 'value_asc':
        chequeList.sort((a, b) => (int.tryParse(a.number) ?? 0)
            .compareTo(int.tryParse(b.number) ?? 0));
        break;
      default:
    }

    return chequeList;
  }

  Future<List<Cheque>> getBankAccountCheques(String bankAccountId) {
    List<Cheque> chequeList = [];

    return cheques
        .where(CHEQUE_ACCOUNT + BANK_ACCOUNT_ID, isEqualTo: bankAccountId)
        .orderBy(CHEQUE_NUMBER)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        chequeList.add(Cheque.fromDocument(doc.data() as Map<String, dynamic>));
      }
      return chequeList;
    });
  }

  Future<Cheque> save(Cheque cheque) async {
    DocumentReference id;
    if (cheque.id == null) {
      id = cheques.doc();
      cheque.id = id.id;
      id.set(cheque.toMap());
      return cheque;
    } else {
      id = cheques.doc(cheque.id);
      id.set(cheque.toMap());
      return cheque;
    }
  }

  Future<Cheque> edit(Cheque cheque) async {
    DocumentReference id;
    if (cheque.id == null) {
      id = cheques.doc();
      cheque.id = id.id;
      id.set(cheque.toMap());
      return cheque;
    } else {
      id = cheques.doc(cheque.id);
      id.set(cheque.toMap());
      return cheque;
    }
  }

  Future delete(Cheque cheque) async {
    await cheques.doc(cheque.id).delete();
  }
}
