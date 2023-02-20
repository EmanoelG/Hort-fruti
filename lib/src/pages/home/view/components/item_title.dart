import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../config/custom_color.dart';
import '../../../../models/item_model.dart';
import '../../../../service/form_services.dart';
import '../../../cart/controller/cart_controller.dart';
import '../../../pages_routes/app_pages.dart';

// ignore: must_be_immutable
class ItemTitle extends StatefulWidget {
  final ItemModel item;

  late void Function(GlobalKey) runAddToCardAnimationMethod;
  ItemTitle({
    Key? key,
    required this.item,
    required this.runAddToCardAnimationMethod,
  }) : super(key: key);

  @override
  State<ItemTitle> createState() => _ItemTitleState();
}

class _ItemTitleState extends State<ItemTitle> {
  final UtilsService utilsService = UtilsService();
  final cartController = Get.find<CartController>();
  IconData titleIcon = Icons.add_shopping_cart_outlined;
  late Timer _timer;
  bool _addedToCart = false;
  // Future<void> switchIcon() async {
  //   setState(() => titleIcon = Icons.check);

  //   await Future.delayed(const Duration(milliseconds: 1500));

  //   setState(() => titleIcon = Icons.add_shopping_cart_outlined);
  // }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void switchIcon() {
    setState(() {
      _addedToCart = true;
      _timer = Timer(Duration(seconds: 3), () {
        setState(() {
          _addedToCart = false;
          cartController.addItemToCart(item: widget.item);
        });
      });
    });
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
                Get.toNamed(PagesRoutes.productRoute, arguments: widget.item);
              },
              //IMG PRODUTO
              child: Ink(
                // elevation: 1,
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.circular(20.0),
                // ),
                color: const Color.fromARGB(255, 255, 254, 254),
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      CachedNetworkImage(
                        imageUrl: widget.item.img,
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
                            widget.item.itemName,
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
                                .priceToCurrency((widget.item.price)),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: CustomColors.colorButtonMain,
                            ),
                          ),
                          TextSpan(
                            text: '/' + widget.item.unit,
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
                  // try {
                  //   switchIcon();
                  //   // ignore: empty_catches
                  // } catch (e) {
                  //   print('Error ' + e.toString());
                  // }
                }),
                child: Ink(
                  height: 30,
                  width: 30,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                  ),
                  child: IconButton(
                    icon:
                        Icon(_addedToCart ? Icons.check : Icons.shopping_cart),
                    color: Colors.white,
                    onPressed: switchIcon,
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
