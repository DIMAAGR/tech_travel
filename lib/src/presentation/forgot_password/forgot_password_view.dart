import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tech_travel/src/core/app/app_routes.dart';
import 'package:tech_travel/src/core/theme/app_text_style.dart';
import 'package:tech_travel/src/presentation/components/untold_button.dart';
import 'package:tech_travel/src/presentation/components/untold_logo.dart';
import 'package:tech_travel/src/presentation/components/untold_text_button.dart';
import 'package:tech_travel/src/presentation/components/untold_text_form_field.dart';
import 'package:tech_travel/src/presentation/components/untold_view_body.dart';
import 'package:tech_travel/src/presentation/forgot_password/forgot_password_view_model.dart';

class ForgotPasswordView extends StatefulWidget {
  final ForgotPasswordViewModel viewModel;
  const ForgotPasswordView({
    super.key,
    required this.viewModel,
  });

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  bool animate = false;
  final emailTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    emailTextController.addListener(() => widget.viewModel.setEmail(emailTextController.text));

    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        animate = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    const duration = Duration(milliseconds: 600);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const UntoldLogo(),
      ),
      body: UntoldViewBody(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 32),
          SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Positioned(
                  top: 0,
                  child: Text(
                    'forgotPassword'.tr(),
                    style: AppTextStyle.h1,
                  ),
                ),
                AnimatedPositioned(
                  top: animate ? 40 : 100,
                  duration: duration,
                  curve: Curves.easeOut,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 32, right: 32, top: 8, bottom: 48),
                      child: Text(
                        'forgotPasswordDescription'.tr(),
                        textAlign: TextAlign.center,
                        style: AppTextStyle.body2,
                      ),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  duration: duration,
                  top: animate ? 152 : 256,
                  curve: Curves.easeOut,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: UntoldTextFormField(
                      controller: emailTextController,
                      hintText: 'email'.tr(),
                      useShadow: false,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      bottomSheet: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          UntoldButton(
            title: 'sendResetInstructions'.tr(),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(context, AppRoutes.emailSend, (_) => false);
            },
          ),
          const SizedBox(height: 8),
          UntoldTextButton(
            title: 'back'.tr(),
            height: 40,
            width: 192,
            onPressed: () => Navigator.pop(context),
          ),
          const SizedBox(height: 32)
        ],
      ),
    );
  }
}
