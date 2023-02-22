import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sacolao_de_frutas/src/models/cart_item_model.dart';
import 'package:sacolao_de_frutas/src/models/order_model.dart';
import 'package:sacolao_de_frutas/src/pages/orders/controller/order_controller.dart';
import '../../../../service/form_services.dart';
import '../../../../util/font_app.dart';
import '../../../common_widgets/payment_dialog.dart';
import 'order_status_widget.dart';

// ignore: must_be_immutable
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
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Theme(
        data: Theme.of(context)
            .copyWith(dividerColor: const Color.fromARGB(0, 226, 7, 7)),
        child: GetBuilder<OrderController>(
          init: OrderController(order: order),
          global: false,
          builder: (controller) {
            return expantionTitle(context: context, controller: controller);
          },
        ),
      ),
    );
  }

  // elevation: 1,
  // shape: RoundedRectangleBorder(
  //   borderRadius: BorderRadius.circular(20.0),
  // ),
  ExpansionTile expantionTitle(
      {required BuildContext context, required OrderController controller}) {
    return ExpansionTile(
      childrenPadding: const EdgeInsets.all(16),
      onExpansionChanged: (value) {
        if (value = true && order.items.isEmpty) {
          controller.getOrderItems();
        }
      },
      //  childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
      children: controller.isLoading
          ? [
              Container(
                height: 80,
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              )
            ]
          : [
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
                        isOverDue:
                            order.overDueDateTime.isBefore(DateTime.now()),
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
              ),
              //botao pagamento
              Visibility(
                visible: order.status == 'pending_payment' && !order.isOverDue,
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
                        return PaymentDialog(
                          order: order,
                        );
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
            texto: service.FormatDateTime(order.createDateTime!),
          ),
        ],
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
              texto: order.item.itemName.toString(),
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
