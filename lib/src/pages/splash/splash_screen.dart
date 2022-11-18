import 'package:flutter/material.dart';
import 'package:sacolao_de_frutas/src/pages/auth/login/sing_in_scren.dart';
import 'package:sacolao_de_frutas/src/pages/common_widgets/title_app.dart';
import 'package:get/get.dart';
import '../../config/custom_color.dart';
import '../../util/push_function.dart';
import '../app_route/app_pages.dart';

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
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAllNamed(PagesRoutes.singInRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: _body(),
    );
  }

  _body() {
    return Container(
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TitleApp(fontTitle: 40),
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.white),
          )
        ],
      ),
    );
  }
}

    // child: const Center(
    //     child: CircularProgressIndicator(
    //       color: Color.fromARGB(98, 2, 46, 4),
    //     ),
    //   ),