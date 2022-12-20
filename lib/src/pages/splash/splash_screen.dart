import 'package:flutter/material.dart';
import 'package:sacolao_de_frutas/src/pages/common_widgets/title_app.dart';
import 'package:get/get.dart';
import '../../config/custom_color.dart';
import '../../service/form_services.dart';
import '../../service/provider_manager.dart';
import '../pages_routes/app_pages.dart';
import '../auth/controller/auth_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

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