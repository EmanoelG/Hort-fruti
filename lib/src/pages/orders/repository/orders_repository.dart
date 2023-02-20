import 'package:sacolao_de_frutas/src/const/endpoint.dart';
import 'package:sacolao_de_frutas/src/models/order_model.dart';
import 'package:sacolao_de_frutas/src/service/provider_manager.dart';

import '../../../models/cart_item_model.dart';
import '../orders_result/order_result.dart';

class OrdersRepository {
  final _httpManager = HttpManager();

  Future<OrderResult<List<CartItemModel>>> getOrdersItems({
    required String id,
    required String token,
  }) async {
    final result = await _httpManager.restRequest(
      url: EndPoints.getOrdersItems,
      metod: HttpMetod.post,
      body: {
        "orderId": id,
      },
      headers: {
        "X-Parse-Session-Token": token,
      },
    );

    if (result['result'] != null) {
      List<CartItemModel> items =
          List<Map<String, dynamic>>.from(result['result'])
              .map(CartItemModel.fromJson)
              .toList();

      return OrderResult.sucess(items);
    } else {
      return OrderResult.error('Falha ao carregar produtos do pedidod !');
    }
  }

  Future<OrderResult<List<OrderModel>>> getOrders(
      {required String userId, required String token}) async {
    final result = await _httpManager.restRequest(
      url: EndPoints.getOrders,
      metod: HttpMetod.post,
      body: {"user": userId},
      headers: {
        "X-Parse-Session-Token": token,
      },
    );

    if (result['result'] != null) {
      List<OrderModel> orders =
          List<Map<String, dynamic>>.from(result['result'])
              .map(OrderModel.fromJson)
              .toList();

      return OrderResult<List<OrderModel>>.sucess(orders);
    } else {
      return OrderResult.error('Não foi possível recuperar os pedidos ');
    }
  }
}
