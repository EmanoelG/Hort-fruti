import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:sacolao_de_frutas/src/config/custom_color.dart';
import 'package:sacolao_de_frutas/src/util/compentes/custom_textField.dart';
import 'package:sacolao_de_frutas/src/util/push_function.dart';

class SingUpScreen extends StatelessWidget {
  SingUpScreen({Key? key}) : super(key: key);
  var cpfFormat = MaskTextInputFormatter(
      mask: '###.###.###-##',
      filter: {
        "#": RegExp(r'[0-9]'),
      },
      type: MaskAutoCompletionType.lazy);

  var phonFormat = MaskTextInputFormatter(
      mask: '(##) #####-####',
      filter: {
        "#": RegExp(r'[0-9]'),
      },
      type: MaskAutoCompletionType.lazy);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: CustomColors.colorAppMain,
      body: _formCadastro(size, context),
    );
  }

  SingleChildScrollView _formCadastro(Size size, context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: IconButton(
                onPressed: () {
                  pop(context);
                },
                icon: const Icon(Icons.arrow_back),
              ),
            ),
            Column(
              children: [
                const Expanded(
                  child: Center(
                    child: Text(
                      'Cadastro',
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 40,
                  ),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(40.0),
                    ),
                  ),
                  child: _formFieldCadastro(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Column _formFieldCadastro() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FormDefault(
            type: TextInputType.name,
            inputMenssagem: 'Nome',
            iconTitipo: const Icon(Icons.person),
            isSecret: false),
        const SizedBox(
          height: 10,
        ),
        FormDefault(
            type: TextInputType.emailAddress,
            inputMenssagem: 'Email',
            iconTitipo: const Icon(Icons.person),
            isSecret: false),
        const SizedBox(
          height: 10,
        ),
        FormDefault(
            type: TextInputType.number,
            inputMenssagem: 'Cpf',
            textinputformatt: [cpfFormat],
            iconTitipo: const Icon(Icons.file_copy),
            isSecret: false),
        const SizedBox(
          height: 10,
        ),
        FormDefault(
            type: TextInputType.visiblePassword,
            inputMenssagem: 'Senha',
            iconTitipo: const Icon(Icons.lock),
            isSecret: true),
        const SizedBox(
          height: 10,
        ),
        FormDefault(
            type: TextInputType.visiblePassword,
            inputMenssagem: 'Confirma senha',
            iconTitipo: const Icon(Icons.lock),
            isSecret: true),
        const SizedBox(
          height: 10,
        ),
        _buttonCadastrar(),
      ],
    );
  }

  SizedBox _buttonCadastrar() {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            side: BorderSide(
              width: 2,
              color: CustomColors.colorButtonMain,
            ),
          ),
        ),
        onPressed: () {
          // pushReplace(
          //   context,
          //   const SingUpScreen(),
          // );
        },
        child: const Text(
          'Criar Conta',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
