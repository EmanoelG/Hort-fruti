import 'package:get/get.dart';
import 'package:sacolao_de_frutas/src/pages/cart/controller/cart_controller.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CartController());
  }
}
