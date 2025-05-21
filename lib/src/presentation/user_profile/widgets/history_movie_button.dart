import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tech_travel/src/core/theme/app_colors.dart';
import 'package:tech_travel/src/core/theme/app_gradients.dart';
import 'package:tech_travel/src/core/theme/app_text_style.dart';

class HistoryMovieButton extends StatelessWidget {
  final String imageUrl;
  final String movieName;
  final DateTime movieYear;
  final VoidCallback onPressed;
  const HistoryMovieButton({
    super.key,
    required this.imageUrl,
    required this.movieName,
    required this.movieYear,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 112,
      width: (MediaQuery.of(context).size.width / 2) - 32,
      decoration: BoxDecoration(
        color: AppColors.mediumGrey3,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          ...AppGradients.layeredBlackOverlay.map(
            (gradient) => Container(
              decoration: BoxDecoration(
                gradient: gradient,
                borderRadius: BorderRadius.circular(24),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    movieName.length <= 6 ? movieName : '${movieName.substring(0, 5)}...',
                    style: AppTextStyle.button3.copyWith(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 4,
                    height: 4,
                    decoration: const BoxDecoration(
                      color: AppColors.lightGrey3,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    movieYear.year.toString(),
                    style: AppTextStyle.button3.copyWith(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
