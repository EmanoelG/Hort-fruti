import 'package:get/get.dart';
import 'package:sacolao_de_frutas/src/models/categoria_model.dart';
import 'package:sacolao_de_frutas/src/models/item_model.dart';
import 'package:sacolao_de_frutas/src/pages/home/result/home_result.dart';

import '../../../service/connectivitywidget.dart';
import '../../../service/error_type.dart';
import '../../auth/controller/auth_controller.dart';
import '../repository/home_repository.dart';

const int itemsPerPage = 6;

class HomeController extends GetxController {
  final homeRespository = HomeRespository();
  bool isCategoryLoading = false;
  bool isProductLoading = true;
  List<CategoryModel> allCategories = [];
  List<ItemModel> get allProducts => currentCategory?.items ?? [];
  final ConnectionService _connectionController = Get.find();
  var pageNow = 0;
  RxString searchTitle = ''.obs;

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

  previousPage({bool ladoDireito = true}) {
    if (isCategoryLoading == true || isProductLoading == true) return;
    if (ladoDireito == true) {
      if (pageNow < allCategories.length - 1) {
        pageNow = pageNow + 1;
      } else if (pageNow >= allCategories.length - 1) {
        pageNow = 0;
      }
    } else {
      if (pageNow <= allCategories.length - 1) {
        if (pageNow != 0) {
          pageNow = pageNow - 1;
        } else {
          pageNow = allCategories.length - 1;
        }
      } else if (pageNow >= allCategories.length - 1) {
        pageNow = 0;
      }
    }

    selectCategory(allCategories[pageNow]);
  }

  selectCategory(CategoryModel category) {
    currentCategory = category;
    update();
    if (currentCategory!.items.isNotEmpty) return;

    getAllProducts();
  }

  Future<void> getAllCategories() async {
    // setLoading(true, isProduct: true);

    HomeResult<CategoryModel> homeResult =
        await homeRespository.getAllCategories();
    //setLoading(false, isProduct: true);
    homeResult.when(
      sucess: (data) async {
        allCategories.assignAll(data);
        if (allCategories.isEmpty) return;
        selectCategory(data.first);
        _connectionController.connectionStatus.value = 1;
        _connectionController.showSnackBar(internet: true);
        _connectionController.internetController.value = true;
      },
      error: (error) {
        AuthController auth = AuthController();
        if (error == ErrorAppType.invalidCredentials) {
          auth.signOut();
        } else if (error == ErrorAppType.invalidToken) {
          auth.signOut();
        } else if (error == ErrorAppType.invalidTokenSession) {
          auth.signOut();
        } else if (error == ErrorAppType.notAcessInternet) {
          _connectionController.connectionStatus.value = 0;
        }
      },
    );
  }

  Future<void> seilaUe() async {
    currentCategory!.pagination++;
    getAllProducts(canLoading: false);
  }

  void filterByTitle() {
    for (var category in allCategories) {
      category.items.clear();
      category.pagination = 0;
    }

    if (searchTitle.isEmpty) {
      allCategories.removeAt(0);
    } else {
      CategoryModel? c = allCategories.firstWhereOrNull((cat) => cat.id == '');

      if (c == null) {
        final allProductsCategorys =
            CategoryModel(title: 'Todos', id: '', items: [], pagination: 0);

        allCategories.insert(0, allProductsCategorys);
      } else {
        c.items.clear();
        c.pagination = 0;
      }
    }

    currentCategory = allCategories.first;

    update();
    getAllProducts();
  }

  Future<void> getAllProducts({bool canLoading = true}) async {
    if (canLoading == true) {
      setLoading(true, isProduct: true);
    }

    Map<String, dynamic> body = {
      'page': currentCategory!.pagination,
      'categoryId': currentCategory!.id,
      'itemsPerPage': itemsPerPage
    };

    if (searchTitle.value.isNotEmpty) {
      body['title'] = searchTitle.value;
      if (currentCategory!.id == '') {
        body.remove('categoryId');
      }
    }

    HomeResult<ItemModel> homeResult =
        await homeRespository.getAllProducts(body);

    setLoading(false, isProduct: true);

    homeResult.when(
      sucess: (data) async {
        currentCategory!.items.addAll(data);
        _connectionController.connectionStatus.value = 1;
        _connectionController.showSnackBar(internet: true);
        _connectionController.internetController.value = true;
      },
      error: (error) {
        AuthController auth = AuthController();
        if (error == ErrorAppType.invalidCredentials) {
          auth.signOut();
        } else if (error == ErrorAppType.invalidToken) {
          auth.signOut();
        } else if (error == ErrorAppType.invalidTokenSession) {
          auth.signOut();
        } else if (error == ErrorAppType.notAcessInternet) {
          _connectionController.connectionStatus.value = 0;
          _connectionController.internetController.value = false;
          _connectionController.showSnackBar(internet: false);
        }
      },
    );
  }

  @override
  void onInit() {
    super.onInit();

    debounce(searchTitle, (_) => filterByTitle(),
        time: const Duration(seconds: 1));
    getAllCategories();
  }
}
