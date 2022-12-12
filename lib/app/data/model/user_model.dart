import 'package:firebase_auth/firebase_auth.dart';
import 'package:meuscheques/app/global/constants.dart';

class UserModel {
  String id;
  String uid;
  String displayName;
  String email;

  UserModel({
    required this.displayName,
    required this.email,
    required this.id,
    required this.uid,
  });

  factory UserModel.fromDocument(Map<String, dynamic> doc) {
    return UserModel(
      id: doc[USER_ID],
      displayName: doc[USER_DISPLAY_NAME] ?? '',
      email: doc[USER_EMAIL],
      uid: doc[USER_UID],
    );
  }

  factory UserModel.fromAuthUser(User user, String nome) {
    return UserModel(
      id: user.uid,
      displayName: nome,
      email: user.email!,
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
      USER_DISPLAY_NAME: displayName,
      USER_ID: id,
      USER_UID: uid,
      USER_EMAIL: email,
    };
    return json;
  }
}
