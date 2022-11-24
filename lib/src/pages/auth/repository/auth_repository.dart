import 'package:sacolao_de_frutas/src/service/provider_manager.dart';

import '../../../const/endpoint.dart';

class AuthRepository {
  final HttpManager _httpManager = HttpManager();
  Future sigIn({required String email, required String password}) async {
    _httpManager.restRequest(url: EndPoints.signin, metod: 'post');
  }
}
