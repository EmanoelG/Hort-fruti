import 'package:flutter/material.dart';

class AppBarDef extends StatefulWidget implements PreferredSizeWidget {
  final String namePage;
  final Color corPage;
  const AppBarDef({
    Key? key,
    required this.namePage,
    this.corPage = Colors.green,
  }) : super(key: key);

  // const AppBarDef({this.namePage = 'Quitanda',});

  @override
  State<AppBarDef> createState() => _AppBarDefState();

  @override
  Size get preferredSize => const Size.fromHeight(50);
}

class _AppBarDefState extends State<AppBarDef> {
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromWidth(100), // here the desired height
      child: AppBar(
        backgroundColor: widget.corPage,
        
        centerTitle: true,
        title: Text(widget.namePage.toString()),
      ),
    );
  }
}
