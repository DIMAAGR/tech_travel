import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tech_travel/src/core/extensions/format_extensions.dart';
import 'package:tech_travel/src/core/theme/app_colors.dart';
import 'package:tech_travel/src/core/theme/app_text_style.dart';
import 'package:tech_travel/src/domain/entities/comments_entity.dart';
import 'package:tech_travel/src/domain/entities/movie_entity.dart';
import 'package:tech_travel/src/presentation/components/icon/untold_icon_data.dart';
import 'package:tech_travel/src/presentation/components/untold_button.dart';
import 'package:tech_travel/src/presentation/home/widgets/icon_button_with_subtitle.dart';

class VideoCardContent extends StatelessWidget {
  final DatumEntity? movieEntity;
  final CommentsEntity? commentsEntity;
  final bool isLoading;
  final VoidCallback onSharePressed;
  final VoidCallback onLikePressed;
  final VoidCallback onWatchPressed;
  final int totalComments;
  const VideoCardContent({
    super.key,
    this.movieEntity,
    this.isLoading = false,
    required this.onSharePressed,
    required this.onLikePressed,
    required this.onWatchPressed,
    this.commentsEntity,
    required this.totalComments,
  });

  Widget _loadingShimmer({required double height, required double width}) {
    return Shimmer.fromColors(
      baseColor: Colors.white54,
      highlightColor: Colors.white12,
      direction: ShimmerDirection.ltr,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return commentsEntity != null && movieEntity != null && !isLoading
        ? Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(movieEntity!.attributes!.genre!, style: AppTextStyle.subtitle2),
                    const SizedBox(height: 4),
                    Text(movieEntity!.attributes!.name!, style: AppTextStyle.h1.copyWith(fontSize: 32)),
                    const SizedBox(height: 4),
                    SizedBox(
                      width: screenWidth - 100,
                      child: Text(movieEntity!.attributes!.synopsis!, style: AppTextStyle.subtitle3),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Comments ${totalComments.toThousands()}',
                      style: AppTextStyle.caption2,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          height: 24,
                          width: 24,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.lightGrey3,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            commentsEntity?.comment ?? '',
                            style: AppTextStyle.subtitle3.copyWith(fontSize: 12),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Center(
                      child: UntoldButton(
                        title: 'Watch',
                        onPressed: onWatchPressed,
                        horizontalPadding: 56,
                        isTransparent: true,
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
              const Divider(color: AppColors.lightGrey3, height: 1),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButtonWithSubtitle(
                          subtitle: 'Rate',
                          onPressed: onLikePressed,
                          icon: UntoldIcons.like_disabled,
                        ),
                        const SizedBox(width: 16),
                        IconButtonWithSubtitle(
                          subtitle: 'Gift to someone?',
                          onPressed: onSharePressed,
                          icon: UntoldIcons.share,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text('Available until', style: AppTextStyle.labelSmall3),
                        const SizedBox(height: 4),
                        Text(movieEntity!.attributes!.publishedAt!.toShortFormatted(), style: AppTextStyle.labelMedium),
                      ],
                    )
                  ],
                ),
              )
            ],
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _loadingShimmer(height: 12, width: 96),
                    const SizedBox(height: 16),
                    _loadingShimmer(height: 40, width: 144),
                    const SizedBox(height: 16),
                    _loadingShimmer(height: 16, width: screenWidth - 128),
                    const SizedBox(height: 6),
                    _loadingShimmer(height: 16, width: screenWidth - 128),
                    const SizedBox(height: 6),
                    _loadingShimmer(height: 16, width: screenWidth - 128),
                    const SizedBox(height: 6),
                    _loadingShimmer(height: 16, width: screenWidth - 128),
                    const SizedBox(height: 6),
                    _loadingShimmer(height: 16, width: screenWidth - 128),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        _loadingShimmer(height: 12, width: 96),
                        const SizedBox(width: 4),
                        _loadingShimmer(height: 12, width: 48),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        _loadingShimmer(height: 24, width: 24),
                        const SizedBox(width: 4),
                        _loadingShimmer(height: 12, width: screenWidth - 156),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Center(
                          child: SvgPicture.asset(
                            'assets/svgs/ticket.svg',
                            width: screenWidth - 120,
                          ),
                        ),
                        Positioned(
                          left: 36,
                          child: _loadingShimmer(height: 24, width: 24),
                        ),
                        Positioned(
                          right: 36,
                          child: _loadingShimmer(height: 16, width: screenWidth - 212),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Divider(color: AppColors.lightGrey3, height: 1),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Column(
                          children: [
                            _loadingShimmer(height: 24, width: 24),
                            const SizedBox(height: 8),
                            _loadingShimmer(height: 10, width: 32),
                          ],
                        ),
                        const SizedBox(width: 16),
                        Column(
                          children: [
                            _loadingShimmer(height: 24, width: 24),
                            const SizedBox(height: 8),
                            _loadingShimmer(height: 10, width: 64),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _loadingShimmer(height: 12, width: 96),
                        const SizedBox(height: 4),
                        _loadingShimmer(height: 12, width: 72),
                      ],
                    )
                  ],
                ),
              )
            ],
          );
  }
}
