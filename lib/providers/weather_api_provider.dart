import 'package:flutter/material.dart';
import 'package:wynd/api/api_call.dart';
import 'package:wynd/models/weather_model.dart';

class WeatherProvider with ChangeNotifier {
  WeatherModel? weather;
  List<ForecastModel> upcomingForecasts = [];
  String? errorMessage;

  Future<void> fetchWeather(String cityName) async {
    try {
      final data = await ApiCall().getCurrentWeather(cityName);

      weather = WeatherModel.fromJson(data['list'][0], data['city']);

      List<dynamic> forecastList = data['list'];
      Set<String> uniqueDates = {};
      List<ForecastModel> tempForecasts = [];

      for (var item in forecastList) {
        DateTime dateTime = DateTime.parse(item['dt_txt']);
        String dateStr = dateTime.toLocal().toString().substring(0, 10);

        if (!uniqueDates.contains(dateStr)) {
          uniqueDates.add(dateStr);
          tempForecasts.add(ForecastModel.fromJson(item));
        }

        if (tempForecasts.length == 5) break;
      }
      print('api provider called');

      upcomingForecasts = tempForecasts;
      errorMessage = null;
      notifyListeners();
    } catch (e, stackTrace) {
      print('STACK TRACE: $stackTrace');
      errorMessage = 'Error fetching weather: $e';
      print(e);
      errorMessage = 'Error fetching weather: $e';
      notifyListeners();
    }
  }
}
