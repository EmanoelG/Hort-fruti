import 'package:json_annotation/json_annotation.dart';

part 'categoria_model.g.dart';

@JsonSerializable()
class CategoryModel {
  final String title;
  final String id;
  CategoryModel({
    required this.title,
    required this.id,
  });
  factory CategoryModel.fromJson( Map<String,dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);

  

  @override
  String toString() => 'CategoryModel(title: $title, id: $id)';
}
