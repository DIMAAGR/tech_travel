import 'package:flutter/material.dart';
import 'package:tech_travel/src/core/theme/app_text_style.dart';

class UntoldTextButton extends StatelessWidget {
  final TextStyle? style;
  final String title;
  final EdgeInsets? padding;
  final VoidCallback? onPressed;
  const UntoldTextButton({super.key, this.style, required this.title, required this.onPressed, this.padding});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: Text(
          title,
          style: AppTextStyle.button1,
        ),
      ),
    );
  }
}
