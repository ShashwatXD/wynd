import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationProvider with ChangeNotifier {
  // City list
  final List<String> cities = [
    'Delhi',
    'Mumbai',
    'Bangalore',
    'Hyderabad',
    'Chennai',
    'Kolkata',
    'Pune',
    'Jaipur',
    'Ahmedabad',
    'Lucknow',
  ];

  String currentCity = 'Delhi';

  LocationProvider() {
    loadSavedCity();
  }

  Future<void> loadSavedCity() async {
    final prefs = await SharedPreferences.getInstance();
    currentCity = prefs.getString('saved') ?? 'Delhi';
    notifyListeners();
  }

  Future<void> changeCity(String newCity) async {
    currentCity = newCity;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('saved', newCity);
  }
}
