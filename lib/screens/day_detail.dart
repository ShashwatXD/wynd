import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:wynd/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:wynd/models/weather_model.dart';
import 'package:wynd/widgets/weather_icon.dart';
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
      body: Container(
        decoration: getWeatherBackgroundDecoration(context),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  size: 30,
                  color: const Color.fromARGB(255, 172, 172, 172),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
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
                        value = (1 - (value.abs() * 0.7)).clamp(0.95, .95);
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

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: Colors.black.withOpacity(0.35),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 40),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Hero(
              tag: 'first${forecast.date}',
              child: GetWeatherIcon(
                weatherCondition: forecast.weatherMain,
                iconSize: 60,
              ),
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Hero(
                  tag: 'second${formattedDate}',
                  child: Text(formattedDate, style: getBodyTextStyle(context)),
                ),
              ],
            ),

            getDivider(context),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Hero(
                  tag: 'third${forecast.date.millisecondsSinceEpoch}',
                  child: Text(
                    forecast.weatherMain,
                    style: getBodyTextStyle(context),
                  ),
                ),
                Text(
                  '$temperature°C',
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
