import 'dart:ffi';

import 'package:get/get.dart';
import 'package:sacolao_de_frutas/src/models/user_model.dart';
import 'package:sacolao_de_frutas/src/service/forma_services.dart';

import '../repository/auth_repository.dart';
import '../result/auth_result.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
  final UtilsService _utils = UtilsService();
  Future<bool> signIn({required String email, required String password}) async {
    isLoading.value = true;
    AuthResult _user;
    AuthRepository login_app = AuthRepository();
    _user = await login_app.sigIn(email: email, password: password);
    isLoading.value = false;
    _user.printInfo();
    _user.when(sucess: (UserModel user) {
      print('Usuario pode logar: ' + user.toString());
    }, error: (Msg) {
      print('Error ao tentar logar: ' + Msg);
      _utils.showToats(message: Msg);
    });
    UserModel iuser = UserModel();
    return false;
  }
}
