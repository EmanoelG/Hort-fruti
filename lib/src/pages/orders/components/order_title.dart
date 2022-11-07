import 'package:flutter/material.dart';

import 'package:sacolao_de_frutas/src/models/order_model.dart';

import '../../../service/forma_services.dart';
import '../../../util/font_app.dart';

class OrderTitle extends StatelessWidget {
  final OrderModel order;
  OrderTitle({
    Key? key,
    required this.order,
  }) : super(key: key);
  UtilsService service = UtilsService();
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          childrenPadding: EdgeInsets.fromLTRB(16, 0, 16, 16),
          children: [
            SizedBox(
              height: 150,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: ListView(
                      children: order.items.map(
                        (order) {
                          return Row(
                            children: [
                              TextApp(
                                texto: order.quantity.toString(),
                              )
                            ],
                          );
                        },
                      ).toList(),
                    ),
                  ),
                  Expanded(child: Container(color: Colors.blue)),
                ],
              ),
            ),
          ],
          title: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextApp(
                texto: 'Pedido ${order.id}',
              ),
              TextApp(
                texto: service.FormatDateTime(order.createDateTime),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
