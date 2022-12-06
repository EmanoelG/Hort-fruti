import 'package:sacolao_de_frutas/src/service/provider_manager.dart';
import '../../../const/endpoint.dart';
import '../../../models/user_model.dart';
import '../result/auth_result.dart';
import 'auth_errors.dart';

class AuthRepository {
  final HttpManager _httpManager = HttpManager();
  Future<AuthResult> validateToken(String token) async {
    Map<String, String> token_header = {
      'X-Parse-Session-Token': token,
    };
    try {
      final result = await _httpManager.restRequest(
          url: EndPoints.validateToken,
          metod: HttpMetod.post,
          headers: token_header);
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
    print(user.toJson());
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
    final result = await _httpManager.restRequest(
      url: EndPoints.resetPassword,
      metod: HttpMetod.post,
      body: {
        "email": email,
      },
    );
    print(result);
    // return handleuserOrError(result);
  }

  handleuserOrError(Map<dynamic, dynamic> result) {
    print('result: ' + result.toString());
    if (result['result'] != null) {
      UserModel _user = UserModel();
      _user = UserModel.fromMap(result['result']);
      return AuthResult.sucess(_user);
    } else {
      return AuthResult.error(authErrorString(result['error']));
    }
  }
}
