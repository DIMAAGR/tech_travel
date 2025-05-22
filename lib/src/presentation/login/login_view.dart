import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:tech_travel/src/core/app/app_routes.dart';
import 'package:tech_travel/src/core/errors/failure.dart';
import 'package:tech_travel/src/core/state/view_model_state.dart';
import 'package:tech_travel/src/presentation/components/untold_apple_google_buttons.dart';
import 'package:tech_travel/src/presentation/components/untold_loading.dart';
import 'package:tech_travel/src/presentation/components/untold_logo.dart';
import 'package:tech_travel/src/presentation/components/untold_page_title.dart';
import 'package:tech_travel/src/presentation/components/untold_snackbar.dart';
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
  UntoldLoading untoldLoading = UntoldLoading();

  late ReactionDisposer _loginReactionDisposer;
  @override
  void initState() {
    _initReacionDisposer();
    emailTextController.addListener(() => widget.viewModel.setEmail(emailTextController.text));
    passwordTextController.addListener(() => widget.viewModel.setPassword(passwordTextController.text));

    super.initState();
  }

  _initReacionDisposer() {
    _loginReactionDisposer = reaction<ViewModelState>(
      (_) => widget.viewModel.loginState,
      (state) {
        if (state is ErrorState<Failure, void>) {
          untoldLoading.hideLoadingPage(context);
          UntoldSnackbar.showMessage(
            context,
            useBorder: true,
            message: state.error.message.tr(),
          );
        } else if (state is LoadingState) {
          untoldLoading.showLoadingPage(context);
        } else if (state is SuccessState) {
          untoldLoading.hideLoadingPage(context);
          Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (_) => false);
        }
      },
    );
  }

  @override
  void dispose() {
    _loginReactionDisposer();
    super.dispose();
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
          const SizedBox(height: 24),
          LoginForm(
            emailController: emailTextController,
            passwordController: passwordTextController,
            onLoginPressed: () {
              widget.viewModel.loginWithEmail();
            },
            onPasswordPressed: () {
              Navigator.pushNamed(context, AppRoutes.forgotPassword);
            },
          ),
          Column(
            children: [
              const SizedBox(height: 24),
              const OrLoginWith(),
              const SizedBox(height: 24),
              UntoldAppleGoogleButtons(
                onApplePressed: () {
                  widget.viewModel.loginWithApple();
                },
                onGooglePressed: () {
                  widget.viewModel.loginWithGoogle();
                },
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
