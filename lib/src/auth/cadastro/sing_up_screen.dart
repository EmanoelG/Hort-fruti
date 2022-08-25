import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sacolao_de_frutas/src/config/custom_color.dart';
import 'package:sacolao_de_frutas/src/util/compentes/custom_textField.dart';

class SingUpScreen extends StatelessWidget {
  const SingUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: CustomColors.colorAppMain,
      body: _formCadastro(size),
    );
  }

  SingleChildScrollView _formCadastro(Size size) {
    return SingleChildScrollView(
      child: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            const Expanded(
              child: Center(
                child: Text(
                  'Cadastro',
                  style: TextStyle(fontSize: 40),
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
      ),
    );
  }

  Column _formFieldCadastro() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // FormDefault(iconTitipo: const Icon(Icons.email), isSecret: false),
        // const SizedBox(
        //   height: 10,
        // ),
        FormDefault(
            type: TextInputType.emailAddress,
            inputMenssagem: 'Nome',
            iconTitipo: const Icon(Icons.person),
            isSecret: false),
        const SizedBox(
          height: 10,
        ),
        FormDefault(
            type: TextInputType.number,
            inputMenssagem: 'Cpf',
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
      ],
    );
  }
}
