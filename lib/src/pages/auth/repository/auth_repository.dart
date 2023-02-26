import 'package:get/get_connect/connect.dart';
import 'package:sacolao_de_frutas/src/service/provider_manager.dart';
import '../../../const/endpoint.dart';
import '../../../models/user_model.dart';
import '../result/auth_result.dart';
import 'auth_errors.dart';

class AuthRepository extends GetConnect {
  final HttpManager _httpManager = HttpManager();

  Future<bool> changePassword({
    required String email,
    required String currentPassword,
    required String newPassword,
    required String token,
  }) async {
    final result = await _httpManager.restRequest(
      url: EndPoints.changePassword,
      metod: HttpMetod.post,
      body: {
        "email": email,
        "currentPassword": currentPassword,
        "newPassword": newPassword,
      },
      headers: {
        "X-Parse-Session-Token": token,
      },
    );

    return result['error'] == null;
  }

  Future<AuthResult> validateToken(String token) async {
    Map<String, String> tokenHeader = {
      'X-Parse-Session-Token': token,
    };
    try {
      final result = await _httpManager.restRequest(
        url: EndPoints.validateToken,
        metod: HttpMetod.post,
        headers: tokenHeader,
      );
      return handleuserOrError(result);
    } catch (e) {
      return AuthResult.error('{"error": "Internal error ${e.toString()}"  }');
    }
  }

  Future<AuthResult> sigIn(
      {required String email, required String password}) async {
    try {
      final result = await _httpManager.restRequest(
        url: EndPoints.signin,
        metod: HttpMetod.post,
        body: {"email": email, "password": password},
      );
      return handleuserOrError(result);
    } catch (e) {
      return AuthResult.error('{"error": "Internal error ${e.toString()}"  }');
    }
  }

  Future<AuthResult?> singUp(UserModel user) async {
    var result = await _httpManager.restRequest(
      url: EndPoints.signUpW,
      metod: HttpMetod.post,
      body: {
        "email": user.email,
        "password": user.senha,
        "fullname": user.name,
        "phone": user.celular,
        "cpf": user.cpf
      },
    );

    return handleuserOrError(result);
  }

  Future<void> resetPassword(String email) async {
    await _httpManager.restRequest(
      url: EndPoints.resetPassword,
      metod: HttpMetod.post,
      body: {
        "email": email,
      },
    );
    // return handleuserOrError(result);
  }

  handleuserOrError(Map<dynamic, dynamic> result) {
    if (result['result'] != null) {
      UserModel _user = UserModel();
      _user = UserModel.fromMap(result['result']);
      return AuthResult.sucess(_user);
    } else {
      return AuthResult.error(authErrorString(result['error']));
    }
  }
}
