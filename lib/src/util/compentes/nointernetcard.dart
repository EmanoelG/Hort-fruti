import 'package:flutter/material.dart';

class NoInternetCard extends StatelessWidget {
  const NoInternetCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RetryCard(
                    errorMessage: 'Sem conexão com internet',
                    onRetryPressed: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RetryCard extends StatelessWidget {
  final String errorMessage;
  final Function onRetryPressed;

  RetryCard({required this.errorMessage, required this.onRetryPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              errorMessage,
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              child: Text('Tente Novamente'),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
