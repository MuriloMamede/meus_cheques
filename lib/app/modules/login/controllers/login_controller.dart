import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meuscheques/app/data/provider/login_provider.dart';
import 'package:meuscheques/app/routes/app_pages.dart';

class LoginController extends GetxController {
  final LoginProvider loginProvider = LoginProvider();
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController nameTextController = TextEditingController();
  Rx<User> firebaseUser = Rx<User>();
  Stream<User> get user => loginProvider.firebaseAuth.authStateChanges();
  var isSenhaVisible = false.obs;
  var senhaCadastroIsVisible = false.obs;
  var senhaConfirmIsVisible = false.obs;

  void register() async {
    User user = await loginProvider.createUserWithEmailAndPassword(
      emailTextController.text,
      passwordTextController.text,
      nameTextController.text,
    );
  }

  void login() async {
    User user = await loginProvider.signInWithEmailAndPassword(
        emailTextController.text, passwordTextController.text);
  }

  void signOut() {
    loginProvider.signOut();
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    ever(firebaseUser, handleAuthChanged);
    firebaseUser.bindStream(user);
    super.onReady();
  }

  handleAuthChanged(_firebaseUser) async {
    if (_firebaseUser == null) {
      Get.offAllNamed(Routes.LOGIN);
    } else {
      Get.offAllNamed(Routes.HOME);
    }
  }
}
