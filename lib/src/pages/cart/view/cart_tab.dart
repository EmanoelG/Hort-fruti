import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sacolao_de_frutas/src/pages/cart/controller/cart_controller.dart';
import 'package:sacolao_de_frutas/src/util/font_app.dart';
import 'package:sacolao_de_frutas/src/config/custom_color.dart';
import 'package:sacolao_de_frutas/src/service/form_services.dart';

import 'components/card_item.dart';

class CartTab extends StatefulWidget {
  const CartTab({Key? key}) : super(key: key);

  @override
  State<CartTab> createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  final UtilsService utilsService = UtilsService();

  final controllerCart = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carinho'),
      ),
      body: Column(
        children: [
          //Lista de itens do carinho
          Expanded(
            child: GetBuilder<CartController>(
              builder: (controller) {
                if (controller.cartItems.isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.remove_shopping_cart,
                        size: 40,
                        color: Colors.black,
                      ),
                      TextApp(texto: 'Não há itens no carrinho ')
                    ],
                  );
                }

                return ListView.builder(
                  itemCount: controller.cartItems.length,
                  itemBuilder: (context, index) {
                    return CartTitle(
                      cartIte: controller.cartItems[index],
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
            child: GetBuilder<CartController>(
              builder: (controller) {
                return Column(
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
                      utilsService.priceToCurrency(controller.cartTotalPrice()),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: CustomColors.colorButtonMain),
                    ),
                    SizedBox(
                      height: 50,
                      child: GetBuilder<CartController>(
                        builder: (controller) {
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),
                            onPressed: (controller.isCheckoutLoad ||
                                    controller.cartItems.isEmpty)
                                ? null
                                : () async {
                                    bool? result =
                                        await showOrderConfirmartion(context);

                                    if (result ?? false) {
                                      await controllerCart.checkoutCart();
                                    } else {
                                      utilsService.showToats(
                                          message: 'Pedido não confirmado !');
                                    }
                                  },
                            child: controller.isCheckoutLoad
                                ? const CircularProgressIndicator()
                                : const Text('Confirmar pedido'),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Future<bool?> showOrderConfirmartion(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Confirmação'),
          content: const Text('Deseja concluir o pedido ?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Nâo'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Sim'),
            )
          ],
        );
      },
    );
  }
}
