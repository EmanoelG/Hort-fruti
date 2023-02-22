import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sacolao_de_frutas/src/models/item_model.dart';
import 'package:sacolao_de_frutas/src/pages/base/controller/navigation_controller.dart';
import 'package:sacolao_de_frutas/src/pages/cart/controller/cart_controller.dart';
import 'package:sacolao_de_frutas/src/service/form_services.dart';

import '../common_widgets/quantity_widget.dart';

class ProdutctScreen extends StatefulWidget {
  const ProdutctScreen({Key? key}) : super(key: key);

  @override
  State<ProdutctScreen> createState() => _ProdutctScreenState();
}

class _ProdutctScreenState extends State<ProdutctScreen> {
  final UtilsService utilsService = UtilsService();
  final navigationController = Get.find<NavigationController>();
  int cartItemQuantity = 1;
  final ItemModel item = Get.arguments;
  final cartController = Get.find<CartController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Hero(
                  tag: item.img,
                  child: Image.network(item.img),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade600,
                        offset: const Offset(0, 2),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item.itemName,
                            style: const TextStyle(
                              fontSize: 27,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          QuantityWidget(
                            suffxText: item.unit,
                            value: cartItemQuantity,
                            result: (quantity) {
                              setState(
                                () {
                                  cartItemQuantity = quantity;
                                },
                              );
                            },
                          ),
                        ],
                      ),
                      Text(
                        utilsService.priceToCurrency(
                          (item.price),
                        ),
                        style: const TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SingleChildScrollView(
                            child: Text(
                              item.description,
                              style: const TextStyle(
                                height: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        //height: 55,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                          ),
                          onPressed: () {
                            //Fechar
                            Get.back();
                            //Abrir o carrinho
                            cartController.addItemToCart(
                              item: item,
                              quantity: cartItemQuantity,
                            );
                            navigationController
                                .navigationPageView(NavigationTabs.cart);
                          },
                          label: const Text(
                            'Adicionar',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          icon: const Icon(
                            Icons.shopping_cart_checkout_outlined,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            left: 10,
            top: 10,
            child: SafeArea(
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back_ios),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
