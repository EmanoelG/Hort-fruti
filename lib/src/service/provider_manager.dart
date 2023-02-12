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
      Response response = await dio.request(
        url,
        options: Options(
          method: metod,
          headers: defaultHeaders,
        ),
        data: body,
      );
      return response.data;
    } on DioError catch (error) {
      return error.response?.data ?? {};
    } catch (e) {
      return {};
    }
  }
}

abstract class KeysApp {
  static String userKey = 'user_key';
  static String userToken = 'userToken';
}
