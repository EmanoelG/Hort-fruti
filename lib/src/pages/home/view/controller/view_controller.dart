import 'package:get/get.dart';

class ViewController extends GetxController {
  RxBool isAddToCart = false.obs;

  @override
  void onInit() {
    isAddToCart.value = false;
    super.onInit();
  }

  setIsAddToCart({required bool values}) {
    isAddToCart.value = values;
    update();
  }
}
