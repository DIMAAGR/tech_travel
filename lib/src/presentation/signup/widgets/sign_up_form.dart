import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tech_travel/src/presentation/components/icon/untold_icon.dart';
import 'package:tech_travel/src/presentation/components/icon/untold_icon_data.dart';
import 'package:tech_travel/src/presentation/components/untold_button.dart';
import 'package:tech_travel/src/presentation/components/untold_text_form_field.dart';

class SignUpForm extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  final VoidCallback onSignupPressed;
  const SignUpForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.onSignupPressed,
  });

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool isConfirmPassObscure = true;
  bool isPassObscure = true;

  void toogleConfirmPassObscure() {
    setState(() {
      isConfirmPassObscure = !isConfirmPassObscure;
    });
  }

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
          hintText: 'email'.tr(),
          controller: widget.emailController,
          keyboardType: TextInputType.emailAddress,
          useShadow: false,
        ),
        const SizedBox(height: 16),
        UntoldTextFormField(
          hintText: 'password'.tr(),
          controller: widget.passwordController,
          obscure: isPassObscure,
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
        UntoldTextFormField(
          hintText: 'confirmPassword'.tr(),
          controller: widget.confirmPasswordController,
          obscure: isConfirmPassObscure,
          suffix: Padding(
            padding: const EdgeInsets.all(14.0),
            child: UntoldIcon(
              icon: UntoldIcons.eye_slash,
              onTap: toogleConfirmPassObscure,
              size: 16,
            ),
          ),
        ),
        const SizedBox(height: 24),
        UntoldButton(
          title: 'createAccountButton'.tr(),
          onPressed: widget.onSignupPressed,
        ),
      ],
    );
  }
}
