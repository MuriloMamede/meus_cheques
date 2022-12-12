import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meuscheques/app/global/strings.dart';
import '../../../global/widgets/custom_text_form_field.dart';
import '../login/controller.dart';

class SignupView extends StatelessWidget {
  final LoginController _loginController = Get.find<LoginController>();
  final _formKey = GlobalKey<FormState>();

  SignupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
      ),
      body: SizedBox(
        height: Get.height,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  width: Get.width,
                  height: Get.height * 0.34,
                  decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(90))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            onPressed: () => Get.back()),
                      ),
                      const Align(
                        alignment: Alignment.topCenter,
                        child: Icon(
                          Icons.person_add,
                          size: 90,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: Get.width,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: Get.height * 0.06,
                      ),
                      CustomTextFormField(
                        keyboardType: TextInputType.name,
                        controller: _loginController.nameTextController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return requiredField;
                          }
                          return null;
                        },
                        icon: const Icon(Icons.person),
                        title: 'Nome',
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      CustomTextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _loginController.emailTextController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return requiredField;
                          } else if (!GetUtils.isEmail(value)) {
                            return 'Email Inválido';
                          }
                          return null;
                        },
                        icon: const Icon(Icons.email),
                        title: 'Email',
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      Obx(() => CustomTextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            controller: _loginController.passwordTextController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return requiredField;
                              } else if (value.length < 6) {
                                return 'Senha muito curta';
                              }
                              return null;
                            },
                            obscureText:
                                !_loginController.senhaCadastroIsVisible.value,
                            toggle: () {
                              _loginController.senhaCadastroIsVisible.toggle();
                            },
                            icon: const Icon(Icons.vpn_key),
                            title: 'Senha',
                          )),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      Obx(() => CustomTextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return requiredField;
                              } else if (!(value ==
                                  _loginController
                                      .passwordTextController.text)) {
                                return 'Senhas não são iguais';
                              }
                              return null;
                            },
                            obscureText:
                                !_loginController.senhaConfirmIsVisible.value,
                            toggle: () {
                              _loginController.senhaConfirmIsVisible.toggle();
                            },
                            icon: const Icon(Icons.vpn_key),
                            title: 'Confirmar Senha',
                          )),
                      SizedBox(
                        height: Get.height * 0.05,
                      ),
                      TextButton(
                        child: const Text(
                          'CADASTRAR',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all(
                              Size(context.width, 40)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue),
                        ),
                        onPressed: () {
                          /*if (_formKey.currentState!.validate()) {
                            _loginController.register();
                          }*/
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
