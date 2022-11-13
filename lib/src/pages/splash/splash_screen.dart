import 'package:flutter/material.dart';
import 'package:sacolao_de_frutas/src/pages/auth/login/sing_in_scren.dart';

import '../../config/custom_color.dart';
import '../../util/push_function.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // criar a regra de firebase etc.
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
    ).then(
      (value) => push(context, const SingInScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColors.colorAppMain,
      child: const Center(
        child: CircularProgressIndicator(
          color: Color.fromARGB(98, 2, 46, 4),
        ),
      ),
    );
  }
}
