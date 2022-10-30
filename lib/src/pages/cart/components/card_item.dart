import 'package:flutter/material.dart';

import '../../../config/custom_color.dart';
import '../../../models/card_item_model.dart';
import '../../../service/forma_services.dart';
import '../../common_widgets/quantity_widget.dart';

class CartTitle extends StatelessWidget {
  CartItemModel cartItems;
  CartTitle({
    Key? key,
    required this.cartItems,
    required this.utilsService,
  }) : super(key: key);

  final UtilsService utilsService;

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
            cartItems.item.img,
            height: 50,
          ),
          title: Text(
            cartItems.item.ItemName,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            textAlign: TextAlign.left,
          ),
          subtitle: Text(
            utilsService.priceToCurrency(
                double.parse(cartItems.item.precie) * cartItems.quantity),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: CustomColors.colorButtonMain,
            ),
            textAlign: TextAlign.left,
          ),
          trailing: QuantityWidget(
            result: (quantity) {},
            suffxText: cartItems.item.unit,
            value: cartItems.quantity,
          ),
        ),
      ),
    );
  }
}
