import 'package:flutter/material.dart';
import 'package:tech_travel/src/core/theme/app_colors.dart';

class UntoldLoading {
  bool isLoading = false;

  void showLoadingPage(BuildContext context) {
    isLoading = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Dialog(
          backgroundColor: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 64,
                width: 64,
                child: CircularProgressIndicator(
                  color: AppColors.purple1,
                  strokeWidth: 4.0,
                  value: null,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  void hideLoadingPage(BuildContext context) {
    if (isLoading) {
      isLoading = false;
      Navigator.of(context).pop();
    }
  }
}
