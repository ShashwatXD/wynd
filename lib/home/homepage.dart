import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
            return _buildLoadingState();
          }

          if (weatherProvider.errorMessage != null) {
            return _buildErrorState(weatherProvider.errorMessage!, context);
          }

          final weather = weatherProvider.weather!;
          return _buildWeatherUI(context, weather, weatherProvider);
        },
      ),
    );
  }

  Widget _buildLoadingState() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.lightBlue[300]!, Colors.blue[700]!],
        ),
      ),
      child: Center(child: CircularProgressIndicator.adaptive()),
    );
  }

  Widget _buildErrorState(String error, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.grey[400]!, Colors.grey[700]!],
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, color: Colors.red[300], size: 80),
              SizedBox(height: 16),
              Text(
                "Oops! Something went wrong",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12),
              Text(
                error,
                style: TextStyle(color: Colors.white70, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () {
                  Provider.of<WeatherProvider>(
                    context,
                    listen: false,
                  ).fetchWeather();
                },
                icon: Icon(Icons.refresh),
                label: Text("Try Again"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[600],
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeatherUI(
    BuildContext context,
    dynamic weather,
    WeatherProvider weatherProvider,
  ) {
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
                    "London, UK",
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
            Expanded(
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  SizedBox(height: 40),
                  _getWeatherIcon(weather.weatherMain),
                  SizedBox(height: 24),
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
                  SizedBox(height: 80),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 24),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
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
                        backgroundColor: Colors.white.withOpacity(0.3),
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
        Icon(icon, color: Colors.white, size: 28),
        SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(color: Colors.white70, fontSize: 14)),
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

  Widget _getWeatherIcon(String weatherCondition) {
    double iconSize = 100;
    IconData iconData;

    switch (weatherCondition.toLowerCase()) {
      case 'clear':
        iconData = Icons.wb_sunny;
        break;
      case 'clouds':
        iconData = Icons.cloud;
        break;
      case 'rain':
        iconData = Icons.grain;
        break;
      case 'thunderstorm':
        iconData = Icons.flash_on;
        break;
      case 'snow':
        iconData = Icons.ac_unit;
        break;
      case 'mist':
      case 'fog':
        iconData = Icons.cloud_queue;
        break;
      default:
        iconData = Icons.wb_sunny;
    }

    return Center(
      child: Container(
        width: iconSize + 40,
        height: iconSize + 40,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: Icon(iconData, color: Colors.white, size: iconSize),
      ),
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
