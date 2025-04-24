import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:wynd/theme/theme.dart';
import 'package:wynd/api/api_call.dart';
import 'package:provider/provider.dart';
import 'package:wynd/screens/day_detail.dart';
import 'package:wynd/widgets/error_screen.dart';
import 'package:wynd/widgets/skeletonizer.dart';
import 'package:wynd/widgets/weather_icon.dart';
import 'package:wynd/providers/theme_provider.dart';
import 'package:wynd/widgets/toggle_mode_button.dart';
import 'package:wynd/providers/forecast_provider.dart';
import 'package:wynd/providers/weather_api_provider.dart';

class WeatherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Consumer<WeatherProvider>(
        builder: (context, weatherProvider, child) {
          if (weatherProvider.weather == null &&
              weatherProvider.errorMessage == null) {
            weatherProvider.fetchWeather();
            return buildSkeletonLoading(context);
          }

          if (weatherProvider.errorMessage != null) {
            return ErrorScreen(
              errorMessage: weatherProvider.errorMessage!,
              onRetry: () => weatherProvider.fetchWeather(),
            );
          }

          return _buildMainUI(
            context,
            weatherProvider.weather!,
            weatherProvider,
          );
        },
      ),
    );
  }

  Widget _buildMainUI(context, weather, weatherProvider) {
    final sunriseTime = DateFormat('h:mm a').format(weather.sunrise.toLocal());
    final sunsetTime = DateFormat('h:mm a').format(weather.sunset.toLocal());
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    //to be implemetned throughout

    return AnimatedContainer(
      duration: Duration(seconds: 1),
      width: screenWidth,
      height: screenHeight,
      decoration: getWeatherBackgroundDecoration(context),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
                vertical: screenHeight * 0.05,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ApiCall().cityName,
                        style: getHeadingTextStyle(context),
                      ),
                      SizedBox(height: 4),
                      Text("India", style: getHeadingTextStyle(context)),
                    ],
                  ),

                  //the toggle button
                  ToggleModeButton(),
                ],
              ),
            ),
            getDivider(context),

            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  await weatherProvider.fetchWeather();
                },
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
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
                            style: getHeadingTextStyle(context),
                          ),
                          SizedBox(height: 2),
                          Text(
                            weather.weatherMain,
                            style: getHeadingTextStyle(context),
                          ),
                          SizedBox(height: 16),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: 8.0,
                                sigmaY: 8.0,
                              ),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                decoration: getThemeAwareCardDecoration(
                                  context,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(width: 8),
                                    Text(
                                      DateFormat(
                                        'EEEE, MMM d, y',
                                      ).format(DateTime.now()),
                                      style: getBodyTextStyle(context),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            decoration: getThemeAwareCardDecoration(context),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  _buildInfoRow(
                                    Icons.air,
                                    "Wind Speed",
                                    "${weather.windSpeed} m/s",
                                    context,
                                  ),
                                  getDivider(context),
                                  _buildInfoRow(
                                    Icons.wb_sunny,
                                    "Sunrise",
                                    sunriseTime,
                                    context,
                                  ),
                                  getDivider(context),
                                  _buildInfoRow(
                                    Icons.nightlight_round,
                                    "Sunset",
                                    sunsetTime,
                                    context,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Upcoming Forecast',
                                  style: getHeadingTextStyle(context),
                                ),
                                SizedBox(height: 20),

                                //checkk
                                Container(
                                  height: screenHeight * .32,
                                  width: screenWidth * 0.82,
                                  child: PageView.builder(
                                    controller: PageController(
                                      viewportFraction: 0.75,
                                    ),
                                    itemCount:
                                        weatherProvider
                                            .upcomingForecasts
                                            .length -
                                        1,
                                    physics: BouncingScrollPhysics(),
                                    padEnds: false,
                                    itemBuilder: (context, index) {
                                      final forecast =
                                          weatherProvider
                                              .upcomingForecasts[index + 1];
                                      final formattedDate = DateFormat(
                                        'EEE, MMM d',
                                      ).format(forecast.date);

                                      //work here

                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: screenHeight * .012,
                                          vertical: screenWidth * .010,
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            context
                                                .read<ForecastProvider>()
                                                .setForecastData(
                                                  weatherProvider
                                                      .upcomingForecasts,
                                                  index + 1,
                                                );
                                            Navigator.push(
                                              context,
                                              PageRouteBuilder(
                                                transitionDuration: Duration(
                                                  milliseconds: 850,
                                                ),
                                                pageBuilder:
                                                    (_, __, ___) =>
                                                        ForecastDetailsScreen(),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            decoration:
                                                getThemeAwareCardDecoration(
                                                  context,
                                                ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                16.0,
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Hero(
                                                    tag:
                                                        'first${forecast.date}',
                                                    child: GetWeatherIcon(
                                                      weatherCondition:
                                                          forecast.weatherMain,
                                                      iconSize: 50,
                                                    ),
                                                  ),
                                                  SizedBox(height: 8),
                                                  Hero(
                                                    tag:
                                                        'second${formattedDate}',
                                                    child: Text(
                                                      formattedDate,
                                                      style: getBodyTextStyle(
                                                        context,
                                                      ).copyWith(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 4),
                                                  Hero(
                                                    tag:
                                                        'third${forecast.date.millisecondsSinceEpoch}',
                                                    child: Text(
                                                      forecast.weatherMain,
                                                      style: getBodyTextStyle(
                                                        context,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                  SizedBox(height: 8),
                                                  Text(
                                                    '${(forecast.temperature - 273).toStringAsFixed(1)}°C',
                                                    style: getBodyTextStyle(
                                                      context,
                                                    ).copyWith(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 30),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value, context) {
    return Row(
      children: [
        Icon(
          icon,
          color:
              Provider.of<ThemeProvider>(context).isDarkMode
                  ? Colors.white70
                  : Colors.black87,
        ),
        SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: getBodyTextStyle(context)),
            SizedBox(height: 4),
            Text(value, style: getBodyTextStyle(context)),
          ],
        ),
      ],
    );
  }
}
