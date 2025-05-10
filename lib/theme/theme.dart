import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wynd/providers/theme_provider.dart';

Divider getDivider(context) {
  final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
  return Divider(
    color:
        isDarkMode
            ? Colors.white.withOpacity(0.3)
            : Colors.black.withOpacity(0.3),
    thickness: 1,
    height: 24,
  );
}

BoxDecoration getWeatherBackgroundDecoration(context) {
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

TextStyle getHeadingTextStyle(context) {
  final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
  return TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: isDarkMode ? Colors.white : Colors.black87,
    letterSpacing: 0.5,
    height: 1.2,
    shadows:
        isDarkMode
            ? [
              Shadow(
                offset: Offset(0, 2),
                blurRadius: 3.0,
                color: Colors.black.withOpacity(0.3),
              ),
            ]
            : null,
    decoration: TextDecoration.none,
    decorationColor: isDarkMode ? Colors.white70 : Color(0xFF0F3460),
    decorationThickness: 1.5,
    fontFamily: 'Roboto',
  );
}

TextStyle getBodyTextStyle(context) {
  final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
  return TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.bold,
    color: isDarkMode ? Colors.white : Colors.black87,
    letterSpacing: 0.5,
    height: 1.2,
    shadows:
        isDarkMode
            ? [
              Shadow(
                offset: Offset(0, 2),
                blurRadius: 3.0,
                color: Colors.black.withOpacity(0.3),
              ),
            ]
            : null,
    decoration: TextDecoration.none,
    decorationColor: isDarkMode ? Colors.white70 : Color(0xFF0F3460),
    decorationThickness: 1.5,
    fontFamily: 'Roboto',
  );
}

BoxDecoration getThemeAwareCardDecoration(context) {
  final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
  final colorScheme = Theme.of(context).colorScheme;

  return BoxDecoration(
    borderRadius: BorderRadius.circular(16),
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors:
          isDarkMode
              ? [
                colorScheme.surface.withOpacity(0.25),
                colorScheme.surface.withOpacity(0.05),
              ]
              : [
                colorScheme.surface.withOpacity(0.2),
                colorScheme.surface.withOpacity(0.05),
              ],
    ),
    border: Border.all(
      color: colorScheme.onSurface.withOpacity(0.1),
      width: 1.0,
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(isDarkMode ? 0.3 : 0.1),
        blurRadius: 20,
        spreadRadius: 1,
        offset: const Offset(0, 4),
      ),
      BoxShadow(
        color: Colors.white.withOpacity(isDarkMode ? 0.05 : 0.1),
        blurRadius: 10,
        spreadRadius: -5,
        offset: const Offset(0, -2),
      ),
    ],
  );
}
