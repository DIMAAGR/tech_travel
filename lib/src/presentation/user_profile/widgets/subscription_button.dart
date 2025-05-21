import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tech_travel/src/core/extensions/format_extensions.dart';
import 'package:tech_travel/src/core/theme/app_colors.dart';
import 'package:tech_travel/src/core/theme/app_text_style.dart';
import 'package:tech_travel/src/domain/entities/subscription_entity.dart';
import 'package:tech_travel/src/presentation/components/untold_logo.dart';

class SubscriptionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final SubscriptionEntity subscription;
  const SubscriptionButton({
    super.key,
    required this.onPressed,
    required this.subscription,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColors.darkGrey4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.only(
            left: 8,
            right: 24,
            top: 8,
            bottom: 8,
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 64,
                width: 64,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppColors.purple4,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const UntoldLogo(),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${'stream'.tr()} ${subscription.type.name}',
                    style: AppTextStyle.button3.copyWith(fontSize: 16, color: Colors.white),
                  ),
                  Text(
                    subscription.inscriptionDate.toShortFormatted(),
                    style: AppTextStyle.button3.copyWith(
                      color: AppColors.white40,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Text(
            subscription.expireIn.expire.capitalize,
            style: AppTextStyle.button3.copyWith(fontSize: 12),
          )
        ],
      ),
    );
  }
}
