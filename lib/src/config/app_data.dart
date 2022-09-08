import '../models/item_model.dart';

ItemModel apple = ItemModel(
    ItemName: 'Maçã',
    description: 'Maçã loremipson lopremipson',
    precie: '2,99',
    unit: 'Kg',
    img: 'https://www.infoescola.com/wp-content/uploads/2010/01/maca.jpg');

ItemModel melancia = ItemModel(
    ItemName: 'melancia',
    description: 'melancia loremipson lopremipson',
    precie: '0,99',
    unit: 'Kg',
    img:
        'https://www.dicasdemulher.com.br/wp-content/uploads/2020/10/beneficios-da-melancia-0.jpg');

ItemModel laranja = ItemModel(
    ItemName: 'laranja',
    description: 'laranja loremipson lopremipson',
    precie: '1,99',
    unit: 'Kg',
    img:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRDopbVPY3psPp-ryeyksM-kpTqECjtER2SQGFM-_g0PsX1LijxDGtMoSh4c1sMBoKWJFo&usqp=CAU");

ItemModel abacate = ItemModel(
    ItemName: 'abacate',
    description: 'abacate loremipson lopremipson',
    precie: '4,99',
    unit: 'Kg',
    img:
        'https://img.itdg.com.br/tdg/images/blog/uploads/2019/09/beneficios-do-abacate.jpg');

ItemModel morango = ItemModel(
    ItemName: 'morango',
    description: 'morango loremipson lopremipson',
    precie: '4,99',
    unit: 'Un',
    img:
        'https://planetacampo.com.br/wp-content/uploads/2022/06/Morangos-1024x683.jpg');

ItemModel maracuja = ItemModel(
    ItemName: 'maracuja',
    description: 'maracuja loremipson lopremipson',
    precie: '3,99',
    unit: 'Kg',
    img:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQiAGv5FdjhFaLm-nqtxfN2JZLK9yU2wKPJVw&usqp=CAU');

List<ItemModel> items = [apple, melancia, laranja, abacate, morango, maracuja];

List<String> categorias = [
  'Frutas',
  'Graâos',
  'Verduras',
  'Temperos',
  'Carnes',
  'Peixe'
];
