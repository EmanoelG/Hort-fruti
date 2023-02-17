
import 'package:flutter/material.dart';

import 'package:sacolao_de_frutas/src/config/custom_color.dart';
import 'package:sacolao_de_frutas/src/util/font_app.dart';

class OrderStatusWidget extends StatelessWidget {
  final String status;
  final bool isOverDue;
  final Map<String, int> allStatus = <String, int>{
    'pending_payment': 0,
    'refunded': 1,
    'paid': 2,
    'preparing_purchase': 3,
    'shipping': 4,
    'delivered': 5,
  };
  int get currentStatus => allStatus[status]!;

  OrderStatusWidget({
    Key? key,
    required this.status,
    required this.isOverDue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StatusDot(isActive: true, title: 'Pedido confirmado'),
        const _CustomDivider(),
        if (currentStatus == 1) ...[
          StatusDot(
            isActive: true,
            title: 'Pix estornado',
            backGroundColorBorder: Colors.black,
            iconStatus: Icons.warning_rounded,
            backGroundColor: Colors.orange,
          ),
        ] else if (isOverDue) ...[
          StatusDot(
            isActive: true,
            title: 'Pagamento Pix vencido',
            backGroundColor: Colors.orange,
            iconStatus: Icons.warning_rounded,
            backGroundColorBorder: Colors.black,
          ),
        ] else ...[
          StatusDot(isActive: currentStatus >= 2, title: 'Pagamento'),
          const _CustomDivider(),
          StatusDot(isActive: currentStatus >= 3, title: 'Preparando'),
          const _CustomDivider(),
          StatusDot(isActive: currentStatus >= 4, title: 'Envio'),
          const _CustomDivider(),
          StatusDot(isActive: currentStatus >= 5, title: 'Entregue'),
        ]
      ],
    );
  }
}

class _CustomDivider extends StatelessWidget {
  const _CustomDivider({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      height: 10,
      width: 2,
      color: Colors.grey.shade300,
    );
  }
}

class StatusDot extends StatelessWidget {
  final bool isActive;
  final String title;
  final Color? backGroundColor;
  Color? backGroundColorBorder;
  final IconData iconStatus;
  StatusDot({
    Key? key,
    required this.isActive,
    required this.title,
    this.backGroundColor,
    this.backGroundColorBorder,
    this.iconStatus = Icons.check,
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
              color: backGroundColorBorder ?? CustomColors.colorButtonMain,
            ),
            color: isActive
                ? backGroundColor ?? CustomColors.colorButtonMain
                : Colors.transparent,
          ),
          child: isActive
              ? Icon(
                  iconStatus,
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
