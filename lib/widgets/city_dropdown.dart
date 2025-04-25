import 'package:flutter/material.dart';
import 'package:wynd/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:wynd/providers/location_provider.dart';
import 'package:wynd/providers/weather_api_provider.dart';

void showCityDropdown(BuildContext context) {
  final locationProvider = Provider.of<LocationProvider>(
    context,
    listen: false,
  );
  final weatherProvider = Provider.of<WeatherProvider>(context, listen: false);

  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: 300,
        child: ListView.builder(
          itemCount: locationProvider.cities.length,
          itemBuilder: (context, index) {
            final city = locationProvider.cities[index];
            return ListTile(
              title: Text(city, style: getBodyTextStyle(context)),
              onTap: () async {
                locationProvider.currentCity = city;
                Navigator.pop(context);
                await locationProvider.changeCity(city);

                await weatherProvider.fetchWeather(city);
              },
            );
          },
        ),
      );
    },
  );
}
