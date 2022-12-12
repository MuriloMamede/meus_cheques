import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meuscheques/app/data/provider/login_provider.dart';
import '/app/global/strings.dart';
import '/app/theme/colors.dart';

import '../login/controller.dart';

class ConfirmEmailView extends StatelessWidget {
  ConfirmEmailView({Key? key}) : super(key: key);
  final LoginController _loginController = Get.find<LoginController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Stack(
        children: [
          Positioned(
            top: kToolbarHeight - 15,
            right: 10,
            child: IconButton(
              onPressed: _loginController.signOut,
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(horizontal: 30),
              shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(75.0)),
              child: Container(
                padding: const EdgeInsets.all(15),
                height: Get.height * 0.3,
                width: Get.width,
                child: Stack(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              text:
                                  'Um email de verificação foi enviado para\n',
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 17),
                              children: <TextSpan>[
                                TextSpan(
                                  text: LoginProvider.user!.email!,
                                  style: const TextStyle(
                                      color: Colors.blueAccent, fontSize: 17),
                                ),
                                const TextSpan(
                                  text:
                                      ', após verifica-lo você poderá acessar o sistema\n',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 17),
                                )
                              ])),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                              onPressed: () =>
                                  _loginController.sendVerification(),
                              child: const Text(
                                resendEmailButton,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(0),
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                  foregroundColor: MaterialStateProperty.all(
                                      Colors.blue.shade300),
                                  overlayColor: MaterialStateProperty.all(
                                      secondaryColor.withOpacity(0.2)),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0))))),
                          ElevatedButton(
                              onPressed: () =>
                                  _loginController.verifyAndAcessHome(),
                              child: const Text(
                                acessButton,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              style: ButtonStyle(
                                  //elevation: MaterialStateProperty.all(1),
                                  backgroundColor:
                                      MaterialStateProperty.all(primaryColor),
                                  foregroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                  overlayColor: MaterialStateProperty.all(
                                      secondaryColor.withOpacity(0.2)),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0))))),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
