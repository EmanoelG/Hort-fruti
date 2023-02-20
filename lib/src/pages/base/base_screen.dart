import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sacolao_de_frutas/src/pages/base/controller/navigation_controller.dart';

import '../cart/view/cart_tab.dart';
import '../home/view/home_tab.dart';
import '../orders/order_tab.dart';
import '../profile/profile_tab.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final navigationController = Get.find<NavigationController>();

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
      controller: navigationController.pageController,
      children: const [
        HomeTab(),
        OrdersTab(),
        CartTab(),
        ProfileTab(),
      ],
    );
  }

  Widget _bottonNavBar() {
    return Obx(() => BottomNavigationBar(
          selectedLabelStyle: const TextStyle(color: Colors.white),
          selectedItemColor: Colors.white,
          backgroundColor: Colors.green,
          type: BottomNavigationBarType.fixed,
          currentIndex: navigationController.currentIndex,
          onTap: (indexTap) {
            navigationController.navigationPageView(indexTap);
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
        ));
  }
}
