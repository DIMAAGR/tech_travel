import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class UntoldLogo extends StatelessWidget {
  final double size;
  final bool useAlternative;
  const UntoldLogo({super.key, this.size = 32, this.useAlternative = false});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      useAlternative ? 'assets/icons/logo_alternative.svg' : 'assets/icons/logo.svg',
      height: size,
      width: size,
    );
  }
}
