import 'package:flutter/material.dart';

import '../../login/colors_app.dart';

class AppBarDef extends StatefulWidget implements PreferredSizeWidget {
  final String namePage;
  final Color corPage;

  const AppBarDef({this.namePage = 'Quitanda', this.corPage = Colors.green});

  @override
  State<AppBarDef> createState() => _AppBarDefState();

  @override
  Size get preferredSize => const Size.fromHeight(50);
}

class _AppBarDefState extends State<AppBarDef> {
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromWidth(100), // here the desired height
      child: AppBar(
        backgroundColor: widget.corPage,
        centerTitle: true,
        title: Text(widget.namePage.toString()),
      ),
    );
  }
}
