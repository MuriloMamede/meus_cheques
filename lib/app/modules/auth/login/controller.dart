import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meuscheques/app/data/provider/login_provider.dart';
import 'package:meuscheques/app/global/widgets/snacksbar.dart';
import 'package:meuscheques/app/routes/app_pages.dart';

class LoginController extends GetxController {
  final LoginProvider loginProvider = LoginProvider();
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController nameTextController = TextEditingController();
  Rx<User?> firebaseUser = Rx<User?>(LoginProvider.user);
  Stream<User?> get user => loginProvider.firebaseAuth.authStateChanges();
  var isSenhaVisible = false.obs;
  var isLoading = false.obs;
  var senhaCadastroIsVisible = false.obs;
  var senhaConfirmIsVisible = false.obs;

  @override
  void onReady() {
    ever<User?>(firebaseUser, handleAuthChanged);
    firebaseUser.bindStream(user);
    super.onReady();
  }

  Future<String?> register(String user, String password) {
    return loginProvider.createUserWithEmailAndPassword(
      user,
      password,
      user,
    );
  }

  Future<String?> login(String user, String password) {
    return loginProvider.signInWithEmailAndPassword(user, password);
  }

  void signOut() async {
    await loginProvider.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }

  Future<String?> resetPassword(String user) {
    return loginProvider.resetPassword(user);
  }

  Future<bool> emailIsVerified() async {
    await LoginProvider.user!.reload();
    return LoginProvider.user!.emailVerified;
  }

  void verifyAndAcessHome() async {
    if (await emailIsVerified()) {
      await _goToHome();
    } else {
      warningSnackBar('Atenção', 'Email ainda não verificado');
    }
  }

  Future<void> _goToHome() {
    return loginProvider
        .setSignedUser()
        .then((value) => Get.offAllNamed(Routes.HOME));
  }

  sendVerification() {
    loginProvider.sendConfirmationEmail();
  }

  void _checkEmailConfirmation() async {
    if (await emailIsVerified()) {
      await _goToHome();
    } else {
      sendVerification();
      Get.toNamed(Routes.CONFIRM_EMAIL);
    }
  }

  handleAuthChanged(_firebaseUser) async {
    if (_firebaseUser != null) {
      _checkEmailConfirmation();
    }
  }
}
