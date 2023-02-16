import 'package:flutter/material.dart';
import 'package:sacolao_de_frutas/src/config/app_data.dart' as appadata;

import 'components/order_title.dart';

class OrdersTab extends StatelessWidget {
  const OrdersTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(10),
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: OrderTitle(order: appadata.orders[index]),
          );
        },
        separatorBuilder: (_, index) {
          return const SizedBox(
            height: 10,
          );
        },
        itemCount: appadata.orders.length,
      ),
    );
  }
}
