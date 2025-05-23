import 'package:mobx/mobx.dart';
import 'package:tech_travel/src/core/errors/failure.dart';
import 'package:tech_travel/src/core/state/view_model_state.dart';
import 'package:tech_travel/src/data/models/comments_model.dart';
import 'package:tech_travel/src/data/services/user_service.dart';
import 'package:tech_travel/src/domain/entities/comments_entity.dart';
import 'package:tech_travel/src/domain/entities/movie_entity.dart';
import 'package:tech_travel/src/domain/entities/subtitle_entity.dart';
import 'package:tech_travel/src/domain/usecases/comments_use_case.dart';
import 'package:tech_travel/src/domain/usecases/subtitles_use_case.dart';
import 'package:uuid/uuid.dart';

part 'video_player_view_model.g.dart';

class VideoPlayerViewModel = VideoPlayerViewModelBase with _$VideoPlayerViewModel;

abstract class VideoPlayerViewModelBase with Store {
  final GetAllCommentsUseCase getAllCommentsUseCase;
  final AddCommentUseCase addCommentUseCase;
  final UserService userService;
  final SubtitlesUseCase getSubtitlesUseCase;

  VideoPlayerViewModelBase({
    required this.getSubtitlesUseCase,
    required this.userService,
    required this.getAllCommentsUseCase,
    required this.addCommentUseCase,
  });

  late DatumEntity movieEntity;
  final String profilePhotoURL = 'https://i.pinimg.com/736x/ac/33/56/ac33563b6de9253a779883dca00a5692.jpg';
  String comment = '';

  @observable
  ViewModelState<Failure, List<CommentsEntity>> commentsState = InitialState();

  @observable
  ViewModelState<Failure, void> addCommentState = InitialState();

  @observable
  ViewModelState<Failure, SubtitlesEntity> subtitlesState = InitialState();

  @observable
  String subtitle = 'English';

  @observable
  bool showControls = true;

  @observable
  bool showComments = false;

  @action
  void updateSubtitle(String value) {
    subtitle = value;
  }

  @action
  void toggleControls() {
    showControls = !showControls;
  }

  @action
  void hideControls() {
    showControls = false;
  }

  @action
  void openComments() {
    showComments = true;
  }

  @action
  void closeComments() {
    showComments = false;
  }

  setComment(String value) {
    comment = value;
  }

  clearComment() {
    comment = '';
  }

  get userId => userService.uid;

  @action
  Future<void> getAllComments() async {
    commentsState = LoadingState();
    final result = await getAllCommentsUseCase(movieEntity.id!.toString());
    result.fold(
      (failure) => commentsState = ErrorState(failure),
      (success) => commentsState = SuccessState(success),
    );
  }

  @action
  Future<void> addComment() async {
    addCommentState = LoadingState();
    final result = await addCommentUseCase(
      CommentsModel(
        comment: comment,
        date: DateTime.now(),
        id: const Uuid().v4(),
        movie: movieEntity.id!.toString(),
        user: UserModel(
          email: userService.email,
          firebaseUid: userService.fireUid,
          id: int.parse(userService.uid!),
          name: userService.userName,
          photoUrl: 'https://i.pinimg.com/736x/ac/33/56/ac33563b6de9253a779883dca00a5692.jpg',
        ),
      ),
    );
    result.fold(
      (failure) {
        addCommentState = ErrorState(failure);
      },
      (success) {
        addCommentState = SuccessState(null);
      },
    );
  }

  @action
  Future<void> getSubtitles() async {
    subtitlesState = LoadingState();
    final result = await getSubtitlesUseCase(movieEntity.id!.toString());
    result.fold(
      (failure) => subtitlesState = ErrorState(failure),
      (success) => subtitlesState = SuccessState(success),
    );
  }
}
