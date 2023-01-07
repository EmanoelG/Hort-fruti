import 'package:json_annotation/json_annotation.dart';

part 'item_model.g.dart';

@JsonSerializable()
class ItemModel {
  late String id;
  // @JsonKey(name: "title")
  // Se o title fosse itemName mas no json fosse title, daria para utilizar o
  @JsonKey(name: "title")
  late String ItemName;
  @JsonKey(name: "picture")
  late String img;
  late String unit;
  late double price;
  late String description;

  ItemModel({
    this.id = '',
    required this.ItemName,
    required this.img,
    required this.unit,
    required this.price,
    required this.description,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) =>
      _$ItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemModelToJson(this);

  @override
  String toString() {
    return 'ItemModel(id: $id, ItemName: $ItemName, img: $img, unit: $unit, precie: $price, description: $description)';
  }
}
