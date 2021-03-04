import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meuscheques/app/data/model/bank_model.dart';

class BankApiClient {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<List<Bank>> getBanks() {
    return firestore
        .collection('Banks')
        .orderBy('id')
        .snapshots()
        .map((QuerySnapshot query) {
      List<Bank> retVal = List();
      query.docs.forEach((element) {
        retVal.add(Bank.fromDocument(element));
      });

      return retVal;
      /*return query.documents.map((doc) {
        return Product.fromDocument(doc);
      }).toList();*/
    });
  }

  Future save(Bank bank) async {
    if (bank.reference == null) {
      firestore.collection('Banks').add({
        'name': Bank.name,
        'id': Bank.id,
      });
    }
  }

  void delete(String id) {
    firestore.collection('Banks').doc(id).delete();
  }

  Future edit(Bank bank) async {
    await bank.reference.updateData({
      'name': bank.name,
      'id': bank.id,
    });
  }
}
