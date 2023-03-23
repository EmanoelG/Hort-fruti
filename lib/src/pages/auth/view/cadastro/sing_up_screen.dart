import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:sacolao_de_frutas/src/models/user_model.dart';
import 'package:sacolao_de_frutas/src/util/font_app.dart';

import '../../../../config/custom_color.dart';
import '../../../../util/compentes/custom_textField.dart';
import '../../../common_widgets/title_app.dart';
import '../../../pages_routes/app_pages.dart';
import '../../controller/auth_controller.dart';

// ignore: must_be_immutable
class SingUpscreen extends StatelessWidget {
  SingUpscreen({Key? key}) : super(key: key);
  final _formKeys = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final cpfController = TextEditingController();
  final phoneCntroller = TextEditingController();

  var cpfFormat = MaskTextInputFormatter(
      mask: '###.###.###-##',
      filter: {
        "#": RegExp(r'[0-9]'),
      },
      type: MaskAutoCompletionType.lazy);
  var cllFormat = MaskTextInputFormatter(
      mask: '(##) # ####-####s',
      filter: {
        "#": RegExp(r'[0-9]'),
      },
      type: MaskAutoCompletionType.lazy);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 215, 240, 188),
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
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                            const Color.fromARGB(255, 90, 207, 94),
                            const Color.fromARGB(255, 215, 240, 188),
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
            Positioned(
              top: 10,
              left: 10,
              child: SafeArea(
                child: IconButton(
                  onPressed: () {
                    Get.offNamed(PagesRoutes.singInRoute);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _titleLogin() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TitleApp(fontTitle: 35),
        SizedBox(
          height: 30,
          child: TextApp(
            texto: 'Criar cadastro',
            fontSize: 25,
          ),
        ),
      ],
    );
  }

  Form _formLogin(context) {
    final size = MediaQuery.of(context).size;
    return Form(
      key: _formKeys,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //EMAIL
          FormDefault(
            keyboardType: TextInputType.emailAddress,
            controller: emailController,
            readOnly: false,
            type: TextInputType.emailAddress,
            iconTitipo: const Icon(Icons.email),
            inputMenssagem: 'e-mail',
            isSecret: false,
            validatorValue: (emailValidator) {
              if (emailValidator == null || emailValidator.isEmpty) {
                return 'Preencha o campo de e-mail corretamente !';
              }
              if (!emailValidator.isEmail) {
                return 'Digite um e-mail valido !';
              }
              return null;
            },
          ),
          SizedBox(
            height: size.height / 90,
          ),
          //Nome
          FormDefault(
            keyboardType: TextInputType.text,
            validatorValue: (password) {
              if (password == null || password.isEmpty) {
                return 'Preencha o campo de nome corretamente !';
              }

              return null;
            },
            readOnly: false,
            controller: nameController,
            type: TextInputType.name,
            iconTitipo: const Icon(Icons.person),
            inputMenssagem: 'nome',
            isSecret: false,
          ),
          SizedBox(
            height: size.height / 90,
          ),
          // CPF
          FormDefault(
            keyboardType: TextInputType.text,
            validatorValue: (password) {
              if (password == null || password.isEmpty) {
                return 'Preencha o campo de Cpf corretamente !';
              }
              return null;
            },
            readOnly: false,
            controller: cpfController,
            textinputformatt: [cpfFormat],
            type: TextInputType.number,
            iconTitipo: const Icon(Icons.numbers),
            inputMenssagem: 'CPF',
            isObscureText: true,
            isSecret: true,
          ),
          SizedBox(
            height: size.height / 90,
          ),
          //PHONE
          FormDefault(
            keyboardType: TextInputType.text,
            validatorValue: (password) {
              if (password == null || password.isEmpty) {
                return 'Preencha o campo de Celular corretamente !';
              }
              return null;
            },
            readOnly: false,
            controller: phoneCntroller,
            textinputformatt: [cllFormat],
            type: TextInputType.number,
            iconTitipo: const Icon(Icons.phone),
            inputMenssagem: 'Celular',
            isSecret: false,
          ),
          SizedBox(
            height: size.height / 90,
          ),
          //Senha
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
          SizedBox(
            height: size.height / 90,
          ),
          SizedBox(
            height: size.height / 15,
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
                            String _phone = phoneCntroller.text;
                            String name = nameController.text;
                            String _cpf = cpfController.text;
                            UserModel usuerUp = UserModel();
                            usuerUp.email = _email;
                            usuerUp.name = name;
                            usuerUp.cpf = _cpf;
                            usuerUp.password = _password;
                            usuerUp.celular = _phone;
                            await controllerAuth.singUp(usuerUp);
                          }
                        },
                  child: controllerAuth.isLoading.value
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text(
                          'Cadastrar',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                );
              },
            ),
          ),
          SizedBox(
            height: size.height / 90,
          )
        ],
      ),
    );
  }
}
