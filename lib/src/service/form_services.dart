import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class UtilsService {
  final _storage = const FlutterSecureStorage();
  Future<bool> saveLocalData(Map<String, dynamic> data) async {
    try {
      await _storage.write(key: data.keys.first, value: data.values.first);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String?> loadLocalData(String keyRead) async {
    try {
      var teste = await _storage.read(key: keyRead);

      return teste;
    } catch (e) {
      return null;
    }
  }

  Uint8List decodeQrCodeImage(String value) {
    String base64String = value.split(',')[1];
    return base64Decode(base64String);
  }

  Future<bool> deleteLocalData(String keyRead) async {
    try {
      _storage.delete(key: keyRead);
      return true;
    } catch (e) {
      return false;
    }
  }

  String priceToCurrency(double price) {
    NumberFormat numberFormat = NumberFormat.simpleCurrency(locale: 'pt_BR');
    return numberFormat.format(price);
  }

  // ignore: non_constant_identifier_names
  String FormatDateTime(DateTime dateTime) {
    initializeDateFormatting();
    DateFormat dateFormat = DateFormat.yMd('pt_BR').add_Hm();
    return dateFormat.format(dateTime);
  }

  void showToats({required String message, bool isError = false}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: isError ? Colors.red : Colors.white,
      textColor: isError ? Colors.white : Colors.black,
      fontSize: 14,
    );
  }
}
