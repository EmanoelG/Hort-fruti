import 'package:flutter/material.dart';

import '../cart/cart_tab.dart';
import '../home/home_tab.dart';
import '../orders/order_tab.dart';
import '../profile/profile_tab.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int _intCurrentIntegrado = 0;
  final _pagaeController = PageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottonNavBar(),
      body: _pageView(),
    );
  }

  PageView _pageView() {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: _pagaeController,
      children: [
        const HomeTab(),
        const OrdersTab(),
        CartTab(),
        const ProfileTab(),
      ],
    );
  }

  Widget _bottonNavBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _intCurrentIntegrado,
      onTap: (indexTap) {
        setState(
          () {
            _intCurrentIntegrado = indexTap;
            _pagaeController.jumpToPage(indexTap);
          },
        );
      },
      items: const [
        BottomNavigationBarItem(
          label: 'Home',
          icon: Icon(Icons.home),
        ),
        BottomNavigationBarItem(
          label: 'Pedidos',
          icon: Icon(Icons.list),
        ),
        BottomNavigationBarItem(
          label: 'Carinho',
          icon: Icon(Icons.shopping_cart_outlined),
        ),
        BottomNavigationBarItem(
          label: 'Usuário',
          icon: Icon(Icons.person),
        ),
      ],
    );
  }
}
