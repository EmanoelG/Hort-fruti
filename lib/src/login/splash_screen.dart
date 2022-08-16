import 'package:flutter/material.dart';
import 'package:sacolao_de_frutas/src/login/sing_in_scren.dart';

import '../util/push_function.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen() : super();

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // criar a regra de firebase etc.
    super.initState();
    Future.delayed(
      const Duration(seconds: 5),
    ).then(
      (value) => push(context, const SingInScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: const Center(
        child: CircularProgressIndicator(
          color: Color.fromARGB(98, 2, 46, 4),
        ),
      ),
    );
  }
}
