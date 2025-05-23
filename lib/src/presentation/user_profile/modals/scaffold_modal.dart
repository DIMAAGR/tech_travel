import 'package:flutter/material.dart';
import 'package:tech_travel/src/presentation/components/untold_back_button.dart';
import 'package:tech_travel/src/presentation/components/untold_view_body.dart';

class ScaffoldModal extends StatelessWidget {
  final List<Widget> children;
  final CrossAxisAlignment? crossAxisAlignment;
  final MainAxisAlignment? mainAxisAlignment;

  const ScaffoldModal({
    super.key,
    required this.children,
    this.crossAxisAlignment,
    this.mainAxisAlignment,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(32),
        topRight: Radius.circular(32),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.88,
        ),
        child: Scaffold(
          body: LayoutBuilder(
            builder: (context, constraint) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const UntoldBackButton(),
                    const SizedBox(height: 16),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: constraint.maxHeight - 112,
                      ),
                      child: UntoldViewBody(
                        mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
                        crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
                        children: children,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
