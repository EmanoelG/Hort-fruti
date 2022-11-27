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
      if (result['result'] != null) {
        UserModel _user = UserModel();
        _user = UserModel.fromMap(result['result']);
        return AuthResult.sucess(_user);
      } else {
        return AuthResult.error(authErrorString(result['error']));
      }
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
      if (result['result'] != null) {
        UserModel _user = UserModel();
        _user = UserModel.fromMap(result['result']);
        return AuthResult.sucess(_user);
      } else {
        return AuthResult.error(authErrorString(result['error']));
      }
    } catch (e) {
      return AuthResult.error('{"error": "Internal error ${e.toString()}"  }');
    }
  }
}
