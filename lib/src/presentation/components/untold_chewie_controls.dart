import 'package:flutter/material.dart';
import 'package:tech_travel/src/core/theme/app_colors.dart';
import 'package:tech_travel/src/core/theme/app_text_style.dart';
import 'package:tech_travel/src/presentation/components/icon/untold_icon.dart';
import 'package:tech_travel/src/presentation/components/icon/untold_icon_data.dart';
import 'package:tech_travel/src/presentation/components/untold_back_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:video_player/video_player.dart';

class UntoldVideoControls extends StatefulWidget {
  final VideoPlayerController videoController;
  final String movieTitle;
  final int? commentsLength;
  final Function()? onSubtitlesTap;
  final Function()? onBackPressed;
  final Function()? onCommentsTap;

  const UntoldVideoControls({
    super.key,
    required this.videoController,
    required this.movieTitle,
    this.commentsLength,
    this.onSubtitlesTap,
    this.onCommentsTap,
    this.onBackPressed,
  });

  @override
  State<UntoldVideoControls> createState() => _UntoldVideoControlsState();
}

class _UntoldVideoControlsState extends State<UntoldVideoControls> {
  final ValueNotifier<Duration> _position = ValueNotifier(Duration.zero);
  final ValueNotifier<Duration> _duration = ValueNotifier(Duration.zero);

  @override
  void initState() {
    super.initState();

    widget.videoController.addListener(_updatePosition);
    _duration.value = widget.videoController.value.duration;
  }

  void _updatePosition() {
    final controller = widget.videoController;
    if (!mounted) return;

    _position.value = controller.value.position;
    _duration.value = controller.value.duration;
  }

  @override
  void dispose() {
    widget.videoController.removeListener(_updatePosition);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _position,
        builder: (context, position, _) {
          return LayoutBuilder(builder: (context, constraints) {
            return Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 64),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      UntoldBackButton(
                        onPressed: widget.onBackPressed,
                      ),
                      const SizedBox(width: 16),
                      Text(
                        constraints.maxWidth < MediaQuery.of(context).size.width * 0.7 ? '${widget.movieTitle.substring(0, 10)}...' : widget.movieTitle,
                        style: AppTextStyle.videoTitle,
                      ),
                      const Expanded(child: SizedBox()),
                      GestureDetector(
                        onTap: widget.onSubtitlesTap,
                        child: Row(
                          children: [
                            UntoldIcon(icon: UntoldIcons.subtitles),
                            const SizedBox(width: 8),
                            Text(
                              'subtitles or audio'.tr(),
                              style: AppTextStyle.videoSubtitle,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      GestureDetector(
                        onTap: widget.onCommentsTap,
                        child: Row(
                          children: [
                            UntoldIcon(icon: UntoldIcons.comments),
                            const SizedBox(width: 8),
                            Text(
                              'comments ${widget.commentsLength ?? ''}',
                              style: AppTextStyle.videoSubtitle,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        UntoldIcon(
                          icon: UntoldIcons.backward,
                          size: 64,
                          onTap: () => widget.videoController.seekTo(position - const Duration(seconds: 10)),
                        ),
                        UntoldIcon(
                          icon: UntoldIcons.pause,
                          size: 96,
                          onTap: () => widget.videoController.value.isPlaying ? widget.videoController.pause() : widget.videoController.play(),
                        ),
                        UntoldIcon(
                          icon: UntoldIcons.forward,
                          size: 64,
                          onTap: () => widget.videoController.seekTo(position + const Duration(seconds: 10)),
                        ),
                      ],
                    ),
                  ),
                  ValueListenableBuilder(
                      valueListenable: _duration,
                      builder: (context, duration, _) {
                        return Row(
                          children: [
                            Expanded(
                              child: Slider(
                                value: position.inMilliseconds.toDouble().clamp(0.0, duration.inMilliseconds.toDouble()),
                                max: duration.inMilliseconds.toDouble(),
                                activeColor: AppColors.purple1,
                                inactiveColor: AppColors.white40,
                                thumbColor: AppColors.purple1,
                                onChanged: (value) => widget.videoController.seekTo(Duration(milliseconds: value.toInt())),
                              ),
                            ),
                            Text(
                              position.toString().split('.').first,
                              style: AppTextStyle.videoTime,
                            ),
                            const SizedBox(width: 16),
                            UntoldIcon(icon: UntoldIcons.fullscreen, size: 24),
                          ],
                        );
                      })
                ],
              ),
            );
          });
        });
  }
}
