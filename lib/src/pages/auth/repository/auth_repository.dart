import 'dart:ffi';

import 'package:sacolao_de_frutas/src/service/provider_manager.dart';

import '../../../const/endpoint.dart';

class AuthRepository {
  final HttpManager _httpManager = HttpManager();
  Future<bool?> sigIn({required String email, required String password}) async {
    final result = await _httpManager.restRequest(
      url: EndPoints.signin,
      metod: HttpMetod.post,
      body: {"email": email, "password": password},
    );

    if (result['result'] != '') {
      print(result.toString());

      return true;
    } else {

      return false;
    }
  }
}
