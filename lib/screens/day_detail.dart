import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:wynd/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:wynd/models/weather_model.dart';
import 'package:wynd/widgets/weather_icon.dart';
import 'package:wynd/providers/theme_provider.dart';
import 'package:wynd/providers/location_provider.dart';
import 'package:wynd/providers/forecast_provider.dart';

class ForecastDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final forecastProvider = context.watch<ForecastProvider>();
    final forecastList = forecastProvider.forecastList;
    final initialIndex = forecastProvider.currentIndex;
    final screenHeight = MediaQuery.of(context).size.height;
    final locationProvider = Provider.of<LocationProvider>(context);

    final pageController = PageController(
      initialPage: initialIndex,
      viewportFraction: .82,
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: screenHeight * 0.002),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                decoration: getThemeAwareCardDecoration(context),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    size: 20,
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
              Text(
                '${locationProvider.currentCity},IND',
                style: getBodyTextStyle(context),
              ),
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
                        return Column(
                          children: [
                            SizedBox(height: screenHeight * 0.1),
                            Transform.scale(
                              scale: value,
                              child: ForecastCard(forecast: forecast),
                            ),
                          ],
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

  const ForecastCard({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('EEE, MMM d').format(forecast.date);
    final temperature = (forecast.temperature - 273).toStringAsFixed(1);
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenHeight * .013,
        vertical: screenWidth * .02,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(35),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
          child: Container(
            height: screenHeight * .51,
            width: screenWidth * 0.82,
            decoration: getThemeAwareCardDecoration(context),
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
                          blurRadius: 16,
                          spreadRadius: 1.2,
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
                        decoration: getThemeAwareCardDecoration(context),
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
                        decoration: getThemeAwareCardDecoration(context),
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
                              decoration: getThemeAwareCardDecoration(context),
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
}
