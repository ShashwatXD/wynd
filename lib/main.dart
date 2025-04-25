import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wynd/screens/homepage.dart';
import 'package:wynd/providers/theme_provider.dart';
import 'package:wynd/providers/location_provider.dart';
import 'package:wynd/providers/forecast_provider.dart';
import 'package:wynd/providers/weather_api_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WeatherProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => ForecastProvider()),
        ChangeNotifierProvider(create: (context) => LocationProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WeatherScreen(),
    );
  }
}
