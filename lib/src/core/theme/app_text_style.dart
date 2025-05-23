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

  static TextStyle h2 = const TextStyle(
    fontFamily: 'FieldWork',
    fontWeight: FontWeight.w700,
    fontSize: 21,
    color: Colors.white,
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

  static const TextStyle button3 = TextStyle(
    fontFamily: 'Epilogue',
    fontWeight: FontWeight.w500,
    color: AppColors.purple1,
    fontSize: 14,
    height: 1.53,
    letterSpacing: -0.05,
  );

  static TextStyle subtitle1 = const TextStyle(
    color: Colors.white,
    fontFamily: 'Epilogue',
    fontWeight: FontWeight.w700,
    fontSize: 13.58,
  );

  static TextStyle subtitle2 = const TextStyle(
    color: AppColors.lightGrey1,
    fontFamily: 'Epilogue',
    fontWeight: FontWeight.w600,
    fontSize: 14,
    letterSpacing: 0.05,
  );

  static TextStyle subtitle3 = const TextStyle(
    color: AppColors.lightGrey2,
    fontFamily: 'Epilogue',
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 1.62,
    letterSpacing: 0.045,
  );
  static TextStyle subtitle4 = const TextStyle(
    color: Colors.white,
    fontFamily: 'Epilogue',
    fontWeight: FontWeight.w600,
    fontSize: 18,
    height: 1.0,
    letterSpacing: 0.045,
  );
  static TextStyle subtitle7 = const TextStyle(
    color: Colors.white,
    fontFamily: 'Epilogue',
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 1.0,
    letterSpacing: 0.05,
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
  static TextStyle caption2 = const TextStyle(
    color: AppColors.lightGrey2,
    fontFamily: 'Epilogue',
    fontWeight: FontWeight.w600,
    fontSize: 12,
    letterSpacing: 0.05,
  );
  static TextStyle labelSmall = const TextStyle(
    fontFamily: 'Epilogue',
    color: Colors.white,
    fontWeight: FontWeight.w400,
    fontSize: 10,
    height: 1.467,
    letterSpacing: 0,
  );

  static const TextStyle labelSmall3 = TextStyle(
    fontFamily: 'Epilogue',
    fontWeight: FontWeight.w500,
    color: AppColors.white40,
    fontSize: 12,
    height: 1.0,
    letterSpacing: 0.24,
  );

  static const TextStyle labelMedium = TextStyle(
    fontFamily: 'Epilogue',
    color: AppColors.purple1,
    fontWeight: FontWeight.w600,
    fontSize: 14,
    height: 1.0,
    letterSpacing: 0.28,
  );

  static const TextStyle title = TextStyle(
    fontFamily: 'Epilogue',
    fontWeight: FontWeight.w700,
    color: Colors.white,
    fontSize: 26,
    height: 1.53,
    letterSpacing: -0.05,
  );

  static const TextStyle body1 = TextStyle(
    fontFamily: 'Epilogue',
    color: Colors.white,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 1.0,
    letterSpacing: 0,
  );

  static const subtitle5 = TextStyle(
    fontFamily: 'Epilogue',
    color: Colors.white,
    fontWeight: FontWeight.w700,
    fontSize: 14,
    height: 1.0,
    letterSpacing: 0.28,
  );

  static const subtitle6 = TextStyle(
    fontFamily: 'Epilogue',
    color: Colors.white,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 1.0,
    letterSpacing: 0.28,
  );

  static const TextStyle subscriptionPlanTitle = TextStyle(
    fontFamily: 'Epilogue',
    color: Colors.white,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 1.0,
    letterSpacing: 0.05,
  );

  static const TextStyle subscriptionPlanValue = TextStyle(
    fontFamily: 'Epilogue',
    color: Colors.white,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    height: 1.0,
    letterSpacing: 0.05,
  );

// font-family: Epilogue;
// font-weight: 600;
// font-size: 18px;
// line-height: 153%;
// letter-spacing: -0.5%;

  static const TextStyle videoTitle = TextStyle(
    fontFamily: 'Epilogue',
    color: Colors.white,
    fontWeight: FontWeight.w600,
    fontSize: 18,
    height: 1.53,
    letterSpacing: -0.5,
  );

// font-family: Epilogue;
// font-weight: 500;
// font-size: 12px;
// line-height: 100%;
// letter-spacing: 0.5%;

  static const TextStyle videoSubtitle = TextStyle(
    fontFamily: 'Epilogue',
    color: Colors.white,
    fontWeight: FontWeight.w500,
    fontSize: 12,
    height: 1.0,
    letterSpacing: 0.5,
  );

// font-family: Epilogue;
// font-weight: 600;
// font-size: 17.29px;
// line-height: 153%;
// letter-spacing: -0.5%;
  static const TextStyle videoTime = TextStyle(
    fontFamily: 'Epilogue',
    color: Colors.white,
    fontWeight: FontWeight.w600,
    fontSize: 17.29,
    height: 1.53,
    letterSpacing: -0.5,
  );

// font-family: Epilogue;
// font-weight: 600;
// font-size: 16px;
// line-height: 153%;
// letter-spacing: -0.5%;
  static const TextStyle videoSubtitlesTitle = TextStyle(
    fontFamily: 'Epilogue',
    color: Colors.white,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    height: 1.53,
    letterSpacing: -0.5,
  );

// font-family: Epilogue;
// font-weight: 500;
// font-size: 14px;
// line-height: 100%;
// letter-spacing: 0%;
// text-align: center;
// vertical-align: middle;
  static const TextStyle videoSubtitlesButton = TextStyle(
    fontFamily: 'Epilogue',
    color: AppColors.white40,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 1.0,
    letterSpacing: 0,
  );

// font-family: Epilogue;
// font-weight: 700;
// font-size: 14.35px;
// line-height: 153%;
// letter-spacing: -0.5%;
  static const TextStyle commentsTitle = TextStyle(
    fontFamily: 'Epilogue',
    color: Colors.white,
    fontWeight: FontWeight.w700,
    fontSize: 14.35,
    height: 1.53,
    letterSpacing: -0.5,
  );

// font-family: Epilogue;
// font-weight: 500;
// font-size: 10.76px;
// line-height: 153%;
// letter-spacing: -0.5%;
  static const TextStyle commentsDate = TextStyle(
    fontFamily: 'Epilogue',
    color: AppColors.grey,
    fontWeight: FontWeight.w500,
    fontSize: 10.76,
    height: 1.53,
    letterSpacing: -0.5,
  );

// font-family: Epilogue;
// font-weight: 400;
// font-size: 12.88px;
// line-height: 120%;
// letter-spacing: -0.5%;
  static const TextStyle commentsBody = TextStyle(
    fontFamily: 'Epilogue',
    color: Colors.white,
    fontWeight: FontWeight.w400,
    fontSize: 12.88,
    height: 1.2,
    letterSpacing: -0.5,
  );

// font-family: Epilogue;
// font-weight: 500;
// font-size: 12.55px;
// line-height: 153%;
// letter-spacing: -0.5%;
  static const TextStyle replyTitle = TextStyle(
    fontFamily: 'Epilogue',
    color: AppColors.purple1,
    fontWeight: FontWeight.w500,
    fontSize: 12.55,
    height: 1.53,
    letterSpacing: -0.5,
  );

// font-family: Epilogue;
// font-weight: 600;
// font-size: 12.55px;
// line-height: 153%;
// letter-spacing: -0.5%;
  static const TextStyle replyButton = TextStyle(
    fontFamily: 'Epilogue',
    color: AppColors.grey2,
    fontWeight: FontWeight.w600,
    fontSize: 12.55,
    height: 1.53,
    letterSpacing: -0.5,
  );

// font-family: Epilogue;
// font-weight: 700;
// font-size: 14px;
// line-height: 153%;
// letter-spacing: -0.5%;
// text-align: center;
  static const TextStyle commentsEditTitle = TextStyle(
    fontFamily: 'Epilogue',
    color: Colors.white,
    fontWeight: FontWeight.w700,
    fontSize: 14,
    height: 1.53,
    letterSpacing: -0.5,
  );

// font-family: Roboto;
// font-weight: 500;
// font-size: 13.66px;
// line-height: 18.21px;
// letter-spacing: 0%;
// vertical-align: middle;

  static const TextStyle commentsEditButtons = TextStyle(
    fontFamily: 'Epilogue',
    color: Colors.white,
    fontWeight: FontWeight.w500,
    fontSize: 13.66,
    height: 1.33,
    letterSpacing: 0,
  );
}
