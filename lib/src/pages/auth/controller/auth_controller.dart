import 'dart:ffi';

import 'package:get/get.dart';
import 'package:sacolao_de_frutas/src/models/user_model.dart';
import 'package:sacolao_de_frutas/src/service/form_services.dart';

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
    AuthRepository loginApp = AuthRepository();
    _user = await loginApp.sigIn(email: email, password: password);
    isLoading.value = false;
    _user.when(
      sucess: (UserModel user) async {
        userModel = user;
        Map<String, String> token_user = {
          'user_token': userModel.token.toString(),
        };
        _utils.saveLocalData(token_user);
        // Get.offAllNamed(PagesRoutes.baseRoute);
      },
      error: (msg) {
        _utils.showToats(message: msg, isError: true);
      },
    );
  }

  Future<void> validateToken(String? token) async {
    AuthResult _user;
    AuthRepository loginApp = AuthRepository();
    _user = await loginApp.validateToken(token ?? '');
    _user.printInfo();
  }
}
