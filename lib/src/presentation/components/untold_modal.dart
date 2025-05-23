import 'package:flutter/widgets.dart';
import 'package:tech_travel/src/core/theme/app_text_style.dart';
import 'package:tech_travel/src/presentation/components/untold_back_button.dart';

class UntoldModal extends StatelessWidget {
  final String? title;
  final List<Widget> children;
  final CrossAxisAlignment? crossAxisAlignment;
  final MainAxisAlignment? mainAxisAlignment;
  final MainAxisSize? mainAxisSize;
  final EdgeInsets? padding;
  final double? backSize;
  final TextStyle? titleStyle;
  const UntoldModal({
    super.key,
    this.title,
    required this.children,
    this.crossAxisAlignment,
    this.mainAxisAlignment,
    this.padding,
    this.mainAxisSize,
    this.titleStyle,
    this.backSize,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(32),
      child: Column(
        mainAxisSize: mainAxisSize ?? MainAxisSize.min,
        crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
        mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: UntoldBackButton(
                  size: backSize,
                ),
              ),
              if (title != null)
                Text(
                  title!,
                  style: titleStyle ?? AppTextStyle.subtitle1.copyWith(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
            ],
          ),
          const SizedBox(height: 24),
          ...children,
        ],
      ),
    );
  }
}
