import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tech_travel/src/core/theme/app_gradients.dart';

class BlurredThumbBackground extends StatefulWidget {
  final String imageUrl;
  final Widget child;
  final bool applyGradient;
  final double blurSigma;

  const BlurredThumbBackground({
    super.key,
    required this.imageUrl,
    required this.child,
    this.applyGradient = true,
    this.blurSigma = 20,
  });

  @override
  State<BlurredThumbBackground> createState() => _BlurredThumbBackgroundState();
}

class _BlurredThumbBackgroundState extends State<BlurredThumbBackground> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Image background
        if (widget.imageUrl.isNotEmpty)
          SizedBox.expand(
            child: Transform.scale(
              scale: 1.2,
              child: FittedBox(
                fit: BoxFit.cover,
                child: CachedNetworkImage(
                  imageUrl: widget.imageUrl,
                  fit: BoxFit.cover,
                ),
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
