import 'package:flutter/material.dart';
import 'package:tech_travel/src/core/theme/app_text_style.dart';

class UntoldTextButton extends StatelessWidget {
  final TextStyle? style;
  final String title;
  final EdgeInsets? padding;
  final VoidCallback? onPressed;
  final Color? textColor;
  final double? height;
  final double? width;
  const UntoldTextButton({
    super.key,
    this.style,
    required this.title,
    required this.onPressed,
    this.padding,
    this.height,
    this.width,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(9),
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: SizedBox(
          height: height,
          width: width,
          child: Center(
            child: Text(
              title,
              style: AppTextStyle.button1.copyWith(color: textColor),
            ),
          ),
        ),
      ),
    );
  }
}
