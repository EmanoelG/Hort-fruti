import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:sacolao_de_frutas/src/pages/home/home_tab%20copy.dart';
import 'package:sacolao_de_frutas/src/pages/splash/splash_screen.dart';

import '../auth/cadastro/sing_up_screen.dart';
import '../auth/login/sing_in_scren.dart';

abstract class AppPages {
  static final page = <GetPage>[
    GetPage(
      name: '/splashscreen',
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: '/signin',
      page: () => const SingInScreen(),
    ),
    GetPage(
      name: '/signup',
      page: () => SingUpScreen(),
    ),
  ];
}
