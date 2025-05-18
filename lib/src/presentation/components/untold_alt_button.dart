import 'package:flutter/material.dart';
import 'package:tech_travel/src/core/theme/app_text_style.dart';
import 'package:tech_travel/src/presentation/components/icon/untold_icon.dart';
import 'package:tech_travel/src/presentation/components/icon/untold_icon_data.dart';

class UntoldAltButton extends StatelessWidget {
  final UntoldIconData icon;
  final Color iconColor;
  final String title;
  final Color backgroundColor;
  final Color borderColor;
  final VoidCallback onPressed;
  const UntoldAltButton({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.backgroundColor,
    required this.borderColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(32),
      onTap: onPressed,
      child: Container(
        height: 152,
        width: 152,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: borderColor),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            UntoldIcon(
              icon: icon,
              size: 28,
              color: iconColor,
            ),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyle.body2,
            )
          ],
        ),
      ),
    );
  }
}
