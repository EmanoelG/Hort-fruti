import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:sacolao_de_frutas/src/config/app_data.dart' as app_data;
import 'package:sacolao_de_frutas/src/util/push_function.dart';

import '../../../config/custom_color.dart';
import '../../../models/item_model.dart';
import '../../../service/forma_services.dart';
import '../../product/product_screen.dart';

class ItemTitle extends StatelessWidget {
  final ItemModel Item;

  late void Function(GlobalKey) runAddToCardAnimationMethod;
  ItemTitle({
    Key? key,
    required this.Item,
    required this.runAddToCardAnimationMethod,
  }) : super(key: key);
  final UtilsService utilsService = UtilsService();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            push(
              context,
              ProdutctScreen(
                itemMod: Item,
              ),
            );
          },
          child: Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            color: Color.fromARGB(255, 255, 254, 254),
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  CachedNetworkImage(
                  imageUrl: Item.img,
                  key: imageOk,
                  width: 400,
                  fit: BoxFit.cover,
                  ),
                
                  const SizedBox(
                    height: 5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Item.ItemName,
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
                            .priceToCurrency(double.parse(Item.precie)),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: CustomColors.colorButtonMain,
                        ),
                      ),
                      TextSpan(
                        text: '/' + Item.unit,
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
        Positioned(
          top: 4,
          right: 4,
          child: GestureDetector(
            onTap: (() {
              runAddToCardAnimationMethod(imageOk);
            }),
            child: Container(
              height: 30,
              width: 30,
              decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: const Icon(
                Icons.add_shopping_cart_outlined,
                size: 20,
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    );
  }
}
