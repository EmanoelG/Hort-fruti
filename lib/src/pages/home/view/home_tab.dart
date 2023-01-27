import 'dart:ffi';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sacolao_de_frutas/src/pages/common_widgets/custom_shimmer.dart';
import 'package:sacolao_de_frutas/src/pages/home/controller/home_controller.dart';
import 'package:shimmer/shimmer.dart';
import '../../../config/custom_color.dart';
import '../../../service/form_services.dart';
import '../../common_widgets/title_app.dart';
import 'components/category_title.dart';
import '../../../config/app_data.dart' as app_data;
import 'components/item_title.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final UtilsService service = UtilsService();
  final searchController = TextEditingController();
  late Function(GlobalKey) runAddToCardAnimation;
  void itemSelectedCartAnimation(GlobalKey gkImage) {
    runAddToCardAnimation(gkImage);
  }

  final controllerGlob = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        //title: TitleApp(),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 15, right: 15),
            child: GestureDetector(
              onTap: () {},
              child: Badge(
                badgeColor: CustomColors.colorDestac,
                badgeContent:
                    const Text('0', style: TextStyle(color: Colors.white)),
                child: Icon(
                  Icons.shopping_cart_outlined,
                  color: CustomColors.colorButtonMain,
                ),
              ),
            ),
          )
        ],
      ),
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [_searchproduto(), _categoria(), _griditens(context)],
        ),
      ),
    );
  }

  _griditens(context) {
    return GetBuilder<HomeController>(
      builder: (controllerFuncionaPvrf) {
        return !controllerFuncionaPvrf.isProductLoading
            ? Expanded(
                child: ListView.builder(
                  findChildIndexCallback: (key) {
                    controllerFuncionaPvrf.seilaUe();
                  },
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  itemCount: controllerFuncionaPvrf.allProducts.length,
                  itemBuilder: (_, index) {
                    if (((index + 1) ==
                            controllerFuncionaPvrf.allProducts.length) &&
                        !controllerFuncionaPvrf.isLastPage) {
                      controllerFuncionaPvrf.seilaUe();
                    }
                    return ItemTitle(
                        Item: controllerFuncionaPvrf.allProducts[index],
                        runAddToCardAnimationMethod: itemSelectedCartAnimation);
                  },
                ),
              )
            : Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: GridView.count(
                    physics: const BouncingScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 9 / 11.5,
                    children: List.generate(
                      10,
                      (index) => CustomShimmer(
                        height: double.infinity,
                        width: double.infinity,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              );
      },
    );
  }

  _categoria() {
    return Material(
      color: Colors.transparent,
      child: GetBuilder<HomeController>(
        builder: (controller) {
          return Container(
            height: 25,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) {
                  return CategoryTitle(
                    category: controller.allCategories[index].title,
                    isSelect: controller.allCategories[index] ==
                        controller.currentCategory,
                    onPresseds: () {
                      controller
                          .selectCategory(controller.allCategories[index]);
                    },
                  );
                },
                separatorBuilder: (_, index) => const SizedBox(
                      width: 10,
                    ),
                itemCount: controller.allCategories.length),
          );
        },
      ),
    );
  }

  _searchproduto() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: GetBuilder<HomeController>(
        builder: (controller) {
          return TextFormField(
            controller: searchController,
            onChanged: ((value) {
              controllerGlob.searchTitle.value = value;
              // print(value);
            }),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              isDense: true,
              hintText: 'Pesquisar por produto',
              hintStyle: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 12,
              ),
              suffixIcon: controller.searchTitle.value.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        searchController.clear();
                        controller.searchTitle.value = searchController.text;
                        FocusScope.of(context).unfocus();
                      },
                      icon: const Icon(
                        Icons.close,
                        size: 21,
                      ))
                  : null,
              prefix: const Icon(
                Icons.search,
                color: Colors.black26,
                size: 21,
              ),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(60),
                ),
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
