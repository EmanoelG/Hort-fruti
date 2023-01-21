import 'package:get/get.dart';
import 'package:sacolao_de_frutas/src/models/categoria_model.dart';
import 'package:sacolao_de_frutas/src/models/item_model.dart';
import 'package:sacolao_de_frutas/src/pages/home/result/home_result.dart';
import 'package:sacolao_de_frutas/src/service/form_services.dart';

import '../repository/home_repository.dart';

const int itemsPerPage = 6;

class HomeController extends GetxController {
  final homeRespository = HomeRespository();
  final UtilsService _utils = UtilsService();
  bool isCategoryLoading = false;
  bool isProductLoading = true;
  List<CategoryModel> allCategories = [];
  List<ItemModel> get allProducts => currentCategory?.items ?? [];

  CategoryModel? currentCategory;
  bool get isLastPage {
    if (currentCategory!.items.length < itemsPerPage) return true;
    return currentCategory!.pagination * itemsPerPage > allProducts.length;
  }

  void setLoading(bool value, {bool isProduct = false}) {
    if (!isProduct) {
      isCategoryLoading = value;
    } else {
      isProductLoading = value;
    }

    update();
  }

  selectCategory(CategoryModel categpry) {
    currentCategory = categpry;
    update();
    getAllProducts();
  }

  Future<void> getAllCategories() async {
    //  setLoading(true);

    HomeResult<CategoryModel> homeResult =
        await homeRespository.getAllCategories();
    //  setLoading(false);
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

  Future<void> seilaUe() async {
    currentCategory!.pagination++;
    getAllProducts(canLoading: false);
  }

  Future<void> getAllProducts({bool canLoading = true}) async {
    if (canLoading == true) {
      setLoading(true, isProduct: true);
    }

    Map<String, dynamic> body = {
      'page': currentCategory!.pagination,
      // "title": null,
      //'categoryId': currentCategory!.id,
      "itemsPerPage": itemsPerPage
    };
    HomeResult<ItemModel> homeResult =
        await homeRespository.getAllProducts(body);
    setLoading(false, isProduct: true);

    homeResult.when(
      sucess: (data) async {
        print('Buscou !');
        currentCategory!.items.addAll(data);
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

    getAllCategories();
  }
}
