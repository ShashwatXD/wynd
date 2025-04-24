import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wynd/providers/theme_provider.dart';

class ToggleModeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return AnimatedSwitcher(
      duration: Duration(milliseconds: 750),
      transitionBuilder: (child, animation) {
        return RotationTransition(turns: animation, child: child);
      },
      child: IconButton(
        key: UniqueKey(),
        icon:
            isDarkMode
                ? Icon(Icons.light_mode, color: Colors.white, size: 30)
                : Icon(Icons.dark_mode, size: 30),
        onPressed: () {
          print('button pressed');
          Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
        },
      ),
    );
  }
}
