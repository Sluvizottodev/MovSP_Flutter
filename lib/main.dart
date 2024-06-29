import 'package:flutter/material.dart';

import 'Screens/HomeScreen.dart';

void main() {
  runApp(MoveSPApp());
}

class MoveSPApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Move SP',
      theme: ThemeData(
        //primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TelaHome(),
    );
  }
}
