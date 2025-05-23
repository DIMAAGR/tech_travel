import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tech_travel/src/core/theme/app_colors.dart';
import 'package:tech_travel/src/core/theme/app_text_style.dart';

class UserProfileHeader extends StatelessWidget {
  final String imageUrl;
  final String username;
  const UserProfileHeader({super.key, required this.imageUrl, required this.username});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 144,
          width: 144,
          decoration: const BoxDecoration(
            color: AppColors.mediumGrey3,
            shape: BoxShape.circle,
          ),
          child: ClipOval(
            child: CachedNetworkImage(
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(
                  color: AppColors.purple2,
                ),
              ),
              imageUrl: imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 24),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${'hello'.tr()}, ',
              style: AppTextStyle.button3.copyWith(
                color: Colors.white,
              ),
            ),
            Text(
              username,
              style: AppTextStyle.title,
            )
          ],
        )
      ],
    );
  }
}
