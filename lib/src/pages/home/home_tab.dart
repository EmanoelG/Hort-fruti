import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:add_to_cart_animation/add_to_cart_icon.dart';
import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../config/custom_color.dart';
import 'components/category_title.dart';
import '../../config/app_data.dart' as app_data;
import 'components/item_title.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  String selectCategory = 'Frutas';
  GlobalKey<CartIconKey> gkCart = GlobalKey<CartIconKey>();
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
        title: _titlehometab(),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 15, right: 15),
            child: GestureDetector(
              onTap: () {
                
              },
              child: Badge(
                badgeColor: CustomColors.colorDestac,
                badgeContent:
                    const Text('0', style: TextStyle(color: Colors.white)),
                child: AddToCartIcon(
                  key: gkCart,
                  icon: Icon(
                    Icons.shopping_cart_outlined,
                    color: CustomColors.colorButtonMain,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: _body(context),
    );
  }

  Text _titlehometab() {
    return const Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: 'Super',
            style: TextStyle(
                color: Color.fromARGB(255, 3, 3, 3),
                fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: 'Sacolão',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  _body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [_searchproduto(), _categoria(), _griditens()],
      ),
    );
  }

  Expanded _griditens() {
    return Expanded(
      child: GridView.builder(
        //padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          mainAxisExtent: 200,
        ),
        itemCount: app_data.categorias.length,
        itemBuilder: (context, index) {
          return ItemTitle(
            Item: app_data.items[index],
            runAddToCardAnimationMethod: itemSelectedCartAnimation,
          );
        },
      ),
    );
  }

  Container _categoria() {
    return Container(
      height: 40,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            return CategoryTitle(
              category: app_data.categorias[index],
              isSelect: app_data.categorias[index] == selectCategory,
              onPresseds: () {
                setState(
                  () {
                    selectCategory = app_data.categorias[index];
                  },
                );
              },
            );
          },
          separatorBuilder: (_, index) => const SizedBox(
                width: 10,
              ),
          itemCount: app_data.categorias.length),
    );
  }

  _searchproduto() {
    return AddToCartAnimation(
      gkCart: gkCart,
      previewCurve: Curves.ease,
      previewDuration: const Duration(milliseconds: 100),
      receiveCreateAddToCardAnimationMethod: (addToCardAnimationMethod) {
        // You can run the animation by addToCardAnimationMethod, just pass trough the the global key of  the image as parameter
        runAddToCardAnimation = addToCardAnimationMethod;
      },
      child: Padding(
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
      ),
    );
  }
}
