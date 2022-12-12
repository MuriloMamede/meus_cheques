import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../global/widgets/custom_text_form_field.dart';
import '../login/controller.dart';

class ResetPasswordView extends StatelessWidget {
  final LoginController _loginController = Get.find<LoginController>();
  final _formKey = GlobalKey<FormState>();

  ResetPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: Get.height * 0.95,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: Get.width,
                height: Get.height * 0.28,
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
                        Icons.vpn_key_rounded,
                        size: 90,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: Get.height * 0.06,
                      ),
                      const Text(
                          'Um link para troca de senha será enviado para o email informado',
                          style:
                              TextStyle(color: Colors.black87, fontSize: 16)),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      CustomTextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _loginController.emailTextController,
                        onEditingComplete: () {
                          if (_formKey.currentState!.validate()) {
                            //_loginController.changePassword();
                          }
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Campo obrigatorio';
                          } else if (!GetUtils.isEmail(value)) {
                            return 'Email Inválido';
                          }
                          return null;
                        },
                        icon: const Icon(Icons.email),
                        title: 'Email',
                      ),
                      SizedBox(
                        height: Get.height * 0.03,
                      ),
                      TextButton(
                        child: const Text(
                          'ENVIAR',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all(
                              Size(context.width, 40)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            //_loginController.changePassword();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
