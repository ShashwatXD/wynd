import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool isDarkMode = true;

  ThemeProvider() {
    loadTheme();
  }

  bool? savedTheme;

  Future<void> loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    savedTheme = prefs.getBool('isDarkMode') ?? false;
    isDarkMode = savedTheme!;

    notifyListeners();
  }

  Future<void> toggleTheme() async {
    isDarkMode = !isDarkMode;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', isDarkMode);

    notifyListeners();
  }
}
