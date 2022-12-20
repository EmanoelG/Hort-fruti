import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_result.freezed.dart';

@freezed
class HomeResult<T> with _$HomeResult<T> {
  factory HomeResult.sucess(List<T> data) = Sucess;
  factory HomeResult.error(String data) = Error;
}
