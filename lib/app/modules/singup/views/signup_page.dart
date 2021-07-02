import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meuscheques/app/global/widgets/CustomAppBar.dart';
import 'package:meuscheques/app/global/widgets/CustomTextField.dart';
import 'package:meuscheques/app/modules/home/views/widgets/CustomButton.dart';
import 'package:meuscheques/app/modules/login/controllers/login_controller.dart';
import 'package:meuscheques/app/theme/colors.dart';

class SingupView extends StatelessWidget {
  final LoginController _loginController = Get.find<LoginController>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(""),
      body: Container(
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Container(
                width: Get.width,
                height: Get.height / 3.5,
                decoration: BoxDecoration(
                    gradient: primaryGradient,
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(90))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          onPressed: () => Get.back()),
                    ),
                    Spacer(),
                    Align(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.person_add,
                        size: 90,
                        color: Colors.white,
                      ),
                    ),
                    Spacer(),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 32, right: 32),
                        child: Text(
                          '',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: Get.height / 1.6,
                width: Get.width,
                padding: EdgeInsets.only(top: 62, left: 28, right: 28),
                child: Column(
                  children: <Widget>[
                    CustomTextField(
                      keyboardType: TextInputType.name,
                      controller: _loginController.nameTextController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Campo obrigatorio";
                        }
                        return null;
                      },
                      icon: Icons.person,
                      hintText: 'Nome',
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    CustomTextField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _loginController.emailTextController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Campo obrigatorio";
                        } else if (!GetUtils.isEmail(value)) {
                          return "Email Inválido";
                        }
                        return null;
                      },
                      icon: Icons.email,
                      hintText: 'Email',
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Obx(() => CustomTextField(
                          keyboardType: TextInputType.visiblePassword,
                          controller: _loginController.passwordTextController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Campo obrigatorio";
                            } else if (value.length < 6) {
                              return "Senha muito curta";
                            }
                            return null;
                          },
                          obscureText:
                              !_loginController.senhaCadastroIsVisible.value,
                          toggle: () {
                            _loginController.senhaCadastroIsVisible.toggle();
                          },
                          icon: Icons.vpn_key,
                          hintText: 'Senha',
                        )),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Obx(() => CustomTextField(
                          keyboardType: TextInputType.visiblePassword,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return "Campo obrigatorio";
                            } else if (!(value ==
                                _loginController.passwordTextController.text)) {
                              return "Senhas não são iguais";
                            }
                            return null;
                          },
                          obscureText:
                              !_loginController.senhaConfirmIsVisible.value,
                          toggle: () {
                            _loginController.senhaConfirmIsVisible.toggle();
                          },
                          icon: Icons.vpn_key,
                          hintText: 'Confirmar Senha',
                        )),
                    SizedBox(
                      height: Get.height * 0.1,
                    ),
                    customButton(
                      borderRadius: 50,
                      title: "CADASTRAR",
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _loginController.register();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
