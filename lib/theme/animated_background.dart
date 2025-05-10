import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wynd/providers/theme_provider.dart';

BoxDecoration getAnimatedBack(context) {
  final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

  return BoxDecoration(
    gradient: LinearGradient(
      colors:
          isDarkMode
              ? [
                const Color.fromARGB(255, 32, 66, 93),
                const Color.fromARGB(255, 24, 52, 67),
              ]
              : [
                const Color.fromARGB(255, 195, 227, 254),
                Colors.lightBlueAccent,
              ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  );
}
