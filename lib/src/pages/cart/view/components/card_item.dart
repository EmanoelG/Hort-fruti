import 'package:flutter/material.dart';

import '../../../../config/custom_color.dart';
import '../../../../models/card_item_model.dart';
import '../../../../service/form_services.dart';
import '../../../common_widgets/quantity_widget.dart';

class CartTitle extends StatefulWidget {
  final CartItemModel cartIte;
  final Function(CartItemModel cartitem) remove;
  final Function priceTotal;
  const CartTitle({
    Key? key,
    required this.cartIte,
    required this.remove,
    required this.utilsService,
    required this.priceTotal,
  }) : super(key: key);

  final UtilsService utilsService;

  @override
  State<CartTitle> createState() => _CartTitleState();
}

class _CartTitleState extends State<CartTitle> {
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
            widget.utilsService.priceToCurrency(
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
              setState(
                () {
                  widget.cartIte.quantity = quantity;
                  if (quantity == 0) {
                    widget.remove(widget.cartIte);
                  }
                },
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
