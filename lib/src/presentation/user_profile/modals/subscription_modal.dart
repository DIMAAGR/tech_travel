import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tech_travel/src/core/theme/app_colors.dart';
import 'package:tech_travel/src/core/theme/app_text_style.dart';
import 'package:tech_travel/src/presentation/components/untold_button.dart';
import 'package:tech_travel/src/presentation/components/untold_logo.dart';
import 'package:tech_travel/src/presentation/components/untold_modal.dart';
import 'package:tech_travel/src/presentation/user_profile/modals/warning_modal.dart';

class SubscriptionModal extends StatelessWidget {
  final VoidCallback onConfirm;
  const SubscriptionModal({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.80,
      ),
      child: UntoldModal(
        title: 'subscription'.tr(),
        children: [
          const UntoldLogo(size: 104, useAlternative: true),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _ListSubtitle(
                  content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                ),
                _ListSubtitle(
                  content: 'Lorem ipsum dolor sit amet',
                ),
                _ListSubtitle(
                  content: '4K+ Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                ),
                _ListSubtitle(
                  content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                ),
                _ListSubtitle(
                  content: 'Lorem ipsum dolor sit amet',
                ),
                _ListSubtitle(
                  content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                ),
              ],
            ),
          ),
          const Expanded(child: SizedBox()),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Divider(color: AppColors.mediumGrey6),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'planRenewal'.tr(),
                      style: AppTextStyle.subtitle5,
                    ),
                    const Text(
                      'Dec 12, 2023',
                      style: AppTextStyle.subtitle5,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Divider(color: AppColors.mediumGrey6),
                const SizedBox(height: 24),
                Align(
                  child: UntoldButton(
                      title: 'terminatePlan'.tr(),
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return WarningModal(
                                title: 'cancelPlanConfirmTitle'.tr(),
                                subtitle: 'cancelPlanConfirmDescription'.tr(),
                                confirmText: 'terminatePlan'.tr(),
                                onConfirm: onConfirm,
                              );
                            });
                      }),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ListSubtitle extends StatelessWidget {
  final String content;
  const _ListSubtitle({
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.done,
            size: 18,
            color: AppColors.purple1,
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: MediaQuery.of(context).size.width - 104,
            child: Text(
              content,
              style: AppTextStyle.subtitle7,
              maxLines: 3,
            ),
          ),
        ],
      ),
    );
  }
}
