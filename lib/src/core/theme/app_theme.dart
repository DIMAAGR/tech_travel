import 'package:flutter/material.dart';
import 'package:tech_travel/src/core/theme/app_colors.dart';

abstract class AppTheme {
  static ThemeData darkTheme() {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.background,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.transparent,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
      ),
    );
  }
}
