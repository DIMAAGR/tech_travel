import 'package:flutter/material.dart';

class UntoldViewBody extends StatelessWidget {
  final List<Widget> children;
  final CrossAxisAlignment? crossAxisAlignment;
  final MainAxisAlignment? mainAxisAlignment;
  const UntoldViewBody({
    super.key,
    required this.children,
    this.crossAxisAlignment,
    this.mainAxisAlignment,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
                  mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.spaceAround,
                  children: children,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
