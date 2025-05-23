import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tech_travel/src/core/theme/app_colors.dart';
import 'package:tech_travel/src/core/theme/app_text_style.dart';

class EditProfileButton extends StatelessWidget {
  final VoidCallback onPressed;
  const EditProfileButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          side: const BorderSide(
            width: 0.5,
            color: AppColors.purple3,
          )),
      child: Text(
        'editProfile'.tr(),
        style: AppTextStyle.button3,
      ),
    );
  }
}
