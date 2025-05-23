// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeViewModel on HomeViewModelBase, Store {
  late final _$movieStateAtom =
      Atom(name: 'HomeViewModelBase.movieState', context: context);

  @override
  ViewModelState<Failure, MovieEntity> get movieState {
    _$movieStateAtom.reportRead();
    return super.movieState;
  }

  @override
  set movieState(ViewModelState<Failure, MovieEntity> value) {
    _$movieStateAtom.reportWrite(value, super.movieState, () {
      super.movieState = value;
    });
  }

  late final _$commentStateAtom =
      Atom(name: 'HomeViewModelBase.commentState', context: context);

  @override
  ViewModelState<Failure, List<CommentsEntity>> get commentState {
    _$commentStateAtom.reportRead();
    return super.commentState;
  }

  @override
  set commentState(ViewModelState<Failure, List<CommentsEntity>> value) {
    _$commentStateAtom.reportWrite(value, super.commentState, () {
      super.commentState = value;
    });
  }

  late final _$allLikesStateAtom =
      Atom(name: 'HomeViewModelBase.allLikesState', context: context);

  @override
  ViewModelState<Failure, LikesEntity> get allLikesState {
    _$allLikesStateAtom.reportRead();
    return super.allLikesState;
  }

  @override
  set allLikesState(ViewModelState<Failure, LikesEntity> value) {
    _$allLikesStateAtom.reportWrite(value, super.allLikesState, () {
      super.allLikesState = value;
    });
  }

  late final _$addOrRemoveLikeStateAtom =
      Atom(name: 'HomeViewModelBase.addOrRemoveLikeState', context: context);

  @override
  ViewModelState<Failure, void> get addOrRemoveLikeState {
    _$addOrRemoveLikeStateAtom.reportRead();
    return super.addOrRemoveLikeState;
  }

  @override
  set addOrRemoveLikeState(ViewModelState<Failure, void> value) {
    _$addOrRemoveLikeStateAtom.reportWrite(value, super.addOrRemoveLikeState,
        () {
      super.addOrRemoveLikeState = value;
    });
  }

  late final _$indexAtom =
      Atom(name: 'HomeViewModelBase.index', context: context);

  @override
  int get index {
    _$indexAtom.reportRead();
    return super.index;
  }

  @override
  set index(int value) {
    _$indexAtom.reportWrite(value, super.index, () {
      super.index = value;
    });
  }

  late final _$getMovieAsyncAction =
      AsyncAction('HomeViewModelBase.getMovie', context: context);

  @override
  Future<void> getMovie() {
    return _$getMovieAsyncAction.run(() => super.getMovie());
  }

  late final _$getAllCommentsAsyncAction =
      AsyncAction('HomeViewModelBase.getAllComments', context: context);

  @override
  Future<void> getAllComments() {
    return _$getAllCommentsAsyncAction.run(() => super.getAllComments());
  }

  late final _$addLikeAsyncAction =
      AsyncAction('HomeViewModelBase.addLike', context: context);

  @override
  Future<void> addLike() {
    return _$addLikeAsyncAction.run(() => super.addLike());
  }

  late final _$removeLikeAsyncAction =
      AsyncAction('HomeViewModelBase.removeLike', context: context);

  @override
  Future<void> removeLike() {
    return _$removeLikeAsyncAction.run(() => super.removeLike());
  }

  late final _$getAllLikesAsyncAction =
      AsyncAction('HomeViewModelBase.getAllLikes', context: context);

  @override
  Future<void> getAllLikes() {
    return _$getAllLikesAsyncAction.run(() => super.getAllLikes());
  }

  late final _$HomeViewModelBaseActionController =
      ActionController(name: 'HomeViewModelBase', context: context);

  @override
  void updateIndex(int index) {
    final _$actionInfo = _$HomeViewModelBaseActionController.startAction(
        name: 'HomeViewModelBase.updateIndex');
    try {
      return super.updateIndex(index);
    } finally {
      _$HomeViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
movieState: ${movieState},
commentState: ${commentState},
allLikesState: ${allLikesState},
addOrRemoveLikeState: ${addOrRemoveLikeState},
index: ${index}
    ''';
  }
}
