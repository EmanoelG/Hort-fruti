import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:sacolao_de_frutas/src/auth/cadastro/sing_up_screen.dart';

import 'package:sacolao_de_frutas/src/util/push_function.dart';

import '../../base/base_screen.dart';
import '../../config/custom_color.dart';
import '../../util/compentes/custom_textField.dart';

class SingInScreen extends StatelessWidget {
  const SingInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.colorAppMain,
      body: _telalogin(context),
    );
  }

  _telalogin(context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            Expanded(
              child: _titleLogin(),
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
              child: _formLogin(context),
            ),
          ],
        ),
      ),
    );
  }

  Column _titleLogin() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _tltleLoginRich(),
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

  Text _tltleLoginRich() {
    return const Text.rich(
      TextSpan(
        style: TextStyle(fontSize: 40),
        children: [
          TextSpan(
            text: 'Super',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: 'Sacolão',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Form _formLogin(context) => Form(
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
                onPressed: () {
                  pushReplace(context, const BaseScreen(), replace: true);
                },
                child: const Text(
                  'Entrar',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                  pushReplace(context, SingUpScreen());
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
