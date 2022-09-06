import 'package:flutter/material.dart';

class CategoryTitle extends StatefulWidget {
  const CategoryTitle({
    Key? key,
    required this.category,
    required this.isSelect,
  }) : super(key: key);
  final String category;
  final bool isSelect;
  @override
  State<CategoryTitle> createState() => _CategoryTitleState();
}

class _CategoryTitleState extends State<CategoryTitle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(widget.category),
    );
  }
}
