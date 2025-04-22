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

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      weatherMain: json['weather'][0]['main'],
      temperature: json['main']['temp'],
      windSpeed: json['wind']['speed'],
      sunrise: DateTime.fromMillisecondsSinceEpoch(
        json['sys']['sunrise'] * 1000,
      ),
      sunset: DateTime.fromMillisecondsSinceEpoch(json['sys']['sunset'] * 1000),
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
}
