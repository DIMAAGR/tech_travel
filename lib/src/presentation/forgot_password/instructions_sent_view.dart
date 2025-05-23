import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tech_travel/src/core/app/app_routes.dart';
import 'package:tech_travel/src/core/theme/app_text_style.dart';
import 'package:tech_travel/src/presentation/components/untold_button.dart';
import 'package:tech_travel/src/presentation/components/untold_logo.dart';
import 'package:tech_travel/src/presentation/components/untold_view_body.dart';

class InstructionsSentView extends StatefulWidget {
  const InstructionsSentView({super.key});

  @override
  State<InstructionsSentView> createState() => _InstructionsSentViewState();
}

class _InstructionsSentViewState extends State<InstructionsSentView> {
  bool animate = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        animate = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    const duration = Duration(milliseconds: 600);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const UntoldLogo(),
      ),
      body: UntoldViewBody(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 32),
          SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                AnimatedPositioned(
                  top: animate ? 100 : 40,
                  duration: duration,
                  curve: Curves.easeOut,
                  child: Text(
                    'instructionsSentTitle'.tr(),
                    textAlign: TextAlign.center,
                    style: AppTextStyle.h1,
                  ),
                ),
                AnimatedPositioned(
                  top: animate ? 176 : 256,
                  duration: duration,
                  curve: Curves.easeOut,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 32, right: 32, top: 8, bottom: 48),
                      child: Text(
                        'instructionsSentDescription'.tr(),
                        textAlign: TextAlign.center,
                        style: AppTextStyle.body2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      bottomSheet: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          UntoldButton(
            title: 'login'.tr(),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (_) => false);
            },
          ),
          const SizedBox(height: 48)
        ],
      ),
    );
  }
}
