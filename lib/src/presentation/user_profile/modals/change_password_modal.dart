import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tech_travel/src/core/theme/app_colors.dart';
import 'package:tech_travel/src/core/theme/app_text_style.dart';
import 'package:tech_travel/src/presentation/components/icon/untold_icon.dart';
import 'package:tech_travel/src/presentation/components/icon/untold_icon_data.dart';
import 'package:tech_travel/src/presentation/components/untold_button.dart';
import 'package:tech_travel/src/presentation/components/untold_text_form_field.dart';
import 'package:tech_travel/src/presentation/user_profile/modals/scaffold_modal.dart';

class ChangePasswordModal extends StatefulWidget {
  final TextEditingController passwordController;
  final TextEditingController newPasswordController;
  final TextEditingController confirmNewPasswordController;
  final VoidCallback onUpdatePassword;
  const ChangePasswordModal({
    super.key,
    required this.passwordController,
    required this.newPasswordController,
    required this.confirmNewPasswordController,
    required this.onUpdatePassword,
  });

  @override
  State<ChangePasswordModal> createState() => _ChangePasswordModalState();
}

class _ChangePasswordModalState extends State<ChangePasswordModal> {
  bool isPassObscure = true;
  bool isNewPassObscure = true;
  bool isConfirmPassObscure = true;

  void tooglePassObscure() {
    setState(() {
      isPassObscure = !isPassObscure;
    });
  }

  void toogleNewPassObscure() {
    setState(() {
      isNewPassObscure = !isNewPassObscure;
    });
  }

  void toogleConfirmPassObscure() {
    setState(() {
      isConfirmPassObscure = !isConfirmPassObscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldModal(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 48),
        Text(
          'changePasswordTitle'.tr(),
          style: AppTextStyle.title,
        ),
        const SizedBox(height: 64),
        UntoldTextFormField(
          padding: EdgeInsets.zero,
          controller: widget.passwordController,
          obscure: true,
          hintText: 'currentPassword'.tr(),
          suffix: Padding(
            padding: const EdgeInsets.all(14.0),
            child: UntoldIcon(
              icon: UntoldIcons.eye_slash,
              onTap: tooglePassObscure,
              size: 16,
            ),
          ),
        ),
        const SizedBox(height: 48),
        const Divider(color: AppColors.mediumGrey6),
        const SizedBox(height: 48),
        UntoldTextFormField(
          padding: EdgeInsets.zero,
          controller: widget.newPasswordController,
          obscure: true,
          hintText: 'newPassword'.tr(),
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
          padding: EdgeInsets.zero,
          controller: widget.confirmNewPasswordController,
          obscure: true,
          hintText: 'confirmNewPassword'.tr(),
          suffix: Padding(
            padding: const EdgeInsets.all(14.0),
            child: UntoldIcon(
              icon: UntoldIcons.eye_slash,
              onTap: tooglePassObscure,
              size: 16,
            ),
          ),
        ),
        const Expanded(
          child: SizedBox(height: 32),
        ),
        Align(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: UntoldButton(
              title: 'updatePassword'.tr(),
              onPressed: widget.onUpdatePassword,
            ),
          ),
        ),
      ],
    );
  }
}
