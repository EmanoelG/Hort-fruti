import 'package:get/get.dart';
import 'package:sacolao_de_frutas/src/pages/auth/controller/auth_controller.dart';

import '../repository/cart_repository.dart';

class CartController extends GetxController {
  final cartRepository = CartRepository();
  final authController = Get.find<AuthController>();

  @override
  void onInit() {
    super.onInit();
    getCartItems();
  }

  Future<void> getCartItems() async {
    // userModel
    await cartRepository.getCartItems(
      token: authController.userModel.token!,
      userId: authController.userModel.id!,
    );
  }
}
