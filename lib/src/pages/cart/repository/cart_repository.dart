import 'package:analyzer/dart/ast/token.dart';
import 'package:sacolao_de_frutas/src/const/endpoint.dart';
import 'package:sacolao_de_frutas/src/models/cart_item_model.dart';
import 'package:sacolao_de_frutas/src/pages/cart/cart_result/cart_result.dart';

import '../../../service/provider_manager.dart';

class CartRepository {
  final _httpManager = HttpManager();
//<CartItemModel<List>>
  Future<CartResult<List<CartItemModel>>> getCartItems(
      {required String token, required String userId}) async {
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
      List<CartItemModel> data =
          List<Map<String, dynamic>>.from(result['result'])
              .map(CartItemModel.fromJson)
              .toList();
      return CartResult<List<CartItemModel>>.success(data);
    } else {
      return CartResult.error(
          'Ocorreu um erro ao recuperar os items do carinho !');
    }
  }
}
