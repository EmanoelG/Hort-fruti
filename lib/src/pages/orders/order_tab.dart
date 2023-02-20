import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sacolao_de_frutas/src/config/app_data.dart' as appadata;
import 'package:sacolao_de_frutas/src/pages/orders/controller/all_orders_controller.dart';

import 'view/components/order_title.dart';

class OrdersTab extends StatelessWidget {
  const OrdersTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos'),
      ),
      body: GetBuilder<AllOrdersController>(
        builder: (controller) {
          return RefreshIndicator(
            child: ListView.separated(
              padding: EdgeInsets.all(10),
              physics: BouncingScrollPhysics(),
              itemBuilder: (_, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: OrderTitle(order: controller.allOrders[index]),
                );
              },
              separatorBuilder: (_, index) {
                return const SizedBox(
                  height: 10,
                );
              },
              itemCount: controller.allOrders.length,
            ),
            onRefresh: () => controller.getAllOrders(),
            //physics : AlwaysScrollableScrollPhysics()
          );
        },
      ),
    );
  }
}
