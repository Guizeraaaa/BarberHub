import 'package:flutter/material.dart';

class ThemeController extends ChangeNotifier {
  bool darkMode = false;

  void toggleTheme() {
    darkMode = !darkMode;
    notifyListeners();
  }
}
