import 'package:json_annotation/json_annotation.dart';

part 'categoria_model.g.dart';

@JsonSerializable()
class CategoryModel {
  final String title;
  final dynamic id;
  CategoryModel({
    required this.title,
    required this.id,
  });
}
