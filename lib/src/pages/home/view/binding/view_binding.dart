import 'package:get/get.dart';
import '../controller/view_controller.dart';

class ViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ViewController());
  }
}
