import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextApp extends StatefulWidget {
  String texto;
  FontWeight? fontWeight;
  Color colorFont;
  double? fontSize;
  TextAlign alinhamento;
  TextApp({
    Key? key,
    required this.texto,
    this.fontWeight = FontWeight.bold,
    this.colorFont = Colors.black,
    this.fontSize = 12,
    this.alinhamento = TextAlign.left,
  }) : super(key: key);

  @override
  State<TextApp> createState() => _TextAppState();
}

class _TextAppState extends State<TextApp> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.texto,
      textAlign: widget.alinhamento,
      style:
          TextStyle(fontWeight: widget.fontWeight, fontSize: widget.fontSize),
    );
  }
}
