import 'package:flutter/material.dart';
import 'package:tech_travel/src/core/theme/app_colors.dart';
import 'package:tech_travel/src/core/theme/app_text_style.dart';
import 'package:tech_travel/src/presentation/components/icon/untold_icon.dart';
import 'package:tech_travel/src/presentation/components/icon/untold_icon_data.dart';

class UntoldLargerButton extends StatelessWidget {
  final VoidCallback onPressed;
  final UntoldIconData icon;
  final String title;
  const UntoldLargerButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColors.darkGrey4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 24,
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              UntoldIcon(
                icon: icon,
                size: 20,
              ),
              const SizedBox(width: 12),
              SizedBox(
                height: 20,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    title,
                    style: AppTextStyle.body1,
                  ),
                ),
              ),
            ],
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
            size: 16,
          ),
        ],
      ),
    );
  }
}
