import 'package:get/get.dart';
import 'package:sacolao_de_frutas/src/models/user_model.dart';
import 'package:sacolao_de_frutas/src/service/form_services.dart';

import '../../../service/provider_manager.dart';
import '../../pages_routes/app_pages.dart';
import '../repository/auth_repository.dart';
import '../result/auth_result.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLoadingChangePassword = false.obs;
  UserModel userModel = UserModel();
  final UtilsService _utils = UtilsService();
  final authRepository = AuthRepository();
  @override
  void onInit() {
    super.onInit();
    validateToken();
  }

  setValueChangePassword(value) {
    isLoadingChangePassword.value = value;
    update();
  }

  Future<void> changePassword({
    required String senhaAtual,
    required String novaSenha,
  }) async {
    setValueChangePassword(true);
    final result = await authRepository.changePassword(
      email: userModel.email!,
      currentPassword: senhaAtual,
      newPassword: novaSenha,
      token: userModel.token!,
    );
    setValueChangePassword(false);
    if (result == true) {
      _utils.showToats(
        message: 'A senha foi atualizada com sucesso !',
        isError: false,
      );

      signOut();
    } else {
      _utils.showToats(
        message: 'A senha atual está incorreta ! ',
        isError: true,
      );
    }
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
        Map<String, String> tokenUser = {
          KeysApp.userToken: userModel.token.toString(),
        };
        _utils.saveLocalData(tokenUser);
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
    AuthResult? authResult = await authRepository.singUp(user);
    authResult!.when(
      sucess: (user) {
        isLoading.value = false;
        userModel = user;
        Map<String, String> tokenUser = {
          KeysApp.userToken: user.token.toString(),
        };
        _utils.saveLocalData(tokenUser);
        Get.offAllNamed(PagesRoutes.baseRoute);
      },
      error: (message) {
        isLoading.value = false;
        _utils.showToats(message: message);
      },
    );
  }

  Future<void> signOut() async {
    userModel = UserModel();
    _utils.deleteLocalData(userModel.token ?? '');
    Get.offAllNamed(PagesRoutes.singInRoute);
  }

  Future<void> validateToken() async {
    String userToken = await _utils.loadLocalData(KeysApp.userToken) ?? '';
    AuthResult _user;
    if (userToken.isEmpty) {
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
          signOut();
          Get.offAllNamed(PagesRoutes.singInRoute);
        },
      );

      _user.printInfo();
    }
  }
}
