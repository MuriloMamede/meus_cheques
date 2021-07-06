import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:meuscheques/app/data/model/user_model.dart';
import 'package:meuscheques/app/global/constants.dart';

class LoginProvider {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  GetStorage box = GetStorage('login_firebase');

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference usuarios =
      FirebaseFirestore.instance.collection(USER_PATH);

  Future<UserModel> saveUser(User user, String name) async {
    if (user.uid != null) {
      UserModel usuario = UserModel.fromAuthUser(user, name);
      await usuarios.doc(user.uid).set(usuario.toJson());
      return usuario;
    }
    return null;
  }

  Future<UserModel> getUserInfos(String uid) async {
    var userDocument = await usuarios.doc(uid).get();

    return UserModel.fromDocument(userDocument);
  }

  // Retorna usuário logado

  // Criar usuário
  Future<User> createUserWithEmailAndPassword(
      String email, String password, String name) async {
    try {
      final currentUser = (await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;

      // Atualizando o nome do usuário
      await currentUser.updateProfile(displayName: name);
      await currentUser.reload();
      print(currentUser.displayName);
      var user = await saveUser(currentUser, name);
      box.write("user", user.toJson());
      return currentUser;
    } catch (e) {
      print(e.code);
      Get.back();
      switch (e.code) {
        case "operation-not-allowed":
          Get.defaultDialog(
              title: "Ops..",
              content: Text("Contas anônimas não estão habilitadas"));
          break;
        case "invalid-password":
          Get.defaultDialog(
              title: "Ops..", content: Text("Sua senha é muito fraca"));
          break;
        case "invalid-email":
          Get.defaultDialog(
              title: "Ops..", content: Text("Seu email é inválido"));
          break;
        case "email-already-exists":
          Get.defaultDialog(
              title: "Ops..",
              content: Text("O e-mail já está em uso em outra conta"));
          break;
        case "invalid-credential":
          Get.defaultDialog(
              title: "Ops..", content: Text("Seu email é inválido"));
          break;
        default:
          Get.defaultDialog(
              title: "Ops..", content: Text("Ocorreu um erro indefinido."));
      }
      return null;
    }
  }

  // Fazer Login
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    try {
      final currentUser = (await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;

      UserModel user = await getUserInfos(currentUser.uid);

      box.write("user", user.toJson());
      return currentUser;
    } catch (e) {
      switch (e.code) {
        case "user-not-found":
          showSnackBar("Ops..", "Usuário ou senha incorretos");
          break;
        case "wrong-password":
          showSnackBar("Ops..", "Usuário ou senha incorretos");
          break;

        case "operation-not-allowed":
          showSnackBar("Ops..", "Este login  não foi permitido.");
          break;
        case "too-many-requests":
          showSnackBar("Ops..",
              "Muitas tentativas de login, tente novamente mais tarde!");
          break;
        case "network-request-failed":
          showSnackBar("Ops..",
              "Verifique sua conexão com a internet e tente novamente.");
          break;
        default:
          showSnackBar("Ops..", e.toString());
          break;
      }
      return null;
    }
  }

  signOut() {
    box.write("user", null);

    return firebaseAuth.signOut();
  }
}
