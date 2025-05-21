import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tech_travel/src/core/theme/app_text_style.dart';
import 'package:tech_travel/src/presentation/components/untold_button.dart';
import 'package:tech_travel/src/presentation/components/untold_modal.dart';
import 'package:tech_travel/src/presentation/components/untold_text_button.dart';

class WarningModal extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onConfirm;
  final String confirmText;
  const WarningModal({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onConfirm,
    required this.confirmText,
  });

  @override
  Widget build(BuildContext context) {
    return UntoldModal(
      title: 'warning'.tr(),
      titleStyle: AppTextStyle.subtitle5.copyWith(
        fontSize: 16,
      ),
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            children: [
              Text(
                title,
                style: AppTextStyle.subtitle5,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: AppTextStyle.subtitle6,
              ),
            ],
          ),
        ),
        const SizedBox(height: 40),
        Row(
          children: [
            UntoldTextButton(
              height: 40,
              width: 176,
              title: 'Cancel',
              onPressed: () => Navigator.of(context).pop(),
            ),
            UntoldButton(
              horizontalPadding: 0,
              fixedSize: const Size(176, 40),
              title: confirmText,
              onPressed: onConfirm,
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
