import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sacolao_de_frutas/src/service/form_services.dart';
import 'package:sacolao_de_frutas/src/util/font_app.dart';

import '../../models/order_model.dart';

class PaymentDialog extends StatelessWidget {
  final OrderModel order;
  PaymentDialog({Key? key, required this.order}) : super(key: key);
  final UtilsService service = UtilsService();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextApp(texto: 'Pagamento com Pix', fontSize: 16),
                  //QRDCODE
                  // QrImage(
                  //   data: service.decodeQrCodeImage(order.qrCodeImage),
                  //   version: QrVersions.auto,
                  //   size: 200.0,
                  // ),

                  Image.memory(
                    service.decodeQrCodeImage(order.qrCodeImage),
                    height: 200,
                    width: 200,
                  ),
                  //VENCIEMNTO
                  TextApp(
                      texto:
                          'Venciemnto ${service.FormatDateTime(order.overDueDateTime)}'), //TOTAL
                  TextApp(
                      texto: 'Total: ${service.priceToCurrency(order.total)}'),
                  //BOTAO COPIA E COLA
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                    icon: const Icon(Icons.copy),
                    onPressed: () {
                      FlutterClipboard.copy(order.copyAndPast).then((value) =>
                          service.showToats(message: 'Código copiado !'));

                      //  service.decodeQrCodeImage(order.qrCodeImage),
                    },
                    label: TextApp(
                      texto: 'Copiar código Pix',
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                onPressed: (() {
                  Navigator.of(context).pop();
                }),
                icon: const Icon(Icons.close),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
