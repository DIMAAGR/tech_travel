import 'package:flutter/material.dart';
import 'package:tech_travel/src/core/theme/app_colors.dart';

class UntoldBackButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final double? size;
  const UntoldBackButton({super.key, this.onPressed, this.size});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed ?? () => Navigator.pop(context),
      child: Icon(
        Icons.arrow_back_ios_outlined,
        size: size ?? 32,
        color: AppColors.purple1,
      ),
    );
  }
}
