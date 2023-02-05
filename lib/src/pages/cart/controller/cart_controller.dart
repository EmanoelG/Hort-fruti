import 'package:get/get.dart';
import 'package:sacolao_de_frutas/src/models/cart_item_model.dart';
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
}
