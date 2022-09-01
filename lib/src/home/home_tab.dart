import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

import '../config/custom_color.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

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
              badgeContent: const Text('0'),
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

  _body(BuildContext context) {}
}
