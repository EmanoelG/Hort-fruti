import 'dart:ffi';

import 'package:sacolao_de_frutas/src/service/provider_manager.dart';

import '../../../const/endpoint.dart';
import '../../../models/user_model.dart';

class AuthRepository {
  final HttpManager _httpManager = HttpManager();
  Future<bool> sigIn({required String email, required String password}) async {
    try {
      final result = await _httpManager.restRequest(
        url: EndPoints.signin,
        metod: HttpMetod.post,
        body: {"email": email, "password": password},
      );
      if (result['result'] != null) {
        UserModel _user = UserModel();
        _user = UserModel.fromMap(result['result']);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Req erro: ${e}');
      return false;
    }
  }
}
