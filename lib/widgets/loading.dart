import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color.fromARGB(255, 38, 48, 53),
            const Color.fromARGB(255, 12, 32, 51),
          ],
        ),
      ),
      child: Center(child: CircularProgressIndicator(color: Colors.black)),
    );
  }
}
