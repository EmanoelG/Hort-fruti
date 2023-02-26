import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../main.dart';

class ConnectionService extends GetxService {
  RxInt connectionStatus = 1.obs;
  RxBool hasInitialConnection = false.obs;
  RxInt timeDoConnection = 0.obs;
  RxBool internetController = false.obs;

  @override
  void onInit() {
    super.onInit();
    timeDoConnection.value = 10;
    internetController.value = true;
    checkInitialConnection();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      updateConnectionStatus(result);
    });
  }

  Future<void> checkInitialConnection() async {
    final connectivityResult = Connectivity().checkConnectivity();
    updateConnectionStatus(connectivityResult);
    hasInitialConnection.value = true;
  }

  final snackBarOff = SnackBar(
    action: SnackBarAction(
      label: 'Fechar',
      onPressed: () {
        scaffoldMessengerKey.currentState!
            .hideCurrentSnackBar(reason: SnackBarClosedReason.dismiss);
      },
    ),
    behavior: SnackBarBehavior.fixed,
    content: const Text('Sem conexão'),
    backgroundColor: Colors.red,
    duration: const Duration(
      days: 1,
    ),
  );

  final snackBarOn = SnackBar(
    action: SnackBarAction(
      label: 'Fechar',
      onPressed: () {
        scaffoldMessengerKey.currentState!
            .hideCurrentSnackBar(reason: SnackBarClosedReason.dismiss);
      },
    ),
    behavior: SnackBarBehavior.fixed,
    content: const Text('Conectado novamente'),
    backgroundColor: Colors.green,
    duration: const Duration(
      seconds: 2,
    ),
  );

  showSnackBar({required bool internet}) {
    if (internetController.value == true) {
      return;
    } else {
      scaffoldMessengerKey.currentState!
          .hideCurrentSnackBar(reason: SnackBarClosedReason.dismiss);
      internet == true
          ? scaffoldMessengerKey.currentState!.showSnackBar(snackBarOn)
          : scaffoldMessengerKey.currentState!.showSnackBar(snackBarOff);
    }
  }

  void updateConnectionStatus(result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        scaffoldMessengerKey.currentState!
            .hideCurrentSnackBar(reason: SnackBarClosedReason.dismiss);

        internetController.value == true
            ? scaffoldMessengerKey.currentState!.showSnackBar(snackBarOn)
            : null;
        _statusInternetAt(binternetController: false, iconenctionStatus: 1);
        break;
      case ConnectivityResult.mobile:
        scaffoldMessengerKey.currentState!
            .hideCurrentSnackBar(reason: SnackBarClosedReason.dismiss);

        internetController.value == true
            ? scaffoldMessengerKey.currentState!.showSnackBar(snackBarOn)
            : null;

        _statusInternetAt(binternetController: false, iconenctionStatus: 1);
        break;
      case ConnectivityResult.none:
        _statusInternetAt(binternetController: true, iconenctionStatus: 0);
        break;
      default:
        connectionStatus.value = 1;
        break;
    }
  }

  Future<void> _statusInternetAt({
    required int iconenctionStatus,
    required bool binternetController,
  }) async {
    //Queria verificar a conexao com internet mesmo conectado no wi-fi
    //Exemplo:
    /*
    Estou no wi-fi e derrepente ele fica sem internet
    queria notificar o usuario se ele esta sem internte.
    */
    internetController.value = binternetController;

    if (iconenctionStatus == 1) {
      try {
        final result = await InternetAddress.lookup('google.com');
        result.isNotEmpty && result[0].rawAddress.isNotEmpty
            ? connectionStatus.value = iconenctionStatus
            : connectionStatus.value = 0;

        connectionStatus.value == 0
            ? scaffoldMessengerKey.currentState!.showSnackBar(snackBarOff)
            : null;

        internetController.value = true;
      } catch (e) {
        connectionStatus.value = 0;
        internetController.value = false;
      }
    } else {
      scaffoldMessengerKey.currentState!.showSnackBar(snackBarOff);
      connectionStatus.value = 0;
      internetController.value = false;
    }
  }
}
