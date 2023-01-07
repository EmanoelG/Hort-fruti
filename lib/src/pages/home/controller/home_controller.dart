import 'package:get/get.dart';
import 'package:sacolao_de_frutas/src/models/categoria_model.dart';
import 'package:sacolao_de_frutas/src/models/item_model.dart';
import 'package:sacolao_de_frutas/src/pages/home/result/home_result.dart';
import 'package:sacolao_de_frutas/src/service/form_services.dart';

import '../repository/home_repository.dart';

class HomeController extends GetxController {
  final homeRespository = HomeRespository();
  final UtilsService _utils = UtilsService();
  bool isLoading = false;
  List<CategoryModel> allCategories = [];
  List<ItemModel> allProducts = [];
  CategoryModel? currentCategory;
  void setLoading(bool value) {
    isLoading = value;
    update();
  }

  selectCategory(CategoryModel categpry) {
    currentCategory = categpry;
    update();
    getAllProducts();
  }

  Future<void> getAllCategories() async {
    setLoading(true);
    HomeResult<CategoryModel> homeResult =
        await homeRespository.getAllCategories();
    setLoading(false);
    homeResult.when(
      sucess: (data) async {
        allCategories.assignAll(data);
        if (allCategories.isEmpty) return;
        selectCategory(data.first);
      },
      error: (er) {
        _utils.showToats(message: er);
      },
    );
  }

  Future<void> getAllProducts() async {
    setLoading(true);
    Map<String, dynamic> body = {
      "page": 0,
      "title": null,
      "categoryId": "5mjkt5ERRo",
      "itemsPerPage": 6
    };
    HomeResult<ItemModel> homeResult =
        await homeRespository.getAllProducts(body);
    setLoading(false);

    homeResult.when(
      sucess: (data) async {
        allProducts.assignAll(data);
      },
      error: (er) {
        print('Deu error $er');
        _utils.showToats(message: er);
      },
    );
  }

  @override
  void onInit() {
    super.onInit();
    print('Iniciouu !');
    getAllCategories();
    //getAllProducts();
  }
}
