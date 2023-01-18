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
  late Function(GlobalKey) runAddToCardAnimation;
  void itemSelectedCartAnimation(GlobalKey gkImage) {
    runAddToCardAnimation(gkImage);
  }

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

  // _body(BuildContext context) {
  //   return GetBuilder<HomeController>(
  //     builder: (controller) {
  //       return controller.isCategoryLoading
  //           ? Shimmer.fromColors(
  //               highlightColor: Color.fromARGB(255, 215, 240, 188),
  //               baseColor: Color.fromARGB(255, 90, 207, 94),
  //               child: Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: Column(
  //                   children: [
  //                     _searchproduto(),
  //                     _categoria(),
  //                     _griditens(context)
  //                   ],
  //                 ),
  //               ),
  //             )
  //           : Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: Column(
  //                 children: [
  //                   _searchproduto(),
  //                   _categoria(),
  //                   _griditens(context)
  //                 ],
  //               ),
  //             );
  //     },
  //   );
  // }
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
      builder: (controller) {
        return controller.isProductLoading
            ? Expanded(
                child: Shimmer.fromColors(
                    highlightColor: Color.fromARGB(255, 215, 240, 188),
                    baseColor: Color.fromARGB(255, 90, 207, 94),
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
                    )),
              )
            : Expanded(
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 9 / 11.5,
                  ),
                  itemCount: controller.allProducts.length,
                  itemBuilder: (_, index) {
                    if ((index) == controller.allProducts.length - 1) {
                      try {
                        if (!controller.isLastPage) {
                          controller.loadMoreProducts;
                        } else {
                          print('Ultimo 2');
                          // controller.loadMoreProducts;
                        }
                      } catch (e) {
                        print('ERRor 2');
                      }
                    }
                    return ItemTitle(
                        Item: controller.allProducts[index],
                        runAddToCardAnimationMethod: itemSelectedCartAnimation);
                  },
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
      child: TextFormField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          isDense: true,
          hintText: 'Pesquisar por produto',
          hintStyle: TextStyle(
            color: Colors.grey.shade400,
            fontSize: 12,
          ),
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
      ),
    );
  }
}
