import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sacolao_de_frutas/src/models/user_model.dart';

part 'auth_result.freezed.dart';

@freezed
class AuthResult with _$AuthResult {
  factory AuthResult.sucess(UserModel user) = Sucess;
  factory AuthResult.error(String message) = Error;
}
