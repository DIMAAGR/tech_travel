import 'package:flutter/material.dart';
import 'package:tech_travel/src/core/theme/app_gradients.dart';
import 'package:video_player/video_player.dart';

class PlainVideoBackground extends StatefulWidget {
  final String videoUrl;
  final Widget? child;
  final BoxFit fit;

  const PlainVideoBackground({
    super.key,
    required this.videoUrl,
    this.child,
    this.fit = BoxFit.cover,
  });

  @override
  State<PlainVideoBackground> createState() => _PlainVideoBackgroundState();
}

class _PlainVideoBackgroundState extends State<PlainVideoBackground> {
  late final VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..setVolume(0)
      ..setLooping(true)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Fitted video
                Positioned.fill(
                  child: Transform.scale(
                    scale: 1.2,
                    child: FittedBox(
                      fit: widget.fit,
                      child: SizedBox(
                        width: _controller.value.size.width,
                        height: _controller.value.size.height,
                        child: VideoPlayer(_controller),
                      ),
                    ),
                  ),
                ),

                // Gradients
                Container(
                  decoration: const BoxDecoration(
                    gradient: AppGradients.linearOverlay,
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    gradient: AppGradients.midFade,
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    gradient: AppGradients.fadeToBlack,
                  ),
                ),

                // Overlay content
                if (widget.child != null) widget.child!,
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}
