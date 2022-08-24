import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FormDefault extends StatefulWidget {
  int? tipo;
  Icon iconTitipo;
  String? inputMenssagem;
  bool? isObscureText;
  bool isSecret;
  TextEditingController? controller;
  FormFieldValidator<String>? validator;
  TextInputType? type;
  TextInputAction? textInputAction;
  FocusNode? focus;
  FocusNode? nextFocus;
  FormDefault({
    Key? key,
    this.tipo,
    required this.iconTitipo,
    this.inputMenssagem,
    this.isObscureText,
    required this.isSecret,
    this.controller,
    this.validator,
    this.type,
    this.textInputAction,
    this.focus,
    this.nextFocus,
  }) : super(key: key);

  @override
  State<FormDefault> createState() => _FormDefaultState();
}

class _FormDefaultState extends State<FormDefault> {
  bool isObscureText = false;
  @override
  void initState() {
    super.initState();
    isObscureText = widget.isSecret;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObscureText,
      style: const TextStyle(
        color: Color.fromARGB(255, 4, 4, 4),
      ),
      decoration: InputDecoration(
        prefixIcon: widget.iconTitipo,
        suffixIcon: widget.isSecret
            ? IconButton(
                onPressed: () {
                  setState(
                    () {
                      isObscureText = !isObscureText;
                    },
                  );
                },
                icon: Icon(
                    isObscureText ? Icons.visibility_off : Icons.visibility))
            : null,
        labelText: widget.inputMenssagem,
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),
    );
  }
}
