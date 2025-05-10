import 'package:flutter/material.dart';
import 'package:wynd/models/weather_model.dart';

class ForecastProvider with ChangeNotifier {
  List<ForecastModel> forecastList = [];
  int currentIndex = 0;

  void setForecastData(List<ForecastModel> list, int selectedIndex) {
    forecastList = list;
    currentIndex = selectedIndex;
    notifyListeners();
  }

  void updateCurrentIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
