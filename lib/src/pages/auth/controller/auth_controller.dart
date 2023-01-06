import 'dart:ffi';

import 'package:get/get.dart';
import 'package:sacolao_de_frutas/src/models/user_model.dart';
import 'package:sacolao_de_frutas/src/service/form_services.dart';

import '../../../service/provider_manager.dart';
import '../../pages_routes/app_pages.dart';
import '../repository/auth_repository.dart';
import '../result/auth_result.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;

  final UtilsService _utils = UtilsService();
  UserModel userModel = UserModel();

  @override
  void onInit() {
    super.onInit();
    validateToken();
  }


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
          KeysApp.userToken: userModel.token.toString(),
        };
        _utils.saveLocalData(token_user);
        Get.offAllNamed(PagesRoutes.baseRoute);
      },
      error: (msg) {
        _utils.showToats(message: msg, isError: true);
      },
    );
  }

  Future<void> restPass(String email) async {
    AuthRepository loginApp = AuthRepository();
    loginApp.resetPassword(email);
  }

  Future<void> singUp(UserModel user) async {
    isLoading.value = true;
    AuthRepository loginApp = AuthRepository();
    AuthResult? authResult = await loginApp.singUp(user);
    authResult!.when(
      sucess: (user) {
        isLoading.value = false;
        this.userModel = user;
        Map<String, String> token_user = {
          KeysApp.userToken: user.token.toString(),
        };
        _utils.saveLocalData(token_user);
        Get.offAllNamed(PagesRoutes.baseRoute);
      },
      error: (message) {
        isLoading.value = false;
        _utils.showToats(message: message);
      },
    );
  }

  Future<bool> signOut({required String key}) async {
    userModel = UserModel();
    return await _utils.deleteLocalData(KeysApp.userToken);
  }

  Future<void> validateToken() async {
    String userToken = await _utils.loadLocalData(KeysApp.userToken) ?? '';
    AuthResult _user;
    if (userToken == null) {
      Get.offAllNamed(PagesRoutes.singInRoute);
    } else {
      AuthRepository loginApp = AuthRepository();
      _user = await loginApp.validateToken(userToken);
      _user.when(
        sucess: (user) {
          userModel = user;
          Get.offAllNamed(PagesRoutes.baseRoute);
        },
        error: (error) {
          signOut(
            key: KeysApp.userToken,
          );
          Get.offAllNamed(PagesRoutes.singInRoute);
        },
      );

      _user.printInfo();
    }
  }
}
