import 'package:flutter/material.dart';
import 'package:tech_travel/src/core/theme/app_colors.dart';

class UntoldBackButton extends StatelessWidget {
  final VoidCallback? onPressed;
  const UntoldBackButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed ?? () => Navigator.pop(context),
      child: const Icon(
        Icons.arrow_back_ios_outlined,
        size: 32,
        color: AppColors.purple1,
      ),
    );
  }
}
