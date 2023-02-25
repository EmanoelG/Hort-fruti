import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../main.dart';

class ConnectionService extends GetxService {
  RxInt connectionStatus = 0.obs;
  RxBool hasInitialConnection = false.obs;
  RxInt timeDoConnection = 0.obs;

  @override
  void onInit() {
    super.onInit();
    timeDoConnection.value = 10;
    checkInitialConnection();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      updateConnectionStatus(result);
    });
  }

  Future<void> checkInitialConnection() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    updateConnectionStatus(connectivityResult);
    hasInitialConnection.value = true;
  }

  final snackBar = const SnackBar(
    content: Text('Sem conexão com a internet'),
    backgroundColor: Colors.red,
    duration: Duration(
      days: 1,
    ),
  );

  void updateConnectionStatus(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        connectionStatus.value = 1;
        scaffoldMessengerKey.currentState!
            .hideCurrentSnackBar(reason: SnackBarClosedReason.dismiss);
        break;
      case ConnectivityResult.mobile:
        connectionStatus.value = 1;
        scaffoldMessengerKey.currentState!
            .hideCurrentSnackBar(reason: SnackBarClosedReason.dismiss);
        break;
      case ConnectivityResult.none:
        connectionStatus.value = 0;
        scaffoldMessengerKey.currentState!.showSnackBar(snackBar);
        break;
      default:
        connectionStatus.value = 0;
        break;
    }
  }
}
