import 'package:flutter/material.dart';

import 'package:sacolao_de_frutas/src/config/custom_color.dart';
import 'package:sacolao_de_frutas/src/util/font_app.dart';

class OrderStatusWidget extends StatelessWidget {
  final String status;
  final bool isOverDue;
  const OrderStatusWidget({
    Key? key,
    required this.status,
    required this.isOverDue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        StatusDot(isActive: true, title: 'Maça'),
        StatusDot(isActive: false, title: 'Orange'),
      ],
    );
  }
}

class StatusDot extends StatelessWidget {
  final bool isActive;
  final String title;
  const StatusDot({
    Key? key,
    required this.isActive,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          alignment: Alignment.center,
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: CustomColors.colorButtonMain,
            ),
            color: isActive ? CustomColors.colorButtonMain : Colors.transparent,
          ),
          child: isActive
              ? const Icon(
                  Icons.check,
                  size: 13,
                  color: Colors.white,
                )
              : const SizedBox.shrink(),
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          child: TextApp(
            texto: title,
          ),
        ),
      ],
    );
  }
}
