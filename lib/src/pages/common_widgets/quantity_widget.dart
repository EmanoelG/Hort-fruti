import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuantityWidget extends StatelessWidget {
  final int value;
  final String suffxText;
  final Function(int quantity) result;
  final bool isRemovable;
  const QuantityWidget({
    Key? key,
    required this.value,
    required this.suffxText,
    required this.result,
    this.isRemovable = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              spreadRadius: 1,
              blurRadius: 2,
            ),
          ]),
      child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _QuantityButton(
              color: isRemovable || value > 1 ? Colors.grey : Colors.red,
              icon: isRemovable || value > 1
                  ? Icons.remove
                  : Icons.delete_forever,
              onPressed: () {
                if (value == 1 && isRemovable ) return;
                int resultCount = value - 1;
                result(resultCount);
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Text(
                '$value$suffxText',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
            _QuantityButton(
              color: Colors.green,
              icon: Icons.add,
              onPressed: () {
                int resultCount = value + 1;
                result(resultCount);
              },
            ),
          ]),
    );
  }
}

class _QuantityButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final VoidCallback onPressed;
  _QuantityButton({
    Key? key,
    required this.color,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(50),
        child: Ink(
          height: 25,
          width: 25,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 16,
          ),
        ),
      ),
    );
  }
}
