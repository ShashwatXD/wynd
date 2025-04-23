class WeatherModel {
  final String weatherMain;
  final double temperature;
  final double windSpeed;
  final DateTime sunrise;
  final DateTime sunset;

  WeatherModel({
    required this.weatherMain,
    required this.temperature,
    required this.windSpeed,
    required this.sunrise,
    required this.sunset,
  });

  factory WeatherModel.fromJson(
    Map<String, dynamic> current,
    Map<String, dynamic> city,
  ) {
    return WeatherModel(
      weatherMain: current['weather'][0]['main'],
      temperature: current['main']['temp'],
      windSpeed: current['wind']['speed'],
      sunrise: DateTime.fromMillisecondsSinceEpoch(city['sunrise'] * 1000),
      sunset: DateTime.fromMillisecondsSinceEpoch(city['sunset'] * 1000),
    );
  }
}

class ForecastModel {
  final DateTime date;
  final String weatherMain;
  final double temperature;

  ForecastModel({
    required this.date,
    required this.weatherMain,
    required this.temperature,
  });

  factory ForecastModel.fromJson(Map<String, dynamic> item) {
    return ForecastModel(
      date: DateTime.parse(item['dt_txt']),
      weatherMain: item['weather'][0]['main'],
      temperature: item['main']['temp'],
    );
  }
}
