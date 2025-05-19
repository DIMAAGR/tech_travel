import 'package:flutter/material.dart';
import 'package:tech_travel/src/core/theme/app_text_style.dart';
import 'package:tech_travel/src/presentation/components/icon/untold_icon.dart';
import 'package:tech_travel/src/presentation/components/icon/untold_icon_data.dart';

class IconButtonWithSubtitle extends StatelessWidget {
  final String subtitle;
  final VoidCallback onPressed;
  final UntoldIconData icon;
  const IconButtonWithSubtitle({
    super.key,
    required this.subtitle,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          UntoldIcon(icon: icon, size: 24),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: AppTextStyle.labelSmall.copyWith(height: 0),
          )
        ],
      ),
    );
  }
}
