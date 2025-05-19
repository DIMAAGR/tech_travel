import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
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
          '${'dontHaveAccount'.tr()} ',
          style: AppTextStyle.body2,
        ),
        GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.only(
              top: Platform.isAndroid ? 4.0 : 0,
              bottom: Platform.isAndroid ? 0 : 2,
            ),
            child: Text(
              'signUp'.tr(),
              style: AppTextStyle.action2,
            ),
          ),
        ),
      ],
    );
  }
}
