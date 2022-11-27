import 'dart:ffi';

import 'package:get/get.dart';
import 'package:sacolao_de_frutas/src/models/user_model.dart';
import 'package:sacolao_de_frutas/src/service/forma_services.dart';

import '../../app_route/app_pages.dart';
import '../repository/auth_repository.dart';
import '../result/auth_result.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
  final UtilsService _utils = UtilsService();
  UserModel userModel = UserModel();
  Future<void> signIn({required String email, required String password}) async {
    isLoading.value = true;
    AuthResult _user;
    AuthRepository login_app = AuthRepository();
    _user = await login_app.sigIn(email: email, password: password);
    isLoading.value = false;
    _user.printInfo();
    _user.when(sucess: (UserModel user) {
      this.userModel = user;
      Get.offAllNamed(PagesRoutes.baseRoute);
    }, error: (Msg) {
      print('Error ao tentar logar: ' + Msg);
      _utils.showToats(message: Msg, isError: true);
    });
    UserModel iuser = UserModel();
  }
}
