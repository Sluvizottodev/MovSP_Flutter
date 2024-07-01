import 'package:flutter/material.dart';

class BottomAppBarComponent extends StatelessWidget {
  final void Function() onHomePressed;
  final void Function() onOlhoVivoPressed;

  const BottomAppBarComponent({
    Key? key,
    required this.onHomePressed,
    required this.onOlhoVivoPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: onHomePressed,
          ),
          IconButton(
            icon: Icon(Icons.directions_bus),
            onPressed: onOlhoVivoPressed,
          ),
        ],
      ),
    );
  }
}
