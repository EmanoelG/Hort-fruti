import 'package:flutter/material.dart';

import '../cart/cart_tab.dart';
import '../home/view/home_tab.dart';
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
      selectedLabelStyle: TextStyle(color: Colors.white),
      selectedItemColor: Colors.white,
      backgroundColor: Colors.green,
      type: BottomNavigationBarType.fixed,
      currentIndex: _intCurrentIntegrado,
      onTap: (indexTap) {
        setState(
          () {
            _intCurrentIntegrado = indexTap;
            _pagaeController.animateToPage(indexTap, //easeInCubic
                duration: Duration(seconds: 1),
                curve: Curves.easeInOut);
          },
        );
      },
      items: const [
        BottomNavigationBarItem(
          label: 'Home',
          backgroundColor: Colors.white,
          icon: Icon(Icons.home, color: Colors.white),
        ),
        BottomNavigationBarItem(
          label: 'Pedidos',
          icon: Icon(Icons.list, color: Colors.white),
        ),
        BottomNavigationBarItem(
          label: 'Carinho',
          icon: Icon(Icons.shopping_cart_outlined, color: Colors.white),
        ),
        BottomNavigationBarItem(
          label: 'Usuário',
          icon: Icon(Icons.person, color: Colors.white),
        ),
      ],
    );
  }
}
