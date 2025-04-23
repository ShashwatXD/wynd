import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wynd/providers/theme_provider.dart';

BoxDecoration getWeatherBackgroundDecoration(BuildContext context) {
  final themeProvider = Provider.of<ThemeProvider>(context);
  final isDarkMode = themeProvider.isDarkMode;

  final effectiveDarkMode = isDarkMode;

  return BoxDecoration(
    gradient: _getBackgroundGradient(effectiveDarkMode),
    boxShadow: _getBackgroundShadows(effectiveDarkMode),
    borderRadius: BorderRadius.circular(effectiveDarkMode ? 12 : 16),
  );
}

LinearGradient _getBackgroundGradient(bool isDarkMode) {
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
        colors: [Color(0xFFE6F7FF), Color(0xFFB3E5FC), Color(0xFF81D4FA)],
      );
}

List<BoxShadow>? _getBackgroundShadows(bool isDarkMode) {
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

TextStyle getHeadingTextStyle(BuildContext context) {
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

TextStyle getBodyTextStyle(BuildContext context) {
  final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
  return TextStyle(
    fontSize: 16,
    color: isDarkMode ? Colors.white70 : Colors.black54,
  );
}

BoxDecoration getCardDecoration(BuildContext context) {
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

BoxDecoration getThemeAwareCardDecoration(BuildContext context) {
  final isDarkMode = Theme.of(context).brightness == Brightness.dark;

  return BoxDecoration(
    borderRadius: BorderRadius.circular(16),
    gradient: LinearGradient(
      colors: [
        const Color.fromARGB(255, 9, 9, 9).withOpacity(0.25),
        const Color.fromARGB(255, 0, 0, 0).withOpacity(0.15),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    boxShadow: [
      BoxShadow(
        color: const Color.fromARGB(255, 1, 1, 1).withOpacity(0.55),
        blurRadius: 1,
        offset: Offset(0, 1),
      ),
    ],
  );
}

Color getIconColor(BuildContext context) {
  final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
  return isDarkMode ? Colors.white70 : const Color(0xFF0F3460);
}

ButtonStyle getPrimaryButtonStyle(BuildContext context) {
  final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
  return ElevatedButton.styleFrom(
    backgroundColor:
        isDarkMode ? const Color(0xFF4D8AFF) : const Color(0xFF0F3460),
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  );
}
