import 'package:flutter/material.dart';

import '../../service/form_services.dart';

class TitleApp extends StatelessWidget {
  final int fontTitle;
  final Color? greenTitleColor;
  TitleApp({
    Key? key,
    this.fontTitle = 20,
    this.greenTitleColor,
  }) : super(key: key);
  final UtilsService service = UtilsService();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // service.showToats(message: 'Olá, mundo !');
      },
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: 'Green',
              style: TextStyle(
                  color: greenTitleColor ?? const Color.fromARGB(255, 3, 3, 3),
                  fontWeight: FontWeight.bold,
                  fontSize: fontTitle + 0),
            ),
            TextSpan(
              text: 'Grocer',
              style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: fontTitle + 0),
            ),
          ],
        ),
      ),
    );
  }
}
