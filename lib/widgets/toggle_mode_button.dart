import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wynd/providers/theme_provider.dart';

class ToggleModeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon:
          Provider.of<ThemeProvider>(context).isDarkMode
              ? Icon(Icons.light_mode, color: Colors.white)
              : Icon(Icons.dark_mode),
      onPressed: () {
        Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
      },
    );
  }
}
