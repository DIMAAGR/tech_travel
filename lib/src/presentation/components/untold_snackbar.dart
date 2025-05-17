import 'package:flutter/material.dart';
import 'package:tech_travel/src/core/theme/app_colors.dart';
import 'package:tech_travel/src/core/theme/app_text_style.dart';
import 'package:tech_travel/src/presentation/components/untold_logo.dart';
import 'package:tech_travel/src/presentation/components/untold_text_button.dart';

abstract class UntoldSnackbar {
  static void showMessage(
    BuildContext context, {
    required String message,
    bool useBorder = false,
    VoidCallback? onPressed,
    double? leftPadding,
  }) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          padding: EdgeInsets.zero,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 150,
          ),
          duration: const Duration(seconds: 3),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: useBorder ? const BorderSide(color: AppColors.darkGrey2) : BorderSide.none,
                ),
                color: AppColors.mediumGreyDark,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const UntoldLogo(size: 24),
                      const SizedBox(width: 16),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: onPressed != null ? MediaQuery.of(context).size.width - 170 : MediaQuery.of(context).size.width - 96,
                        ),
                        child: Text(
                          message,
                          style: AppTextStyle.snackbar,
                          maxLines: 2,
                        ),
                      ),
                      if (onPressed != null)
                        UntoldTextButton(
                          title: 'Try again',
                          onPressed: onPressed,
                          style: AppTextStyle.button2,
                          padding: EdgeInsets.only(left: leftPadding ?? 8),
                        )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
