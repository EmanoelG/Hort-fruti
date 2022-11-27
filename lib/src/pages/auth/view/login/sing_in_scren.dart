import 'dart:ffi';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sacolao_de_frutas/src/pages/app_route/app_pages.dart';

import 'package:sacolao_de_frutas/src/util/push_function.dart';

import '../../../../config/custom_color.dart';
import '../../../../util/compentes/custom_textField.dart';
import '../../../base/base_screen.dart';
import '../../../common_widgets/title_app.dart';
import '../cadastro/sing_up_screen.dart';
import '../../controller/auth_controller.dart';

class SingInScreen extends StatelessWidget {
  SingInScreen({Key? key}) : super(key: key);
  final _formKeys = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 215, 240, 188),
      body: _telalogin(context),
    );
  }

  _telalogin(context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomLeft,
                      colors: [
                        CustomColors.colorButtonMain,
                        Color.fromARGB(255, 90, 207, 94),
                        Color.fromARGB(255, 215, 240, 188),
                      ]),
                ),
                child: _titleLogin(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: _formLogin(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _titleLogin() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TitleApp(fontTitle: 30),
        SizedBox(
          height: 30,
          child: DefaultTextStyle(
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            child: AnimatedTextKit(
              pause: const Duration(milliseconds: 500),
              repeatForever: true,
              animatedTexts: [
                FadeAnimatedText('HortFruti'),
                FadeAnimatedText('Delivery'),
                FadeAnimatedText('Promoção'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Form _formLogin(context) => Form(
        key: _formKeys,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FormDefault(
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              readOnly: false,
              type: TextInputType.emailAddress,
              iconTitipo: const Icon(Icons.email),
              inputMenssagem: 'e-mail',
              isSecret: false,
              validatorValue: (email_validator) {
                if (email_validator == null || email_validator.isEmpty) {
                  return 'Preencha o campo de e-mail corretamente !';
                }
                if (!email_validator.isEmail) {
                  return 'Digite um e-mail valido !';
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            FormDefault(
              keyboardType: TextInputType.text,
              validatorValue: (password) {
                if (password == null || password.isEmpty) {
                  return 'Preencha o campo de senha corretamente !';
                }
                if (password.length <= 7) {
                  return 'Password precisa ter no minimo 7 carcter';
                }

                return null;
              },
              readOnly: false,
              controller: passwordController,
              type: TextInputType.visiblePassword,
              iconTitipo: const Icon(Icons.key),
              inputMenssagem: 'senha',
              isObscureText: true,
              isSecret: true,
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 50,
              child: GetX<AuthController>(
                builder: (controllerAuth) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    onPressed: controllerAuth.isLoading.value
                        ? null
                        : () async {
                            FocusScope.of(context).unfocus();
                            if (_formKeys.currentState!.validate()) {
                              String _email = emailController.text;
                              String _password = passwordController.text;
                              bool acess;
                              acess = await controllerAuth.signIn(
                                  email: _email, password: _password);
                              if (acess == true) {
                                //    Get.offAllNamed(PagesRoutes.baseRoute);
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      title:
                                          const Text('usuário não encontrado '),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop(false);
                                          },
                                          child: const Text('ok'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            }
                          },
                    child: controllerAuth.isLoading.value
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            'Entrar',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  'esqueceu a senha?',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
            _ouDivider(),
            SizedBox(
              height: 50,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                    side: BorderSide(
                      width: 2,
                      color: CustomColors.colorButtonMain,
                    ),
                  ),
                ),
                onPressed: () {
                  // push(context, SingUpScreen());
                  print('Tela principal ');
                },
                child: const Text(
                  'Criar Conta',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      );

  _ouDivider() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Expanded(
            child: Divider(
              color: Color.fromARGB(255, 200, 200, 200),
              thickness: 2,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              'Ou',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Divider(
              color: Color.fromARGB(255, 200, 200, 200),
              thickness: 2,
            ),
          ),
        ],
      ),
    );
  }
}
