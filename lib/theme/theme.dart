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
    height: 30,
  );
}

BoxDecoration getWeatherBackgroundDecoration(context) {
  final effectiveDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

  return BoxDecoration(
    gradient: getBackgroundGradient(effectiveDarkMode),
    boxShadow: getBackgroundShadows(effectiveDarkMode),
    borderRadius: BorderRadius.circular(effectiveDarkMode ? 1 : 16),
  );
}

LinearGradient getBackgroundGradient(bool isDarkMode) {
  return isDarkMode
      ? const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [0.1, 0.5, 0.9],
        colors: [Color(0xFF1A1A2E), Color(0xFF16213E), Color(0xFF0F3460)],
      )
      : const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [0.0, 0.6, 1.0],
        colors: [
          Color.fromARGB(255, 236, 249, 255),
          Color.fromARGB(255, 164, 224, 251),
          Color.fromARGB(255, 111, 205, 249),
        ],
      );
}

List<BoxShadow>? getBackgroundShadows(bool isDarkMode) {
  return isDarkMode
      ? [
        BoxShadow(
          color: Colors.black.withOpacity(0.4),
          blurRadius: 10,
          spreadRadius: 2,
          offset: const Offset(0, 4),
        ),
      ]
      : [
        BoxShadow(
          color: Colors.blueGrey.withOpacity(0.1),
          blurRadius: 8,
          spreadRadius: 1,
          offset: const Offset(0, 2),
        ),
      ];
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

BoxDecoration getCardDecoration(context) {
  final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
  return BoxDecoration(
    color: isDarkMode ? const Color(0xFF202040) : Colors.white,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color:
            isDarkMode
                ? Colors.black.withOpacity(0.3)
                : Colors.grey.withOpacity(0.2),
        spreadRadius: 1,
        blurRadius: 5,
        offset: const Offset(0, 2),
      ),
    ],
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
                colorScheme.surface.withOpacity(0.2),
                colorScheme.surface.withOpacity(0.1),
              ]
              : [
                colorScheme.surface.withOpacity(0.3),
                colorScheme.surface.withOpacity(0.15),
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
