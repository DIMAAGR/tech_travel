import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:tech_travel/src/core/errors/failure.dart';
import 'package:tech_travel/src/core/state/view_model_state.dart';
import 'package:tech_travel/src/domain/entities/comments_entity.dart';
import 'package:tech_travel/src/presentation/components/untold_chewie_controls.dart';
import 'package:tech_travel/src/presentation/video_player/modals/comments_modal.dart';
import 'package:tech_travel/src/presentation/video_player/modals/subtitle_modal.dart';
import 'package:tech_travel/src/presentation/video_player/video_player_view_model.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerView extends StatefulWidget {
  final VideoPlayerViewModel viewModel;
  const VideoPlayerView({super.key, required this.viewModel});

  @override
  State<VideoPlayerView> createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<VideoPlayerView> {
  late VideoPlayerController _controller;

  int? commentsLength;

  late ReactionDisposer _commentsReactionDisposer;

  Timer? _hideTimer;

  void _startHideTimer() {
    _hideTimer?.cancel();
    _hideTimer = Timer(const Duration(seconds: 3), () {
      widget.viewModel.toggleControls();
    });
  }

  @override
  void initState() {
    initReation();

    _startHideTimer();
    super.initState();
    _controller = VideoPlayerController.network(widget.viewModel.movieEntity.attributes!.streamLink!)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    _controller.dispose();
    _hideTimer?.cancel();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _commentsReactionDisposer();
    super.dispose();
  }

  initReation() {
    _commentsReactionDisposer = reaction<ViewModelState>(
      (_) => widget.viewModel.commentsState,
      (state) {
        if (widget.viewModel.commentsState is SuccessState) {
          commentsLength = (widget.viewModel.commentsState as SuccessState<Failure, List<CommentsEntity>>).success.length;
          setState(() {});
        }
      },
    );
  }

  void _toggleControls() {
    widget.viewModel.toggleControls();
    if (widget.viewModel.showControls) _startHideTimer();
  }

  void openSubtitleModal() {
    showDialog(
      context: context,
      useSafeArea: false,
      builder: (context) {
        return SubtitleModal(viewModel: widget.viewModel);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: _toggleControls,
                child: Stack(
                  children: [
                    Center(
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: VideoPlayer(
                          _controller,
                        ),
                      ),
                    ),
                    Observer(
                      builder: (_) {
                        return widget.viewModel.showControls
                            ? Positioned.fill(
                                child: Container(
                                  color: Colors.black54,
                                  child: UntoldVideoControls(
                                    videoController: _controller,
                                    movieTitle: widget.viewModel.movieEntity.attributes!.name!,
                                    commentsLength: commentsLength,
                                    onSubtitlesTap: openSubtitleModal,
                                    onCommentsTap: widget.viewModel.openComments,
                                    onBackPressed: () => Navigator.pop(context),
                                  ),
                                ),
                              )
                            : const SizedBox.shrink();
                      },
                    ),
                  ],
                ),
              ),
            ),
            Observer(
              builder: (_) {
                return widget.viewModel.showComments
                    ? CommentsModal(
                        viewModel: widget.viewModel,
                        onClosePressed: widget.viewModel.closeComments,
                      )
                    : const SizedBox.shrink();
              },
            ),
          ],
        ));
  }
}
