import 'package:flutter/material.dart';
import 'package:sacolao_de_frutas/src/config/app_data.dart';

import 'package:sacolao_de_frutas/src/models/card_item_model.dart';
import 'package:sacolao_de_frutas/src/models/order_model.dart';

import '../../../service/forma_services.dart';
import '../../../util/font_app.dart';
import '../../profile/payment_dialog.dart';
import 'order_status_widget.dart';

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
          initiallyExpanded: order.status == 'pending_payment',
          childrenPadding: EdgeInsets.fromLTRB(16, 0, 16, 16),
          expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            IntrinsicHeight(
              child: Row(
                children: [
                  //Lista de produto
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: 150,
                      child: ListView(
                        children: order.items.map(
                          (order) {
                            return _orderItemWidget(order);
                          },
                        ).toList(),
                      ),
                    ),
                  ),
                  //Divisao
                  const VerticalDivider(
                    color: Colors.black,
                    thickness: 1,
                    width: 8,
                  ),
                  //Status do pedido
                  Expanded(
                    child: OrderStatusWidget(
                      status: order.status,
                      isOverDue: order.overDueDateTime.isBefore(DateTime.now()),
                    ),
                  ),
                ],
              ),
            ),

            //total
            Text.rich(
              TextSpan(
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                children: [
                  const TextSpan(
                    text: 'Total ',
                  ),
                  TextSpan(
                    text: service.priceToCurrency(order.total),
                  ),
                ],
              ),
            ), //botao
            Visibility(
              visible: order.status == 'pending_payment',
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: (() {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return const PaymentDialog();
                    },
                  );
                }),
                icon: const Icon(Icons.pix),
                label: TextApp(
                  texto: 'Ver QrCode pix',
                ),
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
                colorFont: Colors.black,
                texto: service.FormatDateTime(order.createDateTime),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding _orderItemWidget(CartItemModel order) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextApp(
            texto: order.quantity.toString() + ' ' + order.item.unit + ' ',
          ),
          Expanded(
            child: TextApp(
              texto: order.item.ItemName.toString(),
            ),
          ),
          TextApp(
            texto: service.priceToCurrency(order.totalPrice()),
          ),
        ],
      ),
    );
  }
}
