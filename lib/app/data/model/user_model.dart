import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meuscheques/app/global/constants.dart';

class UserModel {
  String id;
  String uid;
  String displayName;
  String email;

  DocumentReference reference;

  UserModel({this.displayName, this.email, this.id, this.reference, this.uid});

  factory UserModel.fromDocument(DocumentSnapshot docData) {
    var doc = docData.data();
    return UserModel(
      id: doc[USER_ID],
      displayName: doc[USER_DISPLAY_NAME] == null ? "" : doc[USER_DISPLAY_NAME],
      email: doc[USER_EMAIL],
      uid: doc[USER_UID],
      reference: docData.reference,
    );
  }

  factory UserModel.fromAuthUser(User user, String nome) {
    return UserModel(
      id: user.uid,
      displayName: nome,
      email: user.email,
      uid: user.uid,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> doc) {
    return UserModel(
      id: doc[USER_ID],
      displayName: doc[USER_DISPLAY_NAME],
      email: doc[USER_EMAIL],
      uid: doc[USER_UID],
    );
  }

  Map<String, dynamic> toJson() {
    var json = {
      USER_DISPLAY_NAME: this.displayName,
      USER_ID: this.id,
      USER_UID: this.uid,
      USER_EMAIL: this.email,
    };
    return json;
  }
}
