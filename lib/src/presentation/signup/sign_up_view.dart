import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:tech_travel/src/core/app/app_routes.dart';
import 'package:tech_travel/src/core/errors/failure.dart';
import 'package:tech_travel/src/core/state/view_model_state.dart';
import 'package:tech_travel/src/presentation/components/untold_logo.dart';
import 'package:tech_travel/src/presentation/components/untold_apple_google_buttons.dart';
import 'package:tech_travel/src/presentation/components/untold_page_title.dart';
import 'package:tech_travel/src/presentation/components/untold_snackbar.dart';
import 'package:tech_travel/src/presentation/components/untold_view_body.dart';
import 'package:tech_travel/src/presentation/signup/sign_up_view_model.dart';
import 'package:tech_travel/src/presentation/signup/widgets/or_sign_up_with.dart';
import 'package:tech_travel/src/presentation/signup/widgets/sign_in_button.dart';
import 'package:tech_travel/src/presentation/signup/widgets/sign_up_form.dart';

class SignUpView extends StatefulWidget {
  final SignupViewModel viewModel;
  const SignUpView({super.key, required this.viewModel});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final confirmPasswordController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  late ReactionDisposer _reactionDisposer;
  @override
  void initState() {
    super.initState();
    _setupListeners();
    _setupReaction();
  }

  void _setupListeners() {
    emailController.addListener(() => widget.viewModel.setEmail(emailController.text));
    passwordController.addListener(() => widget.viewModel.setPassword(passwordController.text));
    confirmPasswordController.addListener(() => widget.viewModel.setConfirmPassword(confirmPasswordController.text));
  }

  void _setupReaction() {
    _reactionDisposer = reaction<ViewModelState>(
      (_) => widget.viewModel.signupState,
      (state) {
        if (state is ErrorState<Failure, void>) {
          UntoldSnackbar.showMessage(
            context,
            useBorder: true,
            message: state.error.message.tr(),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _reactionDisposer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UntoldViewBody(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              const SizedBox(height: 24),
              const UntoldLogo(size: 104, useAlternative: true),
              const SizedBox(height: 16),
              SignInButton(onTap: () {
                Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (_) => false);
              }),
            ],
          ),
          const SizedBox(height: 16),
          Column(
            children: [
              UntoldPageTitle(
                title: 'createAccount'.tr(),
                subtitle: 'createAccountSubtitle'.tr(),
              ),
              const SizedBox(height: 24),
              UntoldAppleGoogleButtons(
                onApplePressed: () {
                  widget.viewModel.signupWithApple();
                },
                onGooglePressed: () {
                  widget.viewModel.signupWithGoogle();
                },
              ),
              const SizedBox(height: 32),
              const OrSignUpWith(),
              const SizedBox(height: 32),
            ],
          ),
          SignUpForm(
            confirmPasswordController: confirmPasswordController,
            emailController: emailController,
            passwordController: passwordController,
            onSignupPressed: () {
              widget.viewModel.signupWithEmail();
              Navigator.pushNamed(context, AppRoutes.onboarding);
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
