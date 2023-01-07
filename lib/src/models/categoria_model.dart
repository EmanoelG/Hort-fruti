import 'package:json_annotation/json_annotation.dart';

import 'package:sacolao_de_frutas/src/models/item_model.dart';

part 'categoria_model.g.dart';

@JsonSerializable()
class CategoryModel {
  final String title;
  final String id;

  @JsonKey(defaultValue: [])
  List<ItemModel> items;
  
  @JsonKey(defaultValue: 0)
  int pagination;
  
  CategoryModel({
    required this.title,
    required this.id,
    required this.items,
    required this.pagination,
  });
  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);

  @override
  String toString() => 'CategoryModel(title: $title, id: $id)';
}
