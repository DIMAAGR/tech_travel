import 'package:flutter/material.dart';
import 'package:tech_travel/src/core/theme/app_text_style.dart';

class SignUpButton extends StatelessWidget {
  final VoidCallback onTap;
  const SignUpButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Don\'t have an account? ',
          style: AppTextStyle.body2,
        ),
        GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              'Sign Up!',
              style: AppTextStyle.action2,
            ),
          ),
        ),
      ],
    );
  }
}
