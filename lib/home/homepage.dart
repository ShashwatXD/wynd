import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wynd/widgets/loading.dart';
import 'package:wynd/widgets/error_screen.dart';
import 'package:wynd/widgets/weather_icon.dart';
import 'package:wynd/providers/weather_api_provider.dart';

class WeatherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<WeatherProvider>(
        builder: (context, weatherProvider, child) {
          if (weatherProvider.weather == null &&
              weatherProvider.errorMessage == null) {
            weatherProvider.fetchWeather();
            return LoadingScreen();
          }

          if (weatherProvider.errorMessage != null) {
            return ErrorScreen(
              errorMessage: weatherProvider.errorMessage!,
              onRetry: () {
                weatherProvider.fetchWeather();
              },
            );
          }

          final weather = weatherProvider.weather!;
          return _buildmainUI(context, weather, weatherProvider);
        },
      ),
    );
  }

  Widget _buildmainUI(context, weather, weatherProvider) {
    List<Color> gradientColors = _getBackgroundColors(weather.weatherMain);
    final sunriseTime = DateFormat('h:mm a').format(weather.sunrise.toLocal());
    final sunsetTime = DateFormat('h:mm a').format(weather.sunset.toLocal());

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: gradientColors,
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "New Delhi,India",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.refresh, color: Colors.white, size: 28),
                    onPressed: () {
                      weatherProvider.fetchWeather();
                    },
                  ),
                ],
              ),
            ),
            Divider(color: Colors.blueGrey[600]!, height: 0),
            Expanded(
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  SizedBox(height: 30),
                  GetWeatherIcon(weatherCondition: weather.weatherMain),
                  SizedBox(height: 19),
                  Center(
                    child: Text(
                      weather.weatherMain,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 24),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(
                        255,
                        1,
                        0,
                        0,
                      ).withOpacity(0.4),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(
                            255,
                            254,
                            254,
                            254,
                          ).withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          _buildInfoRow(
                            Icons.air,
                            "Wind Speed",
                            "${weather.windSpeed} m/s",
                          ),
                          Divider(color: Colors.white30, height: 30),
                          _buildInfoRow(Icons.wb_sunny, "Sunrise", sunriseTime),
                          Divider(color: Colors.white30, height: 30),
                          _buildInfoRow(
                            Icons.nightlight_round,
                            "Sunset",
                            sunsetTime,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        weatherProvider.fetchWeather();
                      },
                      icon: Icon(Icons.refresh),
                      label: Text("Update Weather"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                          255,
                          43,
                          43,
                          43,
                        ).withOpacity(0.3),
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 5,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.white, size: 29),
        SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(color: Colors.white70, fontSize: 16)),
            SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  List<Color> _getBackgroundColors(String weatherCondition) {
    switch (weatherCondition.toLowerCase()) {
      case 'clear':
        return [Colors.blue[300]!, Colors.blue[700]!];
      case 'clouds':
        return [Colors.blueGrey[300]!, Colors.blueGrey[700]!];
      case 'rain':
        return [Colors.indigo[300]!, Colors.indigo[700]!];
      case 'thunderstorm':
        return [Colors.deepPurple[400]!, Colors.deepPurple[900]!];
      case 'snow':
        return [Colors.lightBlue[100]!, Colors.lightBlue[300]!];
      default:
        return [Colors.blue[300]!, Colors.blue[600]!];
    }
  }
}
