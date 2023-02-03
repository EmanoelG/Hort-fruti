import 'package:analyzer/dart/ast/token.dart';
import 'package:sacolao_de_frutas/src/const/endpoint.dart';

import '../../../service/provider_manager.dart';

class CartRepository {
  final _httpManager = HttpManager();

  Future getCartItems({required String token, required String userId}) async {
    final result = await _httpManager.restRequest(
        url: EndPoints.getCartItems,
        metod: HttpMetod.post,
        headers: {
          'X-Parse-Session-Token': token,
        },
        body: {
          'user': userId,
        });

    if (result['result'] != null) {
      
    } else {}
  }
}
