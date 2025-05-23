import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:tech_travel/src/core/app/app_routes.dart';
import 'package:tech_travel/src/core/errors/failure.dart';
import 'package:tech_travel/src/core/state/view_model_state.dart';
import 'package:tech_travel/src/core/theme/app_text_style.dart';
import 'package:tech_travel/src/domain/entities/comments_entity.dart';
import 'package:tech_travel/src/domain/entities/movie_entity.dart';
import 'package:tech_travel/src/presentation/components/untold_logo.dart';
import 'package:tech_travel/src/presentation/home/home_view_model.dart';
import 'package:tech_travel/src/presentation/home/widgets/blurred_thumb_background.dart';
import 'package:tech_travel/src/presentation/home/widgets/rating_dialog.dart';
import 'package:tech_travel/src/presentation/home/widgets/user_button.dart';
import 'package:tech_travel/src/presentation/home/widgets/video_card.dart';
import 'package:tech_travel/src/presentation/video_player/video_player_view_model.dart';

class HomeView extends StatefulWidget {
  final HomeViewModel viewModel;
  final VideoPlayerViewModel viedeoViewModel;
  const HomeView({super.key, required this.viewModel, required this.viedeoViewModel});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final PageController _pageController = PageController(viewportFraction: 0.92);
  late ReactionDisposer _reactionDisposer;

  @override
  void initState() {
    _pageController.addListener(() => widget.viewModel.updateIndex(_pageController.page!.toInt()));
    widget.viewModel.getMovie();
    initReaction();

    super.initState();
  }

  initReaction() {
    _reactionDisposer = reaction<ViewModelState>(
      (_) => widget.viewModel.movieState,
      (state) {
        if (state is SuccessState) {
          widget.viewModel.getAllComments();
          widget.viewModel.getAllLikes();
        }
      },
    );
  }

  @override
  void dispose() {
    _reactionDisposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const UntoldLogo(),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: UserButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.profile);
              },
              imageUrl: widget.viewModel.profilePhotoURL,
            ),
          ),
        ],
      ),
      body: Observer(builder: (context) {
        final bool isSuccess = widget.viewModel.movieState is SuccessState;
        final bool isCommentSuccess = widget.viewModel.commentState is SuccessState;

        return BlurredThumbBackground(
            imageUrl: isSuccess ? (widget.viewModel.movieState as SuccessState<Failure, MovieEntity>).success.getThumb(widget.viewModel.index)! : '',
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'nowShowing'.tr(),
                          style: AppTextStyle.h2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: PageView.builder(
                        scrollDirection: Axis.horizontal,
                        controller: _pageController,
                        itemCount: isSuccess ? (widget.viewModel.movieState as SuccessState<Failure, MovieEntity>).success.data.length : 1,
                        itemBuilder: (context, index) {
                          widget.viewModel.updateIndex(index);
                          return VideoCard(
                            totalComments: isCommentSuccess ? (widget.viewModel.commentState as SuccessState<Failure, List<CommentsEntity>>).success.length : 0,
                            commentsEntity:
                                isCommentSuccess ? (widget.viewModel.commentState as SuccessState<Failure, List<CommentsEntity>>).success.first : null,
                            entity: isSuccess ? (widget.viewModel.movieState as SuccessState<Failure, MovieEntity>).success.data[index] : null,
                            isLiked: false,
                            onLikePressed: (like) async {
                              if (like == LikeType.liked) {
                                await widget.viewModel.addLike();
                                await widget.viewModel.getAllLikes();
                              } else {
                                await widget.viewModel.removeLike();
                              }
                            },
                            onWatchPressed: () {
                              widget.viedeoViewModel.movieEntity = (widget.viewModel.movieState as SuccessState<Failure, MovieEntity>).success.data[index];
                              widget.viedeoViewModel.getAllComments();
                              widget.viedeoViewModel.getSubtitles();
                              Navigator.of(context).pushNamed(AppRoutes.video);
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ));
      }),
    );
  }
}
