import 'dart:async';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sacolao_de_frutas/src/pages/common_widgets/custom_shimmer.dart';
import 'package:sacolao_de_frutas/src/pages/common_widgets/title_app.dart';
import 'package:sacolao_de_frutas/src/pages/home/controller/home_controller.dart';
import 'package:sacolao_de_frutas/src/util/font_app.dart';
import '../../../config/custom_color.dart';
import '../../../service/form_services.dart';
import '../../cart/controller/cart_controller.dart';
import 'components/category_title.dart';
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
  final GlobalKey<_HomeTabState> mainAppKey = GlobalKey<_HomeTabState>();

  final controllerGlob = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 15, right: 15),
            child: GetBuilder<CartController>(
              builder: (controller) {
                return GestureDetector(
                  onTap: () {},
                  child: Badge(
                    badgeColor: CustomColors.colorDestac,
                    badgeContent: Text(
                      controller.cartItems.length.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                    child: Icon(
                      Icons.shopping_cart_outlined,
                      color: CustomColors.colorButtonMain,
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TitleApp(fontTitle: 35),
          _searchproduto(),
          _categoria(),
          _griditens(context)
        ],
      ),
    );
  }

  _griditens(context) {
    return GetBuilder<HomeController>(
      autoRemove: true,
      builder: (controllerItens) {
        return !controllerItens.isProductLoading
            ? Expanded(
                child: Visibility(
                  visible:
                      (controllerItens.currentCategory?.items ?? []).isNotEmpty,
                  child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 9 / 11.5,
                      maxCrossAxisExtent: 200,
                    ),
                    findChildIndexCallback: (key) {
                      controllerItens.seilaUe();
                      return null;
                    },
                    scrollDirection: Axis.vertical,
                    itemCount: controllerItens.allProducts.length,
                    itemBuilder: (context, index) {
                      if (((index + 1) == controllerItens.allProducts.length) &&
                          !controllerItens.isLastPage) {
                        controllerItens.seilaUe();
                      }
                      return ItemTitle(
                        item: controllerItens.allProducts[index],
                      );
                    },
                  ),
                  replacement: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search_off,
                        size: 40,
                        color: CustomColors.colorDestac,
                      ),
                      TextApp(
                        texto: 'Não há items para apresentar',
                      ),
                    ],
                  ),
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
          return SizedBox(
            height: 25,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                return CategoryTitle(
                  category: controller.allCategories[index].title,
                  isSelect: controller.allCategories[index] ==
                      controller.currentCategory,
                  onPresseds: () async {
                    if (controller.allCategories[index] !=
                        controller.currentCategory) {}
                    Future.delayed(const Duration(milliseconds: 500)).then(
                        (value) => controller
                            .selectCategory(controller.allCategories[index]));
                  },
                );
              },
              separatorBuilder: (_, index) => const SizedBox(
                width: 10,
              ),
              itemCount: controller.allCategories.length,
            ),
          );
        },
      ),
    );
  }

  _searchproduto() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: GetBuilder<HomeController>(
        builder: (controller) {
          return TextFormField(
            controller: searchController,
            onChanged: ((value) {
              controllerGlob.searchTitle.value = value;
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
