import 'dart:ffi';

import 'package:get/get.dart';

import '../repository/auth_repository.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;

  Future<bool?> signIn(
      {required String email, required String password}) async {
    isLoading.value = true;
    AuthRepository login_app = AuthRepository();
    bool? result = await login_app.sigIn(email: email, password: password);

    return result;

    // await Future.delayed(Duration(seconds: 5));

    isLoading.value = false;
  }
}
