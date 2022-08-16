import 'dart:ffi';

import 'package:flutter/material.dart';

import '../util/pageDefault/app_bar.dart';

class SingInScreen extends StatelessWidget {
  const SingInScreen() : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(208, 168, 231, 95),
      body: telalogin(),
    );
  }

  telalogin() {
    return Column(
      children: [
        Expanded(
          child: Container(
            child: const Center(
              child: Text('Greengrocer'),
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
              vertical: 40,
            ),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(40.0),
              ),
            ),
            child: formLogin(),
          ),
        ),
      ],
    );
  }

  Form formLogin() => Form(
        child: Column(
          children: [
            TextFormField(
              style: const TextStyle(
                color: Color.fromARGB(255, 4, 4, 4),
              ),
              decoration: InputDecoration(
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            ),
          ],
        ),
      );
}
