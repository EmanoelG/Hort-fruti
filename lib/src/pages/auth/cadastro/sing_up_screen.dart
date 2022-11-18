import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:sacolao_de_frutas/src/config/custom_color.dart';
import 'package:sacolao_de_frutas/src/util/compentes/custom_textField.dart';
import 'package:sacolao_de_frutas/src/util/font_app.dart';

class SingUpScreen extends StatelessWidget {
  SingUpScreen() : super();
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
    //final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Color.fromARGB(255, 215, 240, 188),
      body: Column(
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
              child: TextApp(texto: 'data'),
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
              child: _formCadastro(context),
            ),
          ),
        ],
      ),
    );
  }

  _formCadastro(context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
        child: _formFieldCadastro(context),
      ),
    );
  }

  _formFieldCadastro(context) {
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

  _buttonCadastrar() {
    SizedBox(
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        onPressed: () {
          //pushReplace(context, const BaseScreen(), replace: true);
        },
        child: const Text(
          'Entrar',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
