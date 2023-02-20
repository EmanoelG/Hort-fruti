import 'package:freezed_annotation/freezed_annotation.dart';

import 'cart_item_model.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderModel {
  String id;

  @JsonKey(name: 'createdAt')
  DateTime? createDateTime;

  @JsonKey(name: 'due')
  DateTime overDueDateTime;
  @JsonKey(defaultValue: [])
  List<CartItemModel> items;
  String status;
  String qrCodeImage;
  @JsonKey(name: 'copiaecola')
  String copyAndPast;
  double total;

  bool get isOverDue => overDueDateTime.isBefore(DateTime.now());
  OrderModel({
    required this.id,
    required this.createDateTime,
    required this.overDueDateTime,
    required this.items,
    required this.status,
    required this.qrCodeImage,
    required this.copyAndPast,
    required this.total,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}
