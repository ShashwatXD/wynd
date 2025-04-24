import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:wynd/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:wynd/models/weather_model.dart';
import 'package:wynd/widgets/weather_icon.dart';
import 'package:wynd/providers/theme_provider.dart';
import 'package:wynd/providers/forecast_provider.dart';

class ForecastDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final forecastProvider = context.watch<ForecastProvider>();
    final forecastList = forecastProvider.forecastList;
    final initialIndex = forecastProvider.currentIndex;

    final pageController = PageController(
      initialPage: initialIndex,
      viewportFraction: 1,
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                decoration: BoxDecoration(
                  color:
                      Provider.of<ThemeProvider>(context).isDarkMode
                          ? Colors.black.withOpacity(0.2)
                          : Colors.white.withOpacity(0.1),
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 1.5,
                    color:
                        Provider.of<ThemeProvider>(context).isDarkMode
                            ? Colors.white.withOpacity(0.1)
                            : Colors.white.withOpacity(0.3),
                  ),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    size: 24,
                    color:
                        Provider.of<ThemeProvider>(context).isDarkMode
                            ? Colors.white
                            : Colors.black87,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ),
        ),
      ),
      body: Container(
        decoration: getWeatherBackgroundDecoration(context),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: pageController,
                  itemCount: forecastList.length,
                  onPageChanged: (index) {
                    context.read<ForecastProvider>().updateCurrentIndex(index);
                  },
                  itemBuilder: (context, index) {
                    final forecast = forecastList[index];

                    return AnimatedBuilder(
                      animation: pageController,
                      builder: (context, child) {
                        double value = 1;
                        if (pageController.position.haveDimensions) {
                          value = pageController.page! - index;
                          value = (1 - (value.abs() * 0.7)).clamp(0.95, 0.95);
                        }
                        return Center(
                          child: Transform.scale(
                            scale: value,
                            child: ForecastCard(forecast: forecast),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ForecastCard extends StatelessWidget {
  final ForecastModel forecast;

  const ForecastCard({required this.forecast});

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('EEE, MMM d').format(forecast.date);
    final temperature = (forecast.temperature - 273).toStringAsFixed(1);
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(26),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
          child: Container(
            decoration: BoxDecoration(
              color:
                  isDarkMode
                      ? Colors.black.withOpacity(0.2)
                      : Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                width: 1.5,
                color:
                    isDarkMode
                        ? Colors.white.withOpacity(0.1)
                        : Colors.white.withOpacity(0.3),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 30,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color:
                              isDarkMode
                                  ? Colors.white.withOpacity(0.1)
                                  : Colors.white.withOpacity(0.34),
                          blurRadius: 30,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Hero(
                      tag: 'first${forecast.date}',
                      child: GetWeatherIcon(
                        weatherCondition: forecast.weatherMain,
                        iconSize: 70,
                      ),
                    ),
                  ),

                  SizedBox(height: 50),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color:
                              isDarkMode
                                  ? Colors.black.withOpacity(0.15)
                                  : Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            width: 1,
                            color:
                                isDarkMode
                                    ? Colors.white.withOpacity(0.05)
                                    : Colors.white.withOpacity(0.2),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  size: 16,
                                  color:
                                      isDarkMode
                                          ? Colors.white70
                                          : Colors.black87,
                                ),
                                SizedBox(width: 10),
                                Hero(
                                  tag: 'second${formattedDate}',
                                  child: Text(
                                    formattedDate,
                                    style: getBodyTextStyle(
                                      context,
                                    ).copyWith(fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 30),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        decoration: BoxDecoration(
                          color:
                              isDarkMode
                                  ? Colors.black.withOpacity(0.15)
                                  : Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            width: 1,
                            color:
                                isDarkMode
                                    ? Colors.white.withOpacity(0.05)
                                    : Colors.white.withOpacity(0.2),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Hero(
                                  tag:
                                      'third${forecast.date.millisecondsSinceEpoch}',
                                  child: Text(
                                    forecast.weatherMain,
                                    style: getBodyTextStyle(
                                      context,
                                    ).copyWith(fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    isDarkMode
                                        ? Colors.white.withOpacity(0.1)
                                        : Colors.black.withOpacity(0.05),
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  width: 1,
                                  color:
                                      isDarkMode
                                          ? Colors.white.withOpacity(0.1)
                                          : Colors.white.withOpacity(0.1),
                                ),
                              ),
                              child: Text(
                                '$temperature°C',
                                style: getBodyTextStyle(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDetailRow(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 16,
              color: isDarkMode ? Colors.white70 : Colors.black87,
            ),
            SizedBox(width: 8),
            Text(label, style: getBodyTextStyle(context)),
          ],
        ),
        Text(
          value,
          style: getBodyTextStyle(
            context,
          ).copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
