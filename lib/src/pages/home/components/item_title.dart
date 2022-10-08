import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:sacolao_de_frutas/src/config/app_data.dart' as app_data;

import '../../../config/custom_color.dart';

class ItemTitle extends StatelessWidget {
  int index;
  ItemTitle({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromARGB(255, 255, 254, 254),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(
              child: CachedNetworkImage(
                imageUrl: app_data.items[index].img,
                width: 400,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  app_data.items[index].ItemName,
                  maxLines: 1,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Text.rich(TextSpan(
              children: [
                TextSpan(
                  text: 'RS' + app_data.items[index].precie,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: CustomColors.colorButtonMain,
                  ),
                ),
                TextSpan(
                  text: '/' + app_data.items[index].unit,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.black54),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
