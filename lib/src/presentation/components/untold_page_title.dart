import 'package:flutter/material.dart';
import 'package:tech_travel/src/core/theme/app_text_style.dart';

class UntoldPageTitle extends StatelessWidget {
  final String title;
  final String subtitle;
  final TextAlign subtitleAlign;
  final EdgeInsetsGeometry? padding;

  const UntoldPageTitle({
    super.key,
    required this.title,
    required this.subtitle,
    this.subtitleAlign = TextAlign.center,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: AppTextStyle.h1,
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            textAlign: subtitleAlign,
            style: AppTextStyle.body2,
          ),
        ],
      ),
    );
  }
}
