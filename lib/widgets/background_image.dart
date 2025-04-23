import 'package:flutter/material.dart';

String getBackgroundImagePath({required String weatherCondition}) {
  switch (weatherCondition.toLowerCase()) {
    case 'clear':
      return 'images/clear.jpg';
    case 'clouds':
      return 'assets/images/cloudy.jpg';
    case 'rain':
      return 'assets/images/rainy.jpg';
    case 'snow':
      return 'assets/images/snowy.jpg';
    case 'thunderstorm':
      return 'assets/images/thunderstorm.jpg';
    default:
      return 'assets/images/default_weather.jpg';
  }
}

BoxDecoration getWeatherBackgroundDecoration(String weatherCondition) {
  return BoxDecoration(
    image: DecorationImage(
      image: AssetImage(
        getBackgroundImagePath(weatherCondition: weatherCondition),
      ),
      fit: BoxFit.cover,
      colorFilter: ColorFilter.mode(
        Colors.black.withOpacity(0.5),
        BlendMode.darken,
      ),
    ),
  );
}
