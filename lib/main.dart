import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sacolao_de_frutas/src/pages/auth/controller/auth_controller.dart';
import 'package:sacolao_de_frutas/src/pages/pages_routes/app_pages.dart';

import 'src/service/connectivitywidget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(const MyApp());
  });
}

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      scaffoldMessengerKey: scaffoldMessengerKey,
      title: 'Green Grocer',
      debugShowCheckedModeBanner: false,
      initialBinding: BindingsBuilder(
        () {
          Get.put(ConnectionService());
          Get.put(AuthController());
        },
      ),
      onDispose: () {
        Get.delete<AuthController>();
      },
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.white.withAlpha(190),
      ),
      initialRoute: PagesRoutes.splashScreen,
      getPages: AppPages.page,
    );
  }
}
