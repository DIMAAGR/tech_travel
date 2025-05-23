import 'package:flutter/material.dart';
import 'package:tech_travel/src/presentation/components/icon/untold_icon.dart';
import 'package:tech_travel/src/presentation/components/icon/untold_icon_data.dart';

class UntoldAppleGoogleButtons extends StatelessWidget {
  final VoidCallback onApplePressed;
  final VoidCallback onGooglePressed;
  const UntoldAppleGoogleButtons({
    super.key,
    required this.onApplePressed,
    required this.onGooglePressed,
  });

  @override
  Widget build(BuildContext context) {
    double size = 72;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        UntoldIcon(
          icon: UntoldIcons.google_button,
          onTap: onGooglePressed,
          size: size,
        ),
        const SizedBox(width: 24),
        UntoldIcon(
          icon: UntoldIcons.apple_button,
          onTap: onApplePressed,
          size: size,
        ),
      ],
    );
  }
}
