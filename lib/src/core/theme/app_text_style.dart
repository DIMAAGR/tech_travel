import 'package:flutter/material.dart';
import 'package:tech_travel/src/core/theme/app_colors.dart';

abstract class AppTextStyle {
  static TextStyle formField = const TextStyle(
    color: AppColors.white40,
    fontFamily: 'Epilogue',
    fontWeight: FontWeight.w400,
    fontSize: 15,
    letterSpacing: 0.005,
  );

  static TextStyle h1 = const TextStyle(
    color: Colors.white,
    fontFamily: 'Epilogue',
    fontWeight: FontWeight.w600,
    fontSize: 24,
  );
  static TextStyle button1 = const TextStyle(
    color: AppColors.purple1,
    fontFamily: 'Epilogue',
    fontWeight: FontWeight.w600,
    letterSpacing: 0.02,
    fontSize: 14.67,
  );
  static TextStyle button2 = const TextStyle(
    color: AppColors.purple1,
    fontFamily: 'FieldWork',
    fontWeight: FontWeight.w400,
    fontSize: 13.58,
  );

  static TextStyle subtitle1 = const TextStyle(
    color: Colors.white,
    fontFamily: 'Epilogue',
    fontWeight: FontWeight.w700,
    fontSize: 13.58,
  );

  static TextStyle body2 = const TextStyle(
    color: AppColors.white40,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );

  static TextStyle action2 = const TextStyle(
    color: AppColors.purple1,
    fontFamily: 'FieldWork',
    fontWeight: FontWeight.w700,
    fontSize: 14,
  );
  static TextStyle caption1 = const TextStyle(
    color: AppColors.darkGrey1,
    fontFamily: 'Outfit',
    fontWeight: FontWeight.w500,
    fontSize: 12,
  );
  static TextStyle labelSmall = const TextStyle(
    fontFamily: 'Epilogue',
    color: Colors.white,
    fontWeight: FontWeight.w400,
    fontSize: 10,
    height: 14.67 / 10,
    letterSpacing: 0,
  );
}
