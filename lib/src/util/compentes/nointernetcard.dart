import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../service/connectivitywidget.dart';

class NoInternetCard extends StatelessWidget {
  NoInternetCard({Key? key}) : super(key: key);
  final ConnectionService _connectionService = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Card(
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Sem internet',
                        style: const TextStyle(fontSize: 16.0),
                      ),
                      const SizedBox(height: 16.0),
                      ElevatedButton(
                        child: const Text('Tente Novamente'),
                        onPressed: () async {
                          await _connectionService.checkInitialConnection();
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
