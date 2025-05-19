import 'package:flutter/material.dart';

class AppGradients {
  static const linearOverlay = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0x33000000),
      Color(0x33000000),
    ],
  );

  static const fadeToBlack = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0x00000000),
      Color(0xE6000000),
    ],
  );

  static const midFade = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.0, 0.3405],
    colors: [
      Color(0x66000000),
      Color(0x00000000),
    ],
  );

  /// Gradient: gray to purple
  static const grayToPurple = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF7C7C7C),
      Color(0xFF4B2472),
    ],
    stops: [0.0, 1.2577],
  );
}
