import 'package:flutter/material.dart';
import 'package:sacolao_de_frutas/src/config/custom_color.dart';

class CategoryTitle extends StatefulWidget {
  CategoryTitle({
    Key? key,
    required this.category,
    required this.isSelect,
  }) : super(key: key);
  final String category;
  final bool isSelect;

  String selectCategory = 'Frutas';
  @override
  State<CategoryTitle> createState() => _CategoryTitleState();
}

class _CategoryTitleState extends State<CategoryTitle> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          color: widget.isSelect ? Colors.green.shade600 : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          widget.category,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: widget.isSelect ? 16 : 14,
              color: widget.isSelect ? Colors.white : Colors.red),
        ),
      ),
    );
  }
}
