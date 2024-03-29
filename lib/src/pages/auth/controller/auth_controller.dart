import 'package:get/get.dart';
import 'package:sacolao_de_frutas/src/models/user_model.dart';
import 'package:sacolao_de_frutas/src/service/form_services.dart';

import '../../../service/connectivitywidget.dart';
import '../../../service/error_type.dart';
import '../../../service/provider_manager.dart';
import '../../pages_routes/app_pages.dart';
import '../repository/auth_repository.dart';
import '../result/auth_result.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool hasUsed = false.obs;
  RxBool isLoadingChangePassword = false.obs;
  UserModel userModel = UserModel();
  final UtilsService _utils = UtilsService();
  final authRepository = AuthRepository();
  final ConnectionService _connectionController = Get.find<ConnectionService>();

  @override
  void onInit() {
    super.onInit();

    validateToken();

    // Adiciona o ever para monitorar a conexão
    ever(
      _connectionController.connectionStatus,
      (isConnected) {
        if (hasUsed.value == false && isConnected != 0) {
          validateToken();
        }
      },
    );
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
        saveTokenAndProceedToBase();
        Get.offAllNamed(PagesRoutes.baseRoute);
      },
      error: (msg) {
        _utils.showToats(message: msg, isError: true);
      },
    );
  }

  Future<void> restPass(remail) async {
    AuthRepository loginApp = AuthRepository();
    loginApp.resetPassword(remail);
  }

  Future<void> singUp(UserModel user) async {
    isLoading.value = true;
    AuthResult? authResult = await authRepository.singUp(user);
    authResult!.when(
      sucess: (user) {
        isLoading.value = false;
        userModel = user;
        saveTokenAndProceedToBase();
        Get.offAllNamed(PagesRoutes.baseRoute);
      },
      error: (message) {
        isLoading.value = false;
        _utils.showToats(message: message);
      },
    );
  }

  Future<void> signOut() async {
    await _utils.deleteLocalData(KeysApp.userToken);
    Get.offAllNamed(PagesRoutes.singInRoute);
  }

  void saveTokenAndProceedToBase() {
    // Salvar o token
    Map<String, dynamic> doToken = {KeysApp.userToken: userModel.token!};
    _utils.saveLocalData(doToken);

    // Ir para a base
    Get.offAllNamed(PagesRoutes.baseRoute);
  }

  Future<void> validateToken() async {
    if (_connectionController.connectionStatus.value == 0) {
      //_utils.showToats(message: 'Sem conexão com a internet !');
      if (_connectionController.connectionStatus.value == 0) {
        return;
      }
    } else {
      String userToken = await _utils.loadLocalData(KeysApp.userToken) ?? '';
      AuthResult _user;
      // ignore: unnecessary_null_comparison
      if (userToken.isEmpty) {
        Get.offAllNamed(PagesRoutes.singInRoute);
        return;
      } else {
        AuthRepository loginApp = AuthRepository();
        _user = await loginApp.validateToken(userToken);
        _user.when(
          sucess: (user) {
            userModel = user;
            hasUsed.value = true;
            saveTokenAndProceedToBase();
          },
          error: (error) {
            if (error == ErrorAppType.invalidCredentials) {
              signOut();
            } else if (error == ErrorAppType.invalidToken) {
              signOut();
            } else if (error == ErrorAppType.invalidTokenSession) {
              signOut();
            } else if (error == ErrorAppType.notAcessInternet) {
              _connectionController.connectionStatus.value = 0;
            }
          },
        );

        _user.printInfo();
      }
    }
  }
}
