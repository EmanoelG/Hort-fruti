import 'dart:ffi';

import 'package:sacolao_de_frutas/src/models/item_model.dart';

class CartItemModel {
  ItemModel item;
  int quantity;
  CartItemModel({
    required this.item,
    required this.quantity,
  });

  double totalPrice() => double.parse(item.precie) * quantity;
}
