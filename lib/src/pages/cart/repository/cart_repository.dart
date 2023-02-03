import 'package:analyzer/dart/ast/token.dart';
import 'package:sacolao_de_frutas/src/const/endpoint.dart';
import 'package:sacolao_de_frutas/src/models/card_item_model.dart';
import 'package:sacolao_de_frutas/src/pages/cart/cart_result/cart_result.dart';

import '../../../service/provider_manager.dart';

class CartRepository {
  final _httpManager = HttpManager();
//<CartItemModel<List>>
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
    List<CartResult> lista = [];
    if (result['result'] != null) {
      print(result['result']);

      return lista;
    } else {
      return lista;
    }
  }
}
