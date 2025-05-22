import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tech_travel/src/core/theme/app_colors.dart';
import 'package:tech_travel/src/core/theme/app_gradients.dart';
import 'package:tech_travel/src/domain/entities/comments_entity.dart';
import 'package:tech_travel/src/domain/entities/movie_entity.dart';
import 'package:tech_travel/src/presentation/home/widgets/plain_thumb_background.dart';
import 'package:tech_travel/src/presentation/home/widgets/rating_dialog.dart';
import 'package:tech_travel/src/presentation/home/widgets/video_card_content.dart';

class VideoCard extends StatefulWidget {
  final DatumEntity? entity;
  final CommentsEntity? commentsEntity;
  final VoidCallback onWatchPressed;
  final int totalComments;
  final bool isLiked;
  final Future<void> Function(LikeType like) onLikePressed;
  const VideoCard({
    super.key,
    this.entity,
    required this.onWatchPressed,
    required this.onLikePressed,
    this.commentsEntity,
    required this.totalComments,
    required this.isLiked,
  });

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  bool showRatingBalloon = false;
  LikeType likeType = LikeType.none;

  void toggleBalloon() {
    setState(() => showRatingBalloon = !showRatingBalloon);
  }

  @override
  void initState() {
    super.initState();
  }

  void setLike(LikeType type) => setState(() => likeType = type);

  @override
  Widget build(BuildContext context) {
    final imageURL = widget.entity?.attributes?.poster?.data?.attributes?.formats?.large?.url;
    return Container(
      width: MediaQuery.of(context).size.width,
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
            PlainThumbBackground(imageUrl: imageURL ?? ''),
            VideoCardContent(
              totalComments: widget.totalComments,
              movieEntity: widget.entity,
              commentsEntity: widget.commentsEntity,
              onSharePressed: () {
                SharePlus.instance.share(
                    ShareParams(text: 'Check out this movie: ${widget.entity!.attributes!.name!}\n\n${widget.entity!.attributes!.synopsis!}\n\nWatch it now!'));
              },
              onLikePressed: toggleBalloon,
              onWatchPressed: widget.onWatchPressed,
            ),
            if (showRatingBalloon)
              Positioned(
                bottom: 64,
                left: 0,
                right: 24,
                child: RatingBalloon(
                  likeType: likeType,
                  onClose: toggleBalloon,
                  onPressed: (type) async {
                    await widget.onLikePressed(type);
                    setLike(type);
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
