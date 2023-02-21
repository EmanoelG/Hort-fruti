import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sacolao_de_frutas/src/pages/home/view/controller/view_controller.dart';
import 'package:sacolao_de_frutas/src/pages/pages_routes/app_pages.dart';
import 'package:sacolao_de_frutas/src/pages/auth/controller/auth_controller.dart';

void main() {
  Get.put(AuthController());
  Get.put(ViewController());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Green Grocer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.green,
          scaffoldBackgroundColor: Colors.white.withAlpha(190)),
      initialRoute: PagesRoutes.splashScreen,
      getPages: AppPages.page,
    );
  }
}
