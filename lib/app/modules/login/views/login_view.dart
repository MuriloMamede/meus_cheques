import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:meuscheques/app/global/widgets/CustomAppBar.dart';
import 'package:meuscheques/app/global/widgets/CustomTextField.dart';
import 'package:meuscheques/app/modules/home/views/widgets/CustomButton.dart';
import 'package:meuscheques/app/modules/login/controllers/login_controller.dart';
import 'package:meuscheques/app/routes/app_pages.dart';
import 'package:meuscheques/app/theme/colors.dart';

class LoginView extends StatelessWidget {
  final LoginController _loginController = Get.find<LoginController>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(""),
      body: Container(
        height: Get.height,
        child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    width: Get.width,
                    height: Get.height / 3.4,
                    decoration: BoxDecoration(
                        gradient: primaryGradient,
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(90))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Spacer(),
                        Align(
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.person,
                            size: 90,
                            color: Colors.white,
                          ),
                        ),
                        Spacer(),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(bottom: 32, right: 32),
                            child: Text(
                              '',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: Get.height / 2,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: Get.height * 0.06,
                        ),
                        CustomTextField(
                          keyboardType: TextInputType.emailAddress,
                          hintText: 'Email',
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Campo obrigatorio";
                            } else if (!GetUtils.isEmail(value)) {
                              return "Email Inválido";
                            }
                            return null;
                          },
                          controller: _loginController.emailTextController,
                          icon: Icons.email,
                        ),
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                        Obx(() => CustomTextField(
                              toggle: _loginController.isSenhaVisible.toggle,
                              obscureText:
                                  !_loginController.isSenhaVisible.value,
                              onEditingComplete: () {
                                if (_formKey.currentState.validate()) {
                                  _loginController.login();
                                }
                              },
                              hintText: 'Senha',
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Campo obrigatorio";
                                }
                                return null;
                              },
                              controller:
                                  _loginController.passwordTextController,
                              icon: Icons.vpn_key,
                            )),
                        Spacer(),
                        customButton(
                          borderRadius: 25,
                          title: 'ENTRAR',
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              _loginController.login();
                            }
                          },
                        ),
                        SizedBox(
                          height: Get.height * 0.015,
                        ),
                        customButton(
                          color: Colors.grey,
                          borderRadius: 25,
                          title: 'CADASTRAR',
                          onPressed: () {
                            Get.toNamed(Routes.SINGUP);
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
