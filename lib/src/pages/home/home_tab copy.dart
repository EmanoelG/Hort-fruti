import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:sacolao_de_frutas/src/pages/common_widgets/custom_shimmer.dart';
import 'package:shimmer/shimmer.dart';
import '../../config/custom_color.dart';
import '../../service/forma_services.dart';
import '../common_widgets/title_app.dart';
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
  final UtilsService service = UtilsService();
  late Function(GlobalKey) runAddToCardAnimation;
  bool isLoading = true;
  void itemSelectedCartAnimation(GlobalKey gkImage) {
    runAddToCardAnimation(gkImage);
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5)).then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: TitleApp(),
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
    return isLoading
        ? Shimmer.fromColors(
            highlightColor: Color.fromARGB(255, 215, 240, 188),
            baseColor: Color.fromARGB(255, 90, 207, 94),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [_searchproduto(), _categoria(), _griditens(context)],
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [_searchproduto(), _categoria(), _griditens(context)],
            ),
          );
  }

  Expanded _griditens(context) {
    final size = MediaQuery.of(context).size;
    return Expanded(
      child: isLoading
          ? GridView.builder(
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 9 / 11.5,
                maxCrossAxisExtent: 200,
              ),
              itemCount: app_data.categorias.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(5),
                  child: ItemTitle(
                    Item: app_data.items[index],
                    runAddToCardAnimationMethod: itemSelectedCartAnimation,
                  ),
                );
              },
            )
          : GridView.count(
              physics: const BouncingScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 9 / 11.5,
              children: List.generate(
                6,
                (index) {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: CustomShimmer(
                      highlightColor: Color.fromARGB(255, 215, 240, 188),
                      baseColor: Color.fromARGB(255, 90, 207, 94),
                      height: size.height,
                      width: size.width,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  );
                },
              ),
            ),
    );
  }

/* */
  _categoria() {
    return Material(
      color: Colors.transparent,
      child: Container(
        height: 25,
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