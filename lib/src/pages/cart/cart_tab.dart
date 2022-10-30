import 'package:flutter/material.dart';

import 'package:sacolao_de_frutas/src/config/custom_color.dart';
import 'package:sacolao_de_frutas/src/service/forma_services.dart';

import '../../config/app_data.dart';
import '../../models/card_item_model.dart';
import 'components/card_item.dart';

class CartTab extends StatefulWidget {
  CartTab({Key? key}) : super(key: key);

  @override
  State<CartTab> createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  final UtilsService utilsService = UtilsService();
  double total = 0;
  void removeItemFromCart(CartItemModel cartitem) {
    setState(() {
      cartItems.remove(cartitem);
    });
  }

  double cartTotalPrice() {
    cartItems.forEach((element) {
      total = total + double.parse(element.item.precie) * element.quantity;
    });
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carinho'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return CartTitle(
                  utilsService: utilsService,
                  cartIte: cartItems[index],
                  remove: removeItemFromCart,
                  priceTotal: (total) {
                    setState(
                      () {
                        this.total = 0;
                        this.total = total;
                      },
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade600,
                    blurRadius: 3,
                    spreadRadius: 2,
                  )
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Total Geral',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  utilsService.priceToCurrency(cartTotalPrice()),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: CustomColors.colorButtonMain),
                ),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    onPressed: () {
                      ShowOrderConfirmartion(context);
                    },
                    child: const Text('Confirmar pedido'),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<dynamic> ShowOrderConfirmartion(BuildContext context) {
    return showDialog(
                      context: context,
                      builder: (context) {
                        return Container(
                          child: Text('Confirma '),
                        );
                      },
                    );
  }
}
