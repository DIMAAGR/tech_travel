import 'package:flutter/material.dart';
import 'package:tech_travel/src/core/theme/app_colors.dart';
import 'package:tech_travel/src/presentation/components/icon/untold_icon.dart';
import 'package:tech_travel/src/presentation/components/icon/untold_icon_data.dart';
import 'package:tech_travel/src/presentation/home/widgets/icon_button_with_subtitle.dart';

enum LikeType { none, liked, unliked, loved }

class RatingBalloon extends StatelessWidget {
  final VoidCallback onClose;
  final Function(LikeType) onPressed;
  final LikeType likeType;
  const RatingBalloon({
    super.key,
    required this.onClose,
    required this.onPressed,
    required this.likeType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.darkGrey3,
        borderRadius: BorderRadius.circular(40),
        boxShadow: const [
          BoxShadow(
            color: AppColors.black40,
            blurRadius: 34,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButtonWithSubtitle(
            icon: likeType == LikeType.unliked ? UntoldIcons.dislike_enabled : UntoldIcons.dislike_disabled,
            subtitle: "It's not for me",
            onPressed: () => onPressed(likeType == LikeType.none ? LikeType.unliked : LikeType.none),
          ),
          IconButtonWithSubtitle(
            icon: likeType == LikeType.liked ? UntoldIcons.like_enabled : UntoldIcons.like_disabled,
            subtitle: "I Like it",
            onPressed: () => onPressed(likeType == LikeType.none ? LikeType.liked : LikeType.none),
          ),
          IconButtonWithSubtitle(
            icon: likeType == LikeType.loved ? UntoldIcons.love_enabled : UntoldIcons.love_disabled,
            subtitle: "I love it!",
            onPressed: () => onPressed(likeType == LikeType.none ? LikeType.loved : LikeType.none),
          ),
          UntoldIcon(
            icon: UntoldIcons.close,
            size: 16,
            onTap: onClose,
          ),
        ],
      ),
    );
  }
}
