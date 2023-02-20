import 'package:sacolao_de_frutas/src/const/endpoint.dart';
import 'package:sacolao_de_frutas/src/models/cart_item_model.dart';
import 'package:sacolao_de_frutas/src/models/order_model.dart';
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

  Future<bool> changeItemQuantity({
    required String token,
    required String cartItemId,
    required int quantity,
  }) async {
    final result = await _httpManager.restRequest(
        url: EndPoints.changeItemQuantity,
        metod: HttpMetod.post,
        body: {
          'cartItemId': cartItemId,
          "quantity": quantity
        },
        headers: {
          'X-Parse-Session-Token': token,
        });

    return result.isEmpty;
  }

  Future<CartResult<OrderModel>> checkoutCart({
    required String token,
    required double total,
  }) async {
    final result = await _httpManager.restRequest(
      url: EndPoints.checkout,
      metod: HttpMetod.post,
      body: {
        "total": total,
      },
      headers: {
        "X-Parse-Session-Token": token,
      },
    );

    if (result['result'] != null) {
      final order = OrderModel.fromJson(result['result']);
      return CartResult<OrderModel>.success(order);
    } else {
      return CartResult.error('Falha ao fazer pedido');
    }
  }

  Future<CartResult<String>> addItemToCart({
    required String userId,
    required String token,
    required String productId,
    required int quantity,
  }) async {
    final result = await _httpManager.restRequest(
        url: EndPoints.addItemToCart,
        metod: HttpMetod.post,
        body: {"user": userId, "quantity": quantity, "productId": productId},
        headers: {"X-Parse-Session-Token": token});

    if (result['result'] != null) {
      return CartResult.success(result['result']['id']);
    } else {
      return CartResult.error('Nâo possivel salvar !');
    }
  }
}
