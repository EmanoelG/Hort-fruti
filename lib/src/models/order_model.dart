import 'card_item_model.dart';

class OrderModel {
  String id;
  DateTime createDateTime;
  DateTime overDueDateTime;
  List<CartItemModel> items;
  String status;
  String copyAndPast;
  double total;
  OrderModel({
    required this.id,
    required this.createDateTime,
    required this.overDueDateTime,
    required this.items,
    required this.status,
    required this.copyAndPast,
    required this.total,
  });
}
