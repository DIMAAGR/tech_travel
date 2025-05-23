import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tech_travel/src/core/theme/app_gradients.dart';

class PlainThumbBackground extends StatefulWidget {
  final String imageUrl;
  final Widget? child;
  final BoxFit fit;

  const PlainThumbBackground({
    super.key,
    required this.imageUrl,
    this.child,
    this.fit = BoxFit.cover,
  });

  @override
  State<PlainThumbBackground> createState() => _PlainThumbBackgroundState();
}

class _PlainThumbBackgroundState extends State<PlainThumbBackground> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Fitted video
          if (widget.imageUrl.isNotEmpty)
            Positioned.fill(
              child: Transform.scale(
                scale: 1.2,
                child: FittedBox(
                  fit: widget.fit,
                  child: CachedNetworkImage(
                    imageUrl: widget.imageUrl, // Use the image URL instead of video
                    fit: widget.fit,
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
    );
  }
}
