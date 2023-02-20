import 'package:flutter/material.dart';
import 'package:sacolao_de_frutas/src/pages/common_widgets/title_app.dart';
import '../../config/custom_color.dart';

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
              const Color.fromARGB(255, 90, 207, 94),
              const Color.fromARGB(255, 215, 240, 188),
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