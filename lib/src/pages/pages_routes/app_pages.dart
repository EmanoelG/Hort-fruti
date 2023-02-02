import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:sacolao_de_frutas/src/pages/base/base_screen.dart';
import 'package:sacolao_de_frutas/src/pages/base/binding/navigation_binding.dart';
import 'package:sacolao_de_frutas/src/pages/home/binding/home_binding.dart';
import 'package:sacolao_de_frutas/src/pages/splash/splash_screen.dart';

import '../auth/view/cadastro/sing_up_screen.dart';
import '../auth/view/login/sing_in_scren.dart';
import '../home/view/home_tab.dart';

abstract class AppPages {
  static final page = <GetPage>[
    GetPage(
      name: '/splashscreen',
      page: () => SplashScreen(),
    ),
    GetPage(
      name: '/signin',
      page: () => SingUpScreen(),
    ),
    GetPage(
      name: '/signup',
      page: () => SingInScreen(),
    ),
    GetPage(
      name: '/hometab',
      page: () => HomeTab(),
    ),
    GetPage(
      name: '/',
      page: () => BaseScreen(),
      bindings: [
        NavigationBinding(),
        HomeBinding(),
      ],
    ),
  ];
}

abstract class PagesRoutes {
  static const String singInRoute = 'signup';
  static const String singUpRoute = 'signin';
  static const String splashScreen = 'splashscreen';
  static const String homeTab = 'hometab';
  static const String baseRoute = '/';
}
