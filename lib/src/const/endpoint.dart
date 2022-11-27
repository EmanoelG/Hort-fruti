const String _urlBase = 'https://parseapi.back4app.com/functions';

abstract class EndPoints {
  static const String signin = '$_urlBase/login';
  static const String signUpW = '$_urlBase/signup';
  static const String validateToken = '$_urlBase/validate-token';
}
