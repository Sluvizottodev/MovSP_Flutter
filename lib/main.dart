import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Screens/HomeScreen.dart';
import 'utils/ThemeProvider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: MoveSPApp(),
    ),
  );
}

class MoveSPApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return MaterialApp(
      title: 'Mov SP',
      theme: themeProvider.getTheme(),
      home: TelaHome(),
      themeMode: themeProvider.themeMode,
      debugShowCheckedModeBanner: false, // Remove o banner de depuração
    );
  }
}
