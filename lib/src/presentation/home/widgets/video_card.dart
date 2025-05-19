import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tech_travel/src/core/theme/app_colors.dart';
import 'package:tech_travel/src/core/theme/app_gradients.dart';
import 'package:tech_travel/src/domain/entities/movie_entity.dart';
import 'package:tech_travel/src/presentation/home/widgets/plain_video_background.dart';
import 'package:tech_travel/src/presentation/home/widgets/rating_dialog.dart';
import 'package:tech_travel/src/presentation/home/widgets/video_card_content.dart';

class VideoCard extends StatefulWidget {
  final MovieEntity? entity;
  const VideoCard({super.key, this.entity});

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  bool showRatingBalloon = false;
  LikeType likeType = LikeType.none;

  void toggleBalloon() {
    setState(() => showRatingBalloon = !showRatingBalloon);
  }

  void setLike(LikeType type) => setState(() => likeType = type);

  @override
  Widget build(BuildContext context) {
    if (widget.entity == null) return const SizedBox();

    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.mediumGrey5),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: AppGradients.grayToPurple,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Stack(
            children: [
              PlainVideoBackground(videoUrl: widget.entity!.trailerUrl),
              VideoCardContent(
                movieEntity: widget.entity,
                onSharePressed: () {
                  SharePlus.instance.share(ShareParams(text: 'Check out this movie: ${widget.entity!.shareLink}'));
                },
                onLikePressed: toggleBalloon,
                onWatchPressed: () {},
              ),
              if (showRatingBalloon)
                Positioned(
                  bottom: 64,
                  left: 0,
                  right: 24,
                  child: RatingBalloon(
                    likeType: likeType,
                    onClose: toggleBalloon,
                    onPressed: setLike,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
