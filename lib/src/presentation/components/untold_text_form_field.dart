import 'package:flutter/material.dart';
import 'package:tech_travel/src/core/theme/app_colors.dart';
import 'package:tech_travel/src/core/theme/app_text_style.dart';

class UntoldTextFormField extends StatelessWidget {
  final String? hintText;
  final bool useShadow;
  final TextEditingController? controller;
  final Widget? suffix;
  final bool obscure;
  final TextInputType? keyboardType;
  const UntoldTextFormField({
    super.key,
    this.hintText,
    this.controller,
    this.suffix,
    this.useShadow = true,
    this.keyboardType,
    this.obscure = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9),
            boxShadow: useShadow
                ? [
                    const BoxShadow(
                      color: AppColors.shadow1,
                      offset: Offset(0, -6),
                      blurRadius: 15,
                    ),
                  ]
                : []),
        child: TextFormField(
          controller: controller,
          style: AppTextStyle.formField.copyWith(color: Colors.white),
          keyboardType: keyboardType,
          obscureText: obscure,
          decoration: InputDecoration(
            suffixIcon: suffix,
            filled: true,
            enabled: true,
            hintText: hintText,
            hintStyle: AppTextStyle.formField,
            fillColor: AppColors.charcoalBlue,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.mediumGrey1),
              borderRadius: BorderRadius.circular(9),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.mediumGrey1),
              borderRadius: BorderRadius.circular(9),
            ),
          ),
        ),
      ),
    );
  }
}
