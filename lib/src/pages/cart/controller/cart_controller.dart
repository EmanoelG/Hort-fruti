import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sacolao_de_frutas/src/models/cart_item_model.dart';
import 'package:sacolao_de_frutas/src/models/item_model.dart';
import 'package:sacolao_de_frutas/src/models/order_model.dart';
import 'package:sacolao_de_frutas/src/pages/auth/controller/auth_controller.dart';
import 'package:sacolao_de_frutas/src/pages/cart/cart_result/cart_result.dart';
import 'package:sacolao_de_frutas/src/service/form_services.dart';

import '../../common_widgets/payment_dialog.dart';
import '../repository/cart_repository.dart';

class CartController extends GetxController {
  final cartRepository = CartRepository();
  final authController = Get.find<AuthController>();
  final utilServices = UtilsService();

  List<CartItemModel> cartItems = [];
  bool isCheckoutLoad = false;

  @override
  void onInit() {
    super.onInit();
    getCartItems();
  }

  double cartTotalPrice() {
    double total = 0;

    for (final item in cartItems) {
      total += item.totalPrice();
    }

    return total;
  }

  Future<void> getCartItems() async {
    // userModel
    final CartResult<List<CartItemModel>> result =
        await cartRepository.getCartItems(
      token: authController.userModel.token!,
      userId: authController.userModel.id!,
    );

    result.when(
      success: (data) {
        cartItems = data;
        update();
        // print(data);
      },
      error: (message) {
        utilServices.showToats(message: message, isError: true);
      },
    );
  }

  void setCheckoutLoadin(bool value) {
    isCheckoutLoad = value;
    update();
  }

  Future checkoutCart() async {
    setCheckoutLoadin(true);
    CartResult<OrderModel> result = await cartRepository.checkoutCart(
      token: authController.userModel.token!,
      total: cartTotalPrice(),
    );
    setCheckoutLoadin(false);
    result.when(success: (order) {
      cartItems.clear();
      update();
      showDialog(
        context: Get.context!,
        builder: (_) {
          return PaymentDialog(
            order: order,
          );
        },
      );
    }, error: (error) {
      utilServices.showToats(
        message: error,
        isError: true,
      );
    });
    return result;
  }

  int getItemIndex(ItemModel item) {
    return cartItems.indexWhere((itemInList) => itemInList.item.id == item.id);
  }

  Future<bool> changeItemQuantity({
    required CartItemModel item,
    required int quantity,
  }) async {
    final result = await cartRepository.changeItemQuantity(
      token: authController.userModel.token!,
      cartItemId: item.id,
      quantity: quantity,
    );
    if (result) {
      try {
        if (quantity == 0) {
          cartItems.removeWhere((cartItem) => cartItem.id == item.id);
        } else {
          cartItems.firstWhere((cartItem) => cartItem.id == item.id).quantity =
              quantity;
        }
      } catch (e) {
        utilServices.showToats(message: e.toString(), isError: true);
      }
      update();
    } else {
      utilServices.showToats(
        message: 'Ocorreu um erro ao alterar a quantidade de produtos',
        isError: true,
      );
    }

    return result;
  }

  Future<void> addItemToCart(
      {required ItemModel item, int quantity = 1}) async {
    int itemIndex = getItemIndex(item);
    if (itemIndex >= 0) {
      final product = cartItems[itemIndex];
      await changeItemQuantity(
          item: product, quantity: product.quantity + quantity);
      //Ja existe na listagem

    } else {
      // Não existe na listagem
      final CartResult<String> result = await cartRepository.addItemToCart(
          userId: authController.userModel.id!,
          token: authController.userModel.token!,
          productId: item.id,
          quantity: quantity);

      result.when(success: (cartItemId) {
        cartItems.add(
          CartItemModel(id: cartItemId, item: item, quantity: quantity),
        );
      }, error: (message) {
        utilServices.showToats(message: message, isError: true);
      });
    }
    update();
  }
}
