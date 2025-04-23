import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wynd/widgets/loading.dart';
import 'package:wynd/widgets/error_screen.dart';
import 'package:wynd/widgets/weather_icon.dart';
import 'package:wynd/widgets/background_image.dart';
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
          return _buildMainUI(context, weather, weatherProvider);
        },
      ),
    );
  }

  Widget _buildMainUI(context, weather, weatherProvider) {
    final sunriseTime = DateFormat('h:mm a').format(weather.sunrise.toLocal());
    final sunsetTime = DateFormat('h:mm a').format(weather.sunset.toLocal());

    return Container(
      decoration: getWeatherBackgroundDecoration(weather.weatherMain),

      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "New Delhi",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.1,
                          shadows: [
                            Shadow(
                              blurRadius: 2.0,
                              color: Colors.black.withOpacity(0.3),
                              offset: Offset(1.0, 1.0),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "India",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(color: Colors.white.withOpacity(0.3), thickness: 1),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  await weatherProvider.fetchWeather();
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      GetWeatherIcon(
                        weatherCondition: weather.weatherMain,
                        iconSize: 80,
                      ),
                      SizedBox(height: 16),
                      Text(
                        '${(weather.temperature - 273).toStringAsFixed(1)}°C',
                        style: TextStyle(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              blurRadius: 4.0,
                              color: Colors.black.withOpacity(0.3),
                              offset: Offset(2.0, 2.0),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        weather.weatherMain,
                        style: TextStyle(
                          color: const Color.fromARGB(
                            255,
                            211,
                            211,
                            211,
                          ).withOpacity(0.9),
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2,
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(
                            255,
                            0,
                            0,
                            0,
                          ).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.calendar_today,
                              color: const Color.fromARGB(255, 0, 0, 0),
                              size: 18,
                            ),
                            SizedBox(width: 8),
                            Text(
                              DateFormat(
                                'EEEE, MMM d, y',
                              ).format(DateTime.now()),
                              style: TextStyle(
                                color: const Color.fromARGB(255, 255, 255, 255),
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(
                            255,
                            50,
                            49,
                            49,
                          ).withOpacity(0.7),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 10,

                              offset: Offset(0, 4),
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
                              Divider(
                                color: Colors.white.withOpacity(0.3),
                                height: 30,
                              ),
                              _buildInfoRow(
                                Icons.wb_sunny,
                                "Sunrise",
                                sunriseTime,
                              ),
                              Divider(
                                color: Colors.white.withOpacity(0.3),
                                height: 30,
                              ),
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Upcoming Forecast',
                              style: TextStyle(
                                color: const Color.fromARGB(255, 144, 144, 144),
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    blurRadius: 2.0,
                                    color: const Color.fromARGB(
                                      255,
                                      72,
                                      70,
                                      70,
                                    ).withOpacity(0.3),
                                    offset: Offset(1.0, 1.0),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount:
                                  weatherProvider.upcomingForecasts.length - 1,
                              itemBuilder: (context, index) {
                                final forecast =
                                    weatherProvider.upcomingForecasts[index +
                                        1];
                                final formattedDate = DateFormat(
                                  'EEE, MMM d',
                                ).format(forecast.date);

                                return Container(
                                  margin: EdgeInsets.only(bottom: 16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    gradient: LinearGradient(
                                      colors: [
                                        const Color.fromARGB(
                                          255,
                                          9,
                                          9,
                                          9,
                                        ).withOpacity(0.25),
                                        const Color.fromARGB(
                                          255,
                                          0,
                                          0,
                                          0,
                                        ).withOpacity(0.15),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color.fromARGB(
                                          255,
                                          1,
                                          1,
                                          1,
                                        ).withOpacity(0.55),
                                        blurRadius: 1,
                                        offset: Offset(0, 1),
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0,
                                      vertical: 12.0,
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 60,
                                          height: 60,
                                          child: Center(
                                            child: GetWeatherIcon(
                                              weatherCondition:
                                                  forecast.weatherMain,
                                              iconSize: 35,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 16),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                formattedDate,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(height: 4),
                                              Text(
                                                forecast.weatherMain,
                                                style: TextStyle(
                                                  color: Colors.white
                                                      .withOpacity(0.9),
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          '${(forecast.temperature - 273).toStringAsFixed(1)}°C',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
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
        Icon(icon, color: Colors.white, size: 30),
        SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 16,
              ),
            ),
            SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
