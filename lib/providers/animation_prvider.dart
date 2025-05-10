import 'package:flutter/material.dart';
// animation_provider.dart

class AnimationProvider with ChangeNotifier {
  bool _isAnimating = false;
  Offset? _tapPosition;
  double _animationValue = 0.0;
  late TickerProvider _vsync;
  late AnimationController _controller;

  bool get isAnimating => _isAnimating;
  Offset? get tapPosition => _tapPosition;
  double get animationValue => _animationValue;

  void setVsync(TickerProvider vsync) {
    _vsync = vsync;
    _controller = AnimationController(
      vsync: _vsync,
      duration: const Duration(milliseconds: 600),
    )..addListener(() {
      _animationValue = _controller.value;
      notifyListeners();
    });
  }

  void startAnimation(Offset position) {
    _tapPosition = position;
    _isAnimating = true;
    _controller.forward(from: 0);
    notifyListeners();
  }

  void completeAnimation() {
    _isAnimating = false;
    _controller.reset();
    notifyListeners();
  }

  void disposeAnimation() {
    _controller.dispose();
  }
}
