import 'package:get/get.dart';
import 'package:sacolao_de_frutas/src/models/order_model.dart';
import 'package:sacolao_de_frutas/src/pages/auth/controller/auth_controller.dart';
import 'package:sacolao_de_frutas/src/pages/orders/repository/orders_repository.dart';
import 'package:sacolao_de_frutas/src/service/form_services.dart';
import '../orders_result/order_result.dart';

class AllOrdersController extends GetxController {
  List<OrderModel> allOrders = [];
  final orderRepository = OrdersRepository();
  final userModel = Get.find<AuthController>();
  final utilService = UtilsService();

  @override
  void onInit() {
    super.onInit();
    getAllOrders();
  }

  Future<void> getAllOrders() async {
    OrderResult<List<OrderModel>> result = await orderRepository.getOrders(
      userId: userModel.userModel.id!,
      token: userModel.userModel.token!,
    );
    result.when(
      sucess: (data) {
        allOrders = data
          ..sort(
            ((a, b) => b.createDateTime!.compareTo(a.createDateTime!)),
          );
        update();
      },
      error: (error) {
        utilService.showToats(
          message: error,
          isError: true,
        );
      },
    );
  }
}
