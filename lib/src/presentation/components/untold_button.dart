import 'package:flutter/material.dart';
import 'package:tech_travel/src/core/theme/app_colors.dart';
import 'package:tech_travel/src/core/theme/app_text_style.dart';

class UntoldButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final double? horizontalPadding;
  final bool isTransparent;
  final Size? fixedSize;
  const UntoldButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.isTransparent = false,
    this.horizontalPadding,
    this.fixedSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), boxShadow: const [
        BoxShadow(
          color: AppColors.gold1,
          blurRadius: 18.33,
          offset: Offset(0, 0),
        )
      ]),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          fixedSize: fixedSize,
          backgroundColor: isTransparent ? AppColors.purple3 : AppColors.purple2,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              color: AppColors.purple1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 16.0),
          child: Text(
            title,
            style: AppTextStyle.button1,
          ),
        ),
      ),
    );
  }
}
