import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../config/custom_color.dart';
import 'components/category_title.dart';
import '../../config/app_data.dart' as app_data;

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  String selectCategory = 'Frutas';

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
            child: Badge(
              badgeColor: CustomColors.colorDestac,
              badgeContent:
                  const Text('0', style: TextStyle(color: Colors.white)),
              child: IconButton(
                onPressed: () {},
                icon: Icon(
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
          //childAspectRatio: 3 / 2,
        ),
        itemCount: app_data.categorias.length,
        itemBuilder: (context, index) {
          return _carditem(context, index);
        },
      ),
    );
  }

  Card _carditem(BuildContext context, index) {
    return Card(
      color: Color.fromARGB(255, 255, 254, 254),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(
              child: CachedNetworkImage(
                imageUrl: app_data.items[index].img,
                width: 400,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  app_data.items[index].ItemName,
                  maxLines: 1,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Text.rich(TextSpan(
              children: [
                TextSpan(
                  text: 'RS' + app_data.items[index].precie,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: CustomColors.colorButtonMain,
                  ),
                ),
                TextSpan(
                  text: '/' + app_data.items[index].unit,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.black54),
                ),
              ],
            )),
          ],
        ),
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

  Padding _searchproduto() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          isDense: true,
          hintText: 'Pesquisar por produto',
          hintStyle: TextStyle(
            color: Colors.grey.shade400,
            fontSize: 14,
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
