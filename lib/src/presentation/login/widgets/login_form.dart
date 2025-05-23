import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tech_travel/src/core/theme/app_colors.dart';
import 'package:tech_travel/src/presentation/components/icon/untold_icon.dart';
import 'package:tech_travel/src/presentation/components/icon/untold_icon_data.dart';
import 'package:tech_travel/src/presentation/components/untold_button.dart';
import 'package:tech_travel/src/presentation/components/untold_text_button.dart';
import 'package:tech_travel/src/presentation/components/untold_text_form_field.dart';

class LoginForm extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onLoginPressed;
  final VoidCallback onPasswordPressed;

  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.onLoginPressed,
    required this.onPasswordPressed,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool isPassObscure = true;

  void tooglePassObscure() {
    setState(() {
      isPassObscure = !isPassObscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UntoldTextFormField(
          controller: widget.emailController,
          useShadow: false,
          hintText: 'email'.tr(),
        ),
        const SizedBox(height: 16),
        UntoldTextFormField(
          controller: widget.passwordController,
          obscure: true,
          hintText: 'password'.tr(),
          suffix: Padding(
            padding: const EdgeInsets.all(14.0),
            child: UntoldIcon(
              icon: UntoldIcons.eye_slash,
              onTap: tooglePassObscure,
              size: 16,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 24),
              child: UntoldTextButton(
                title: 'forgotPassword'.tr(),
                textColor: AppColors.purple1,
                onPressed: widget.onPasswordPressed,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        UntoldButton(
          horizontalPadding: 56,
          title: 'login'.tr(),
          onPressed: widget.onLoginPressed,
        ),
      ],
    );
  }
}
