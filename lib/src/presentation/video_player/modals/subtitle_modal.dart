import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:tech_travel/src/core/errors/failure.dart';
import 'package:tech_travel/src/core/state/view_model_state.dart';
import 'package:tech_travel/src/core/theme/app_colors.dart';
import 'package:tech_travel/src/core/theme/app_text_style.dart';
import 'package:tech_travel/src/domain/entities/subtitle_entity.dart';
import 'package:tech_travel/src/presentation/components/untold_text_button.dart';
import 'package:tech_travel/src/presentation/video_player/video_player_view_model.dart';

class SubtitleModal extends StatefulWidget {
  final VideoPlayerViewModel viewModel;
  const SubtitleModal({
    super.key,
    required this.viewModel,
  });

  @override
  State<SubtitleModal> createState() => _SubtitleModalState();
}

class _SubtitleModalState extends State<SubtitleModal> {
  int? subtitlesLenght;

  @override
  void initState() {
    subtitlesLenght = widget.viewModel.subtitlesState is SuccessState<Failure, SubtitlesEntity>
        ? (widget.viewModel.subtitlesState as SuccessState<Failure, SubtitlesEntity>).success.data.length
        : null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  UntoldTextButton(title: 'close'.tr(), onPressed: () => Navigator.pop(context)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: subtitlesLenght == null
                    ? []
                    : [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'audio'.tr(),
                              style: AppTextStyle.videoSubtitlesTitle,
                            ),
                            const SizedBox(height: 24),
                            ...List.generate(subtitlesLenght!, (i) {
                              return Observer(builder: (context) {
                                final subtitlesState = widget.viewModel.subtitlesState;
                                final subtitles = subtitlesState is SuccessState<Failure, SubtitlesEntity> ? subtitlesState.success.data : null;
                                return _subtitleButton(
                                  isActivated: widget.viewModel.subtitle == subtitles![i].attributes!.language!,
                                  title: subtitles[i].attributes!.language!,
                                  onTap: () {
                                    widget.viewModel.updateSubtitle(subtitles[i].attributes!.language!);
                                  },
                                );
                              });
                            })
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'subtitles'.tr(),
                              style: AppTextStyle.videoSubtitlesTitle,
                            ),
                            const SizedBox(height: 24),
                            _subtitleButton(
                              isActivated: true,
                              title: 'off',
                              onTap: () {},
                            ),
                            _subtitleButton(
                              isActivated: false,
                              title: 'English (cc)',
                              onTap: () {},
                            ),
                            _subtitleButton(
                              isActivated: false,
                              title: 'Espanish',
                              onTap: () {},
                            ),
                            _subtitleButton(
                              isActivated: false,
                              title: 'Portuguese',
                              onTap: () {},
                            ),
                          ],
                        ),
                        const SizedBox(),
                      ],
              ),
              const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  Padding _subtitleButton({
    required bool isActivated,
    required String title,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 24,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: isActivated ? AppColors.purple3 : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              title,
              style: AppTextStyle.videoSubtitlesButton.copyWith(
                color: isActivated ? AppColors.purple1 : AppColors.white40,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
