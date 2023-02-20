import 'package:get/get.dart';

import '../auth/view/cadastro/sing_up_screen.dart';
import '../auth/view/login/sing_in_scren.dart';
import '../base/base_screen.dart';
import '../base/binding/navigation_binding.dart';
import '../cart/binding/cart_binding.dart';
import '../home/binding/home_binding.dart';
import '../home/view/home_tab.dart';
import '../orders/binding/orders_binding.dart';
import '../product/product_screen.dart';
import '../splash/splash_screen.dart';

abstract class AppPages {
  static final page = <GetPage>[
    GetPage(
      name: '/${PagesRoutes.productRoute}',
      page: () => const ProdutctScreen(),
    ),
    GetPage(
      name: '/splashscreen',
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: '/signin',
      page: () => SingUpscreen(),
    ),
    GetPage(
      name: '/signup',
      page: () => SingInScreen(),
    ),
    GetPage(
      name: '/hometab',
      page: () => const HomeTab(),
    ),
    GetPage(
      name: '/',
      page: () => const BaseScreen(),
      bindings: [
        NavigationBinding(),
        HomeBinding(),
        CartBinding(),
        OrdersBinding(),
      ],
    ),
  ];
}

abstract class PagesRoutes {
  static const String productRoute = 'product';
  static const String singInRoute = 'signup';
  static const String singUpRoute = 'signin';
  static const String splashScreen = 'splashscreen';
  static const String homeTab = 'hometab';
  static const String baseRoute = '/';
}
