import 'package:flutter/material.dart';

class BaseScreen extends StatelessWidget {
  BaseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottonNavBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[],
      ),
    );
  }

  Widget _bottonNavBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          label: 'Home',
          icon: Icon(Icons.home),
        ),
        BottomNavigationBarItem(
          label: 'Carinho',
          icon: Icon(Icons.shopping_cart_outlined),
        ),
        BottomNavigationBarItem(
          label: 'Produtos',
          icon: Icon(Icons.list),
        ),
        BottomNavigationBarItem(
          label: 'Usuário',
          icon: Icon(Icons.person),
        ),
      ],
    );
  }
}
