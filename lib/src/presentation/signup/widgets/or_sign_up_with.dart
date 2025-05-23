import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tech_travel/src/core/theme/app_colors.dart';
import 'package:tech_travel/src/core/theme/app_text_style.dart';

class OrSignUpWith extends StatelessWidget {
  const OrSignUpWith({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        children: [
          const Expanded(
              child: Divider(
            color: AppColors.darkGrey2,
          )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'orSignUpWith'.tr(),
              style: AppTextStyle.caption1,
            ),
          ),
          const Expanded(
              child: Divider(
            color: AppColors.darkGrey2,
          )),
        ],
      ),
    );
  }
}
