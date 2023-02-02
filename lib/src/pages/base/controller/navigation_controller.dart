import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class NavigationTabs {
  static const int home = 0;
  static const int cart = 2;
  static const int orders = 1;
  static const int profile = 3;
}

class NavigationController extends GetxController {
  late PageController _pageController;
  late RxInt _currentIndex;

  PageController get pageController => _pageController;
  int get CurrentIndex => _currentIndex.value;

  @override
  void onInit() {
    super.onInit();
    _initNavigation(
        pageController: PageController(initialPage: NavigationTabs.home),
        currentIndex: NavigationTabs.home);
  }

  void _initNavigation({
    required PageController pageController,
    required int currentIndex,
  }) {
    _pageController = pageController;
    _currentIndex = currentIndex.obs;
  }

  void navigationPageView(int page) {
    if (_currentIndex.value == page) return;
    // _pageController.jumpToPage(page);
    _pageController.animateToPage(page,
        duration: Duration(seconds: 1), curve: Curves.easeInOut);
    _currentIndex.value = page;
  }
}
