import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meuscheques/app/data/model/bank_model.dart';
import 'package:meuscheques/app/global/constants.dart';

class BankApiClient {
  
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<List<Bank>> getBanks() {
    return firestore
        .collection(BANK_PATH)
        .orderBy('name')
        .snapshots()
        .map((QuerySnapshot query) {
      List<Bank> retVal = List();
      query.docs.forEach((element) {
        retVal.add(Bank.fromDocument(element));
      });

      return retVal;
    });
  }

  Future save(Bank bank) async {
    if (bank.reference == null) {
      firestore.collection(BANK_PATH).add(bank.toMap());
    }
  }

  void delete(String id) {
    firestore.collection(BANK_PATH).doc(id).delete();
  }

  Future edit(Bank bank) async {
    await bank.reference.set(bank.toMap());
  }
}
