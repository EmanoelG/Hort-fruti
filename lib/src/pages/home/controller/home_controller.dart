import 'package:get/get.dart';
import 'package:sacolao_de_frutas/src/models/category_model.dart';
import 'package:sacolao_de_frutas/src/pages/home/result/home_result.dart';
import 'package:sacolao_de_frutas/src/service/form_services.dart';

import '../repository/home_repository.dart';

class HomeController extends GetxController {
  final homeRespository = HomeRespository();
  final UtilsService _utils = UtilsService();
  bool isLoading = false;
  List<CategoryModel> allCategories = [];
  void setLoading(bool value) {
    isLoading = value;
    update();
  }

  Future<void> getAllCategories() async {
    setLoading(true);
    HomeResult<CategoryModel> homeResult =
        await homeRespository.getAllCategories();
    setLoading(false);

    homeResult.when(
      sucess: (data) {
        allCategories.assignAll(data);
        print('Todas as Categorias: ' + allCategories.toString());
      },
      error: (er) {
        _utils.showToats(message: er);
      },
    );
  }

  @override
  void onInit() {
    super.onInit();
    print('Iniciouu !');
    getAllCategories();
  }
}
