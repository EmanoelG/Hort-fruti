import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';

abstract class HttpMetod {
  static const String post = 'post';
  static const String get = 'get';
  static const String put = 'put';
  static const String delete = 'delete';
  static const String patch = 'patch';
}

class HttpManager {
  Future<Map> restRequest({
    required String url,
    required String metod,
    Map? headers,
    Map? body,
  }) async {
    final defaultHeaders = headers?.cast<String, dynamic>() ?? {}
      ..addAll(
        {
          'content-type': 'application/json',
          'accept': 'application/json',
          'X-Parse-Application-Id': 'wK7GcEjr2V4br5q5mlR1kybQ5dvxMFDX0qtE1d6Y',
          'X-Parse-REST-API-Key': '2kahi62fkWePLWAwC7k8aMrtQkobogcgkruMxbeB'
        },
      );

    Dio dio = Dio();
    try {
      dio.options.connectTimeout = 15000;
      dio.options.receiveTimeout = 15000;
      Response response = await dio.request(
        url,
        options: Options(
          method: metod,
          headers: defaultHeaders,
        ),
        data: body,
      );
      return response.data;
    } on SocketException {
      return {'error': 'sem conexão com internet'};
    } on DioError catch (error) {
      if (error.error is SocketException) {
        // Lida com a exceção SocketException aqui
        return {'error': 'sem conexao de internet'};
      } else {
        // Lida com outras exceções aqui
        if (error.error is TimeoutException) {
          return {'error': 'sem conexao de internet'};
        } else if (error.type == DioErrorType.connectTimeout ||
            error.type == DioErrorType.receiveTimeout) {
          // lidar com o erro de timeout
          return {'error': 'sem conexao de internet'};
        } else {
          return error.response?.data ?? {};
        }
      }
    } catch (error) {
      return {'error': error.toString()};
    }
  }
}

abstract class KeysApp {
  static String userKey = 'user_key';
  static String userToken = 'userToken';
}
