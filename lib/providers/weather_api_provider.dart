import 'package:flutter/material.dart';
import 'package:wynd/api/api_call.dart';
import 'package:wynd/models/weather_model.dart';

class WeatherProvider with ChangeNotifier {
  WeatherModel? weather;
  String? errorMessage;

  Future<void> fetchWeather() async {
    try {
      final data = await ApiCall().getCurrentWeather();

      weather = WeatherModel.fromJson(data);
      notifyListeners();
    } catch (e) {
      errorMessage = 'Error fetching weather: $e';
      notifyListeners();
    }
  }
}
