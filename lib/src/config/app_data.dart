import 'package:sacolao_de_frutas/src/models/order_model.dart';
import 'package:sacolao_de_frutas/src/models/user_model.dart';

import '../models/cart_item_model.dart';
import '../models/item_model.dart';

ItemModel apple = ItemModel(
    ItemName: 'Maçã',
    description: 'Maçã loremipson lopremipson',
    price: 2.99,
    unit: 'Kg',
    img: 'https://www.infoescola.com/wp-content/uploads/2010/01/maca.jpg');

ItemModel melancia = ItemModel(
    ItemName: 'melancia',
    description: 'melancia loremipson lopremipson',
    price: 0.99,
    unit: 'Kg',
    img:
        'https://www.dicasdemulher.com.br/wp-content/uploads/2020/10/beneficios-da-melancia-0.jpg');

ItemModel laranja = ItemModel(
    ItemName: 'laranja',
    description: 'laranja loremipson lopremipson',
    price: 0.99,
    unit: 'Kg',
    img:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRDopbVPY3psPp-ryeyksM-kpTqECjtER2SQGFM-_g0PsX1LijxDGtMoSh4c1sMBoKWJFo&usqp=CAU");

ItemModel abacate = ItemModel(
    ItemName: 'abacate',
    description: 'abacate loremipson lopremipson',
    price: 0.99,
    unit: 'Kg',
    img:
        'https://img.itdg.com.br/tdg/images/blog/uploads/2019/09/beneficios-do-abacate.jpg');

ItemModel morango = ItemModel(
    ItemName: 'morango',
    description: 'morango loremipson lopremipson',
    price: 0.99,
    unit: 'Un',
    img:
        'https://planetacampo.com.br/wp-content/uploads/2022/06/Morangos-1024x683.jpg');

ItemModel maracuja = ItemModel(
    ItemName: 'maracuja',
    description: 'maracuja loremipson lopremipson',
    price: 0.99,
    unit: 'Kg',
    img:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQiAGv5FdjhFaLm-nqtxfN2JZLK9yU2wKPJVw&usqp=CAU');

List<ItemModel> items = [apple, melancia, laranja, abacate, morango, maracuja];

List<CartItemModel> cartItems = [
  CartItemModel(item: apple, quantity: 3),
  CartItemModel(item: morango, quantity: 2),
  CartItemModel(item: maracuja, quantity: 1),
];

UserModel user = UserModel(
    name: 'Emanoel Galvâo',
    email: 'emanolegalvao42@gmail.com',
    celular: '46 999094900',
    cpf: '12391183925',
    senha: 'semsneh123');

List<OrderModel> orders = [
  // OrderModel(
  //   id: '12',
  //   createDateTime: DateTime.parse('2021-11-08 10:00:00'),
  //   overDueDateTime: DateTime.parse('2023-06-09 10:00:00'),
  //   items: [
  //     CartItemModel(item: abacate, quantity: 2),
  //     CartItemModel(item: laranja, quantity: 2),
  //     CartItemModel(item: maracuja, quantity: 2),
  //     CartItemModel(item: laranja, quantity: 2),
  //     CartItemModel(item: morango, quantity: 2),
  //     CartItemModel(item: abacate, quantity: 2),
  //     CartItemModel(item: laranja, quantity: 2),
  //     CartItemModel(item: maracuja, quantity: 2),
  //     CartItemModel(item: abacate, quantity: 2),
  //     CartItemModel(item: laranja, quantity: 2),
  //     CartItemModel(item: maracuja, quantity: 2),
  //     CartItemModel(item: laranja, quantity: 2),
  //     CartItemModel(item: morango, quantity: 2),
  //     CartItemModel(item: abacate, quantity: 2),
  //     CartItemModel(item: laranja, quantity: 2),
  //     CartItemModel(item: maracuja, quantity: 2),
  //   ],
  //   status: 'pending_payment',
  //   copyAndPast: 'qwe12eas124s',
  //   total: 12,
  //   qrCodeImage: '',
  // ),
  // OrderModel(
  //   id: '12',
  //   createDateTime: DateTime.parse('2021-11-08 10:00:00'),
  //   overDueDateTime: DateTime.parse('2023-06-09 10:00:00'),
  //   items: [CartItemModel(item: abacate, quantity: 2)],
  //   status: 'delivered',
  //   copyAndPast: 'asf135',
  //   total: 150,
  //   qrCodeImage: '',
  // ),
];
