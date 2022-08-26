import 'package:flutter/material.dart';

class BaseScreen extends StatelessWidget {
  BaseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const <Widget>[
          Center(
            child: Text('data'),
          ),
        ],
      ),
    );
  }
}
