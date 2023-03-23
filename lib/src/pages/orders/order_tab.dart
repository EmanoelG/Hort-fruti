import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sacolao_de_frutas/src/pages/orders/controller/all_orders_controller.dart';

import 'view/components/order_title.dart';

class OrdersTab extends StatelessWidget {
  OrdersTab({Key? key}) : super(key: key);
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text('Pedidos'),
  //     ),
  //     body: GetBuilder<AllOrdersController>(
  //       builder: (controller) {
  //         return RefreshIndicator(
  //           triggerMode: RefreshIndicatorTriggerMode.anywhere,
  //           edgeOffset: ,
  //           child: Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: ListView.separated(
  //               physics: const BouncingScrollPhysics(),
  //               itemBuilder: (_, index) {
  //                 return OrderTitle(order: controller.allOrders[index]);
  //               },
  //               separatorBuilder: (_, index) {
  //                 return const SizedBox(
  //                   height: 1,
  //                 );
  //               },
  //               itemCount: controller.allOrders.length,
  //             ),
  //           ),
  //           onRefresh: () => controller.getAllOrders(),
  //         );
  //       },
  //     ),
  //   );
  // }

  Future<void> _refresh() async {
    final controller = Get.find<AllOrdersController>();
    controller.getAllOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos'),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: GetBuilder<AllOrdersController>(
          builder: (controller) {
            return ListView.separated(
              separatorBuilder: (_, index) {
                return const SizedBox(
                  height: 1,
                );
              },
              itemCount: controller.allOrders.length,
              itemBuilder: (_, index) {
                return OrderTitle(order: controller.allOrders[index]);
              },
            );
          },
        ),
      ),
    );
  }
}
