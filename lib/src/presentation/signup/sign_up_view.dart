import 'package:flutter/material.dart';
import 'package:tech_travel/src/core/theme/app_text_style.dart';
import 'package:tech_travel/src/presentation/components/untold_logo.dart';
import 'package:tech_travel/src/presentation/components/untold_apple_google_buttons.dart';
import 'package:tech_travel/src/presentation/signup/widgets/or_login_with.dart';
import 'package:tech_travel/src/presentation/signup/widgets/sign_in_button.dart';
import 'package:tech_travel/src/presentation/signup/widgets/sign_up_form.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          const SizedBox(height: 24),
                          const UntoldLogo(size: 104, useAlternative: true),
                          const SizedBox(height: 16),
                          SignInButton(onTap: () {}),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Column(
                        children: [
                          Text(
                            'Create an account',
                            style: AppTextStyle.h1,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'To get started, please complete your account registration.',
                            textAlign: TextAlign.center,
                            style: AppTextStyle.body2,
                          ),
                          const SizedBox(height: 24),
                          UntoldAppleGoogleButtons(
                            onApplePressed: () {},
                            onGooglePressed: () {},
                          ),
                          const SizedBox(height: 32),
                          const OrLoginWith(),
                          const SizedBox(height: 32),
                        ],
                      ),
                      SignUpForm(
                        confirmPasswordController: TextEditingController(),
                        emailController: TextEditingController(),
                        passwordController: TextEditingController(),
                        onSignupPressed: () {},
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
