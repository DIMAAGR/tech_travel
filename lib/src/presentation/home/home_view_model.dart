import 'package:mobx/mobx.dart';
import 'package:tech_travel/src/core/errors/failure.dart';
import 'package:tech_travel/src/core/state/view_model_state.dart';
import 'package:tech_travel/src/data/models/add_like_model.dart';
import 'package:tech_travel/src/data/services/user_service.dart';
import 'package:tech_travel/src/domain/entities/comments_entity.dart';
import 'package:tech_travel/src/domain/entities/like_entity.dart';
import 'package:tech_travel/src/domain/entities/movie_entity.dart';
import 'package:tech_travel/src/domain/usecases/comments_use_case.dart';
import 'package:tech_travel/src/domain/usecases/get_movie_use_case.dart';
import 'package:tech_travel/src/domain/usecases/likes_use_case.dart';

part 'home_view_model.g.dart';

class HomeViewModel = HomeViewModelBase with _$HomeViewModel;

abstract class HomeViewModelBase with Store {
  final GetMovieUseCase getMovieUseCase;
  final GetAllCommentsUseCase getLastCommentUseCase;
  final GetAllLikesUseCase getAllLikesUseCase;
  final LikeUseCase addLikeUseCase;
  final UnlikeUseCase removeLikeUseCase;
  final UserService userService;
  HomeViewModelBase({
    required this.getMovieUseCase,
    required this.getLastCommentUseCase,
    required this.getAllLikesUseCase,
    required this.addLikeUseCase,
    required this.removeLikeUseCase,
    required this.userService,
  });

  final String profilePhotoURL = 'https://i.pinimg.com/736x/ac/33/56/ac33563b6de9253a779883dca00a5692.jpg';

  @observable
  ViewModelState<Failure, MovieEntity> movieState = InitialState();

  @observable
  ViewModelState<Failure, List<CommentsEntity>> commentState = InitialState();
  @observable
  ViewModelState<Failure, LikesEntity> allLikesState = InitialState();

  @observable
  ViewModelState<Failure, void> addOrRemoveLikeState = InitialState();

  @observable
  int index = 0;

  @action
  void updateIndex(int index) {
    this.index = index;
  }

  @action
  Future<void> getMovie() async {
    movieState = LoadingState();

    (await getMovieUseCase()).fold(
      (e) => movieState = ErrorState(e),
      (s) => movieState = SuccessState(s),
    );
  }

  // @action
  // Future<void> getLastComment() async {
  //   commentState = LoadingState();

  //   (await getLastCommentUseCase((movieState as SuccessState<Failure, MovieEntity>).success.data[index].id.toString())).fold(
  //     (e) => commentState = ErrorState(e),
  //     (s) => commentState = SuccessState(s),
  //   );
  // }

  @action
  Future<void> getAllComments() async {
    commentState = LoadingState();

    final movie = (movieState as SuccessState<Failure, MovieEntity>).success.data[index];

    (await getLastCommentUseCase(movie.id.toString())).fold(
      (e) => commentState = ErrorState(e),
      (s) {
        commentState = SuccessState(s);
      },
    );
  }

  @action
  Future<void> addLike() async {
    final movie = (movieState as SuccessState<Failure, MovieEntity>).success.data[index];
    (await addLikeUseCase(AddLikeModel(
      movieId: movie.id!,
      userId: int.parse(userService.uid!),
    )))
        .fold(
      (e) => addOrRemoveLikeState = ErrorState(e),
      (s) => addOrRemoveLikeState = SuccessState(null),
    );
  }

  @action
  Future<void> removeLike() async {
    final movie = (movieState as SuccessState<Failure, MovieEntity>).success.data[index];
    final like = (allLikesState as SuccessState<Failure, LikesEntity>).success.data.firstWhere((element) {
      return element.attributes!.movieId!.data!.id == movie.id &&
          element.attributes!.userId!.data!.id! ==
              int.parse(
                userService.uid!,
              );
    });

    (await removeLikeUseCase(like.id!.toString())).fold(
      (e) => addOrRemoveLikeState = ErrorState(e),
      (s) => addOrRemoveLikeState = SuccessState(null),
    );
  }

  bool isLiked() {
    if (allLikesState is SuccessState<Failure, LikesEntity>) {
      final likes = (allLikesState as SuccessState<Failure, LikesEntity>).success.data;
      final movie = (movieState as SuccessState<Failure, MovieEntity>).success.data[index];

      return likes.any((element) => element.attributes!.movieId!.data!.id == movie.id && element.attributes!.userId!.data!.id! == int.parse(userService.uid!));
    }
    return false;
  }

  @action
  Future<void> getAllLikes() async {
    allLikesState = LoadingState();

    (await getAllLikesUseCase()).fold(
      (e) => allLikesState = ErrorState(e),
      (s) => allLikesState = SuccessState(s),
    );
  }
}
