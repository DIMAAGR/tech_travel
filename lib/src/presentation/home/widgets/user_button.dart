import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tech_travel/src/core/theme/app_colors.dart';

class UserButton extends StatelessWidget {
  final String imageUrl;
  final VoidCallback onPressed;
  const UserButton({super.key, required this.imageUrl, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 40,
        width: 40,
        decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
        child: ClipOval(
          child: CachedNetworkImage(
            placeholder: (context, url) => const Center(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: CircularProgressIndicator(
                  strokeWidth: 1,
                  color: AppColors.purple1,
                ),
              ),
            ),
            imageUrl: imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
