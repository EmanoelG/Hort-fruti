import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sacolao_de_frutas/src/config/app_data.dart' as app_data;
import 'package:sacolao_de_frutas/src/util/push_function.dart';

import '../../../../config/custom_color.dart';
import '../../../../models/item_model.dart';
import '../../../../service/form_services.dart';
import '../../../cart/controller/cart_controller.dart';
import '../../../pages_routes/app_pages.dart';
import '../../../product/product_screen.dart';

class ItemTitle extends StatefulWidget {
  final ItemModel Item;

  late void Function(GlobalKey) runAddToCardAnimationMethod;
  ItemTitle({
    Key? key,
    required this.Item,
    required this.runAddToCardAnimationMethod,
  }) : super(key: key);

  @override
  State<ItemTitle> createState() => _ItemTitleState();
}

class _ItemTitleState extends State<ItemTitle> {
  final UtilsService utilsService = UtilsService();
  final cartController = Get.find<CartController>();
  IconData titleIcon = Icons.add_shopping_cart_outlined;

  Future<void> switchIcon() async {
    setState(() => titleIcon = Icons.check);

    await Future.delayed(Duration(milliseconds: 1500));

    setState(() => titleIcon = Icons.add_shopping_cart_outlined);
  }

  @override
  Widget build(BuildContext context) {
    return itemStack(context);
  }

  Stack itemStack(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Material(
            child: InkWell(
              onTap: () {
//widget.Item
                Get.toNamed(PagesRoutes.productRoute, arguments: widget.Item);
              },
              //IMG PRODUTO
              child: Ink(
                // elevation: 1,
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.circular(20.0),
                // ),
                color: Color.fromARGB(255, 255, 254, 254),
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      CachedNetworkImage(
                        imageUrl: widget.Item.img,
                        width: 400,
                        height: 100,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.Item.ItemName,
                            maxLines: 1,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Text.rich(TextSpan(
                        children: [
                          TextSpan(
                            text: utilsService
                                .priceToCurrency((widget.Item.price)),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: CustomColors.colorButtonMain,
                            ),
                          ),
                          TextSpan(
                            text: '/' + widget.Item.unit,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.black54),
                          ),
                        ],
                      )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        //CART ICON
        Positioned(
          top: 4,
          right: 4,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            child: Material(
              child: InkWell(
                onTap: (() {
                  switchIcon();
                  cartController.addItemToCart(item: widget.Item);
                }),
                child: Ink(
                  height: 30,
                  width: 30,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                  ),
                  child: Icon(
                    titleIcon,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
