import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';

import '../util/compentes/custom_textField.dart';

class SingInScreen extends StatelessWidget {
  const SingInScreen() : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(208, 168, 231, 95),
      body: telalogin(),
    );
  }

  telalogin() {
    return Column(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Green',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                  Text(
                    'grocer',
                    style: TextStyle(
                      color: Color.fromARGB(255, 246, 125, 33),
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                ],
              ),
            ],
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
          child: formLogin(),
        ),
      ],
    );
  }

  Form formLogin() => Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FormDefault(
              type: TextInputType.emailAddress,
              iconTitipo: const Icon(Icons.email),
              inputMenssagem: 'e-mail',
              isSecret: false,
            ),
            const SizedBox(
              height: 10,
            ),
            FormDefault(
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
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                onPressed: () {},
                child: Container(
                  child: const Text(
                    'Entrar',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
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
            ouDivider(),
            SizedBox(
              height: 50,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                      side: const BorderSide(
                        width: 2,
                        color: Colors.green,
                      )),
                ),
                onPressed: () {},
                child: const Text(
                  'Criar Conta',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      );

  ouDivider() {
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
