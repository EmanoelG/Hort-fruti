import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

import '../config/custom_color.dart';
import 'components/category_title.dart';

class HomeTab extends StatefulWidget {
  HomeTab({Key? key}) : super(key: key);
  List<String> categoriasApp = [
    'Frutas',
    'Legumes',
    'Verduras',
    'Bebidas',
    'Carnes',
  ];
  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: _titlehometab(),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 15, right: 15),
            child: Badge(
              badgeColor: CustomColors.colorDestac,
              badgeContent:
                  const Text('0', style: TextStyle(color: Colors.white)),
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.shopping_cart_outlined,
                  color: CustomColors.colorButtonMain,
                ),
              ),
            ),
          )
        ],
      ),
      body: _body(context),
    );
  }

  Text _titlehometab() {
    return const Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: 'Super',
            style: TextStyle(
                color: Color.fromARGB(255, 3, 3, 3),
                fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: 'Sacolão',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  _body(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: TextFormField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              isDense: true,
              hintText: 'Pesquisar por produto',
              hintStyle: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 14,
              ),
              prefix: const Icon(
                Icons.search,
                color: Colors.black26,
                size: 21,
              ),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(60),
                ),
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 40,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                return CategoryTitle(
                  category: widget.categoriasApp[index],
                  isSelect: false,
                );
              },
              separatorBuilder: (_, index) => const SizedBox(
                    width: 10,
                  ),
              itemCount: widget.categoriasApp.length),
        ),
      ],
    );
  }
}
