import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sacolao_de_frutas/src/config/app_data.dart';
import 'package:sacolao_de_frutas/src/pages/cart/controller/cart_controller.dart';

import '../../../../config/custom_color.dart';
import '../../../../models/cart_item_model.dart';
import '../../../../service/form_services.dart';
import '../../../common_widgets/quantity_widget.dart';

class CartTitle extends StatefulWidget {
  final CartItemModel cartIte;
  const CartTitle({
    Key? key,
    required this.cartIte,
  }) : super(key: key);

  @override
  State<CartTitle> createState() => _CartTitleState();
}

class _CartTitleState extends State<CartTitle> {
  final UtilsService utilsService = UtilsService();
  final controller = Get.find<CartController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: ListTile(
          leading: Image.network(
            widget.cartIte.item.img,
            height: 50,
          ),
          title: Text(
            widget.cartIte.item.ItemName,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            textAlign: TextAlign.left,
          ),
          subtitle: Text(
            utilsService.priceToCurrency(
                (widget.cartIte.item.price) * widget.cartIte.quantity),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: CustomColors.colorButtonMain,
            ),
            textAlign: TextAlign.left,
          ),
          trailing: QuantityWidget(
            result: (quantity) {
              controller.changeItemQuantity(
                item: widget.cartIte,
                quantity: quantity,
              );
            },
            suffxText: widget.cartIte.item.unit,
            value: widget.cartIte.quantity,
            isRemovable: false,
          ),
        ),
      ),
    );
  }
}
