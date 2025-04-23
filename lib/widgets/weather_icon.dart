import 'package:flutter/material.dart';

class GetWeatherIcon extends StatelessWidget {
  final String weatherCondition;
  double iconSize;
  GetWeatherIcon({
    super.key,
    required this.weatherCondition,
    required this.iconSize,
  });

  IconData iconData = Icons.wb_sunny;

  @override
  Widget build(BuildContext context) {
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
        width: iconSize + 30,
        height: iconSize + 30,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 0, 0, 0).withOpacity(.4),
          shape: BoxShape.circle,
        ),
        child: Icon(iconData, color: Colors.white, size: iconSize),
      ),
    );
  }
}
