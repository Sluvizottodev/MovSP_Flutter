import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  ThemeData getTheme() {
    return _isDarkMode
        ? ThemeData.dark()
        : ThemeData.light().copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.blueAccent,
      ),
    );
  }

  ThemeMode get themeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;
}
