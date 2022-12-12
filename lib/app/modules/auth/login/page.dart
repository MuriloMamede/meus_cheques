import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:get/get.dart';
import 'package:meuscheques/app/global/strings.dart';
import 'package:meuscheques/app/theme/colors.dart';
import 'package:meuscheques/app/theme/images.dart';
import 'controller.dart';

class LoginView extends StatelessWidget {
  final LoginController _loginController = Get.find<LoginController>();
  final BorderRadius inputBorder = BorderRadius.circular(8);

  LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FlutterLogin(
        title: '',
        logo: logoBranco,
        logoTag: logoTag,
        titleTag: titleTag,
        navigateBackAfterRecovery: true,
        hideProvidersTitle: true,
        messages: LoginMessages(
          userHint: userHint,
          passwordHint: passwordHint,
          confirmPasswordHint: confirmPasswordHint,
          loginButton: loginButton,
          signupButton: signupButton,
          forgotPasswordButton: forgotPasswordButton,
          recoverPasswordButton: recoverPasswordButton,
          goBackButton: goBackButton,
          confirmPasswordError: confirmPasswordError,
          recoverPasswordIntro: '',
          recoverPasswordDescription: recoverPasswordDescription,
          recoverPasswordSuccess: recoverPasswordSuccess,
          flushbarTitleError: flushbarTitleError,
          flushbarTitleSuccess: flushbarTitleSuccess,
        ),
        theme: LoginTheme(
          primaryColor: secondaryColor,
          accentColor: secondaryColor,
          errorColor: Colors.deepOrange,
          pageColorLight: splashScreenColor,
          pageColorDark: splashScreenColor.withOpacity(0.8),
          logoWidth: 1,
          switchAuthTextColor: secondaryColor,
          beforeHeroFontSize: 50,
          afterHeroFontSize: 20,
          textFieldStyle: const TextStyle(
            color: Colors.black87,
          ),
          buttonStyle: const TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
          cardTheme: CardTheme(
            color: Colors.white,
            elevation: 5,
            margin: const EdgeInsets.only(top: 15),
            shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(75.0)),
          ),
          inputTheme: InputDecorationTheme(
            filled: true,
            fillColor: secondaryColor.withOpacity(.1),
            contentPadding: EdgeInsets.zero,
            errorStyle: const TextStyle(
              color: Colors.redAccent,
            ),
            labelStyle: const TextStyle(
              fontSize: 15,
            ),
          ),
          buttonTheme: LoginButtonTheme(
            splashColor: secondaryColor.withOpacity(0.3),
            backgroundColor: primaryColor,
            highlightColor: secondaryColor.withOpacity(0.3),
            elevation: 5.0,
            highlightElevation: 4.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0)),
          ),
        ),
        userValidator: (value) {
          if (value!.isEmpty) {
            return requiredField;
          }
          return null;
        },
        passwordValidator: (value) {
          if (value!.isEmpty) {
            return requiredField;
          }
          return null;
        },
        onLogin: (loginData) =>
            _loginController.login(loginData.name, loginData.password),
        onSignup: (loginData) =>
            _loginController.register(loginData.name!, loginData.password!),
        onRecoverPassword: (name) {
          return _loginController.resetPassword(name);
        },
        showDebugButtons: false,
      ),
    );
  }
}
