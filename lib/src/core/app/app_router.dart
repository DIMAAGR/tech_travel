import 'package:flutter/material.dart';
import 'package:tech_travel/src/core/app/app_routes.dart';
import 'package:tech_travel/src/core/di/injector.dart';
import 'package:tech_travel/src/presentation/forgot_password/forgot_password_view.dart';
import 'package:tech_travel/src/presentation/forgot_password/instructions_sent_view.dart';
import 'package:tech_travel/src/presentation/home/home_view.dart';
import 'package:tech_travel/src/presentation/login/login_view.dart';
import 'package:tech_travel/src/presentation/onboarding/onboarding_view.dart';
import 'package:tech_travel/src/presentation/signup/sign_up_view.dart';
import 'package:tech_travel/src/presentation/user_profile/user_profile_view.dart';

class AppRouter {
  Map<String, Widget Function(BuildContext)> call() {
    return {
      AppRoutes.mainRoute: (context) => SignUpView(viewModel: getIt()),
      AppRoutes.onboarding: (context) => OnboardingView(viewModel: getIt()),
      AppRoutes.login: (context) => LoginView(viewModel: getIt()),
      AppRoutes.forgotPassword: (context) => ForgotPasswordView(viewModel: getIt()),
      AppRoutes.emailSend: (context) => const InstructionsSentView(),
      AppRoutes.home: (context) => HomeView(viewModel: getIt()),
      AppRoutes.profile: (context) => UserProfileView(viewModel: getIt()),
    };
  }
}
