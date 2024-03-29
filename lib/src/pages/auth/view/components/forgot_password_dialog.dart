import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sacolao_de_frutas/src/pages/auth/controller/auth_controller.dart';
import '../../../../util/compentes/custom_textField.dart';

class ForgotPasswordDialog extends StatelessWidget {
  final emailController = TextEditingController();
  final AuthController authController = Get.find<AuthController>();
  ForgotPasswordDialog({
    required String email,
    Key? key,
  }) : super(key: key) {
    emailController.text = email;
  }
  final _formFieldKey = GlobalKey<FormFieldState>();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Conteúdo
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Titulo
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Recuperação de senha',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),

                // Descrição
                const Padding(
                  padding: EdgeInsets.only(
                    top: 10,
                    bottom: 20,
                  ),
                  child: Text(
                    'Digite seu email para recuperar sua senha',
                    textAlign: TextAlign.center,
                    style: TextStyle(),
                  ),
                ),

                // Campo de email
                FormDefault(
                  keyFomr: _formFieldKey,
                  readOnly: true,
                  controller: emailController,
                  type: TextInputType.emailAddress,
                  iconTitipo: const Icon(Icons.email),
                  inputMenssagem: 'Email',
                  isSecret: false,
                  validatorValue: (emailValidator) {
                    if (emailValidator == null || emailValidator.isEmpty) {
                      return 'Preencha o campo de Email corretamente !';
                    }
                    if (!emailValidator.isEmail) {
                      return 'Digite um e-mail valido !';
                    }
                    return null;
                  },
                ),

                // Confirmar
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    side: const BorderSide(
                      width: 2,
                      color: Colors.green,
                    ),
                  ),
                  onPressed: () async {
                    if (_formFieldKey.currentState!.validate()) {
                      await authController.restPass(emailController.text);
                      Get.back(result: true);
                    }
                  },
                  child: const Text(
                    'Recuperar',
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Botão para fechar
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close),
            ),
          ),
        ],
      ),
    );
  }
}
