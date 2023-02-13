import 'package:get/get.dart';
import 'package:sacolao_de_frutas/src/models/cart_item_model.dart';
import 'package:sacolao_de_frutas/src/models/item_model.dart';
import 'package:sacolao_de_frutas/src/pages/auth/controller/auth_controller.dart';
import 'package:sacolao_de_frutas/src/pages/cart/cart_result/cart_result.dart';
import 'package:sacolao_de_frutas/src/service/form_services.dart';

import '../repository/cart_repository.dart';

class CartController extends GetxController {
  final cartRepository = CartRepository();
  final authController = Get.find<AuthController>();
  final utilServices = UtilsService();

  List<CartItemModel> cartItems = [];

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
        print(data);
      },
      error: (message) {
        utilServices.showToats(message: message, isError: true);
      },
    );
  }

  int getItemIndex(ItemModel item) {
    return cartItems.indexWhere((itemInList) => itemInList.item.id == item.id);
  }

  Future<bool> changeItemQuantity({
    required CartItemModel item,
    required int quantity,
  }) async {
    final result = cartRepository.changeItemQuantity(
      token: authController.userModel.token!,
      cartItemId: item.id,
      quantity: quantity,
    );

    return result;
  }

  Future<void> addItemToCart(
      {required ItemModel item, int quantity = 1}) async {
    int itemIndex = getItemIndex(item);
    if (itemIndex >= 0) {
      final product = cartItems[itemIndex];
      final result = await changeItemQuantity(
          item: product, quantity: product.quantity + quantity);
      //Ja existe na listagem
      if (result) {
        cartItems[itemIndex].quantity += quantity;
      } else {
        utilServices.showToats(
            message: 'Ocorreu um erro ao alterar a quantidade de produtos',
            isError: true);
      }
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
