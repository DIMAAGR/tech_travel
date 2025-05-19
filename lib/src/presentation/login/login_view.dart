import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tech_travel/src/core/app/app_routes.dart';
import 'package:tech_travel/src/presentation/components/untold_apple_google_buttons.dart';
import 'package:tech_travel/src/presentation/components/untold_logo.dart';
import 'package:tech_travel/src/presentation/components/untold_page_title.dart';
import 'package:tech_travel/src/presentation/components/untold_view_body.dart';
import 'package:tech_travel/src/presentation/login/login_view_model.dart';
import 'package:tech_travel/src/presentation/login/widgets/login_form.dart';
import 'package:tech_travel/src/presentation/login/widgets/or_login_with.dart';
import 'package:tech_travel/src/presentation/login/widgets/sign_up_button.dart';

class LoginView extends StatefulWidget {
  final LoginViewModel viewModel;
  const LoginView({
    super.key,
    required this.viewModel,
  });

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  @override
  void initState() {
    emailTextController.addListener(() => widget.viewModel.setEmail(emailTextController.text));
    passwordTextController.addListener(() => widget.viewModel.setPassword(passwordTextController.text));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const UntoldLogo(),
      ),
      body: UntoldViewBody(
        children: [
          UntoldPageTitle(
            title: 'welcomeBack'.tr(),
            subtitle: 'welcomeBackSubtitle'.tr(),
          ),
          LoginForm(
            emailController: emailTextController,
            passwordController: passwordTextController,
            onLoginPressed: () {
              Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (_) => false);
            },
            onPasswordPressed: () {
              Navigator.pushNamed(context, AppRoutes.forgotPassword);
            },
          ),
          Column(
            children: [
              const OrLoginWith(),
              const SizedBox(height: 24),
              UntoldAppleGoogleButtons(
                onApplePressed: () {},
                onGooglePressed: () {},
              ),
              const SizedBox(height: 24),
              SignUpButton(
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(context, AppRoutes.mainRoute, (_) => false);
                },
              ),
              const SizedBox(height: 32),
            ],
          )
        ],
      ),
    );
  }
}
