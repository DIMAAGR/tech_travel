import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'untold_icon_data.dart';

/// A customizable widget for rendering SVG icons in the Untold app.
///
/// This widget wraps the Flutter `SvgPicture.asset` and allows you to:
/// - Define a custom size (default is 28x28)
/// - Apply a solid color to the icon
/// - Handle tap interactions
///
/// You can pass an [UntoldIconData] which holds the path to the SVG asset.
/// The icon can be styled using the [color] and [size] properties.
///
/// ---
///
/// ## Example usage:
/// ```dart
/// UntoldIcon(
///   icon: UntoldIcon.eye_slash,
///   size: 32,
///   color: Colors.red,
///   onTap: () {
///     print('Eye slash tapped');
///   },
/// )
/// ```
///
/// You must ensure the icon path is valid and included in your assets.
///
/// ---
///
/// [icon]: The icon to render, from your `UntoldIcon` collection.
/// [fit]: How the icon should be fitted inside its bounds. Defaults to `BoxFit.contain`.
/// [color]: Solid color to apply over the icon.
/// [size]: The size of the icon in pixels (applies to both width and height).
/// [onTap]: Callback triggered when the icon is tapped.
class UntoldIcon extends StatelessWidget {
  final UntoldIconData? icon;
  final BoxFit? fit;
  final Color? color;
  final double? size;
  final Function()? onTap;

  const UntoldIcon({
    super.key,
    this.icon,
    this.fit,
    this.color,
    this.size,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final iconPath = icon?.path ?? '';

    return SizedBox(
      height: size ?? 28,
      width: size ?? 28,
      child: GestureDetector(
        onTap: onTap,
        child: SvgPicture.asset(
          iconPath,
          fit: fit ?? BoxFit.contain,
          colorFilter: color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
        ),
      ),
    );
  }
}
