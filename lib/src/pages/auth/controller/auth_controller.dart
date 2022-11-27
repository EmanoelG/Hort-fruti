import 'dart:ffi';

import 'package:get/get.dart';

import '../repository/auth_repository.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;

  Future<bool> signIn({required String email, required String password}) async {
    isLoading.value = true;
    bool? result = false;
    AuthRepository login_app = AuthRepository();
    result = await login_app.sigIn(email: email, password: password);
    isLoading.value = false;


    return result;
  }
}
