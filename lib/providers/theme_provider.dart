import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool isDarkMode = true;
  ThemeMode currentTheme = ThemeMode.light;

  ThemeProvider() {
    _loadTheme();
  }

  bool? savedTheme;

  Future<void> _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    savedTheme = prefs.getBool('isDarkMode') ?? false;
    isDarkMode = savedTheme!;
    if (isDarkMode) {
      currentTheme = ThemeMode.dark;
    } else {
      currentTheme = ThemeMode.light;
    }

    notifyListeners();
  }

  Future<void> toggleTheme() async {
    isDarkMode = !isDarkMode;

    if (isDarkMode) {
      currentTheme = ThemeMode.dark;
    } else {
      currentTheme = ThemeMode.light;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', isDarkMode);

    notifyListeners();
  }
}
