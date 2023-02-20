import 'package:get/get.dart';

import '../../../models/cart_item_model.dart';
import '../../../models/order_model.dart';
import '../../../service/form_services.dart';
import '../../auth/controller/auth_controller.dart';
import '../orders_result/order_result.dart';
import '../repository/orders_repository.dart';

class OrderController extends GetxController {
  OrderModel order;
  OrderController({
    required this.order,
  });

  final orderRepository = OrdersRepository();
  final authController = Get.find<AuthController>();
  final utilsService = UtilsService();
  bool isLoading = false;

  void setLaoding(value) {
    isLoading = value;
    update();
  }

  Future<void> getOrderItems() async {
    setLaoding(true);
    final OrderResult<List<CartItemModel>> result =
        await orderRepository.getOrdersItems(
      id: order.id,
      token: authController.userModel.token!,
    );
    setLaoding(false);
    result.when(
      sucess: (items) {
        order.items = items;
        update();
      },
      error: (error) {
        utilsService.showToats(message: error, isError: true);
      },
    );
  }
}
