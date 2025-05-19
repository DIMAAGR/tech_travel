import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:tech_travel/src/core/theme/app_gradients.dart';
import 'package:video_player/video_player.dart';

class BlurredVideoBackground extends StatefulWidget {
  final String videoUrl;
  final Widget child;
  final bool applyGradient;
  final double blurSigma;

  const BlurredVideoBackground({
    super.key,
    required this.videoUrl,
    required this.child,
    this.applyGradient = true,
    this.blurSigma = 20,
  });

  @override
  State<BlurredVideoBackground> createState() => _BlurredVideoBackgroundState();
}

class _BlurredVideoBackgroundState extends State<BlurredVideoBackground> {
  late VideoPlayerController _controller;

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
    return Stack(
      children: [
        // Video background
        if (_controller.value.isInitialized)
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controller.value.size.width,
                height: _controller.value.size.height,
                child: VideoPlayer(_controller),
              ),
            ),
          ),

        // Blur effect
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: widget.blurSigma,
              sigmaY: widget.blurSigma,
            ),
            child: Container(color: Colors.black.withOpacity(0)),
          ),
        ),

        // Gradient overlay
        if (widget.applyGradient)
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: AppGradients.linearOverlay,
              ),
            ),
          ),
        if (widget.applyGradient)
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: AppGradients.fadeToBlack,
              ),
            ),
          ),
        Positioned.fill(child: widget.child),
      ],
    );
  }
}
