// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_player_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$VideoPlayerViewModel on VideoPlayerViewModelBase, Store {
  late final _$commentsStateAtom =
      Atom(name: 'VideoPlayerViewModelBase.commentsState', context: context);

  @override
  ViewModelState<Failure, List<CommentsEntity>> get commentsState {
    _$commentsStateAtom.reportRead();
    return super.commentsState;
  }

  @override
  set commentsState(ViewModelState<Failure, List<CommentsEntity>> value) {
    _$commentsStateAtom.reportWrite(value, super.commentsState, () {
      super.commentsState = value;
    });
  }

  late final _$addCommentStateAtom =
      Atom(name: 'VideoPlayerViewModelBase.addCommentState', context: context);

  @override
  ViewModelState<Failure, void> get addCommentState {
    _$addCommentStateAtom.reportRead();
    return super.addCommentState;
  }

  @override
  set addCommentState(ViewModelState<Failure, void> value) {
    _$addCommentStateAtom.reportWrite(value, super.addCommentState, () {
      super.addCommentState = value;
    });
  }

  late final _$subtitlesStateAtom =
      Atom(name: 'VideoPlayerViewModelBase.subtitlesState', context: context);

  @override
  ViewModelState<Failure, SubtitlesEntity> get subtitlesState {
    _$subtitlesStateAtom.reportRead();
    return super.subtitlesState;
  }

  @override
  set subtitlesState(ViewModelState<Failure, SubtitlesEntity> value) {
    _$subtitlesStateAtom.reportWrite(value, super.subtitlesState, () {
      super.subtitlesState = value;
    });
  }

  late final _$subtitleAtom =
      Atom(name: 'VideoPlayerViewModelBase.subtitle', context: context);

  @override
  String get subtitle {
    _$subtitleAtom.reportRead();
    return super.subtitle;
  }

  @override
  set subtitle(String value) {
    _$subtitleAtom.reportWrite(value, super.subtitle, () {
      super.subtitle = value;
    });
  }

  late final _$showControlsAtom =
      Atom(name: 'VideoPlayerViewModelBase.showControls', context: context);

  @override
  bool get showControls {
    _$showControlsAtom.reportRead();
    return super.showControls;
  }

  @override
  set showControls(bool value) {
    _$showControlsAtom.reportWrite(value, super.showControls, () {
      super.showControls = value;
    });
  }

  late final _$showCommentsAtom =
      Atom(name: 'VideoPlayerViewModelBase.showComments', context: context);

  @override
  bool get showComments {
    _$showCommentsAtom.reportRead();
    return super.showComments;
  }

  @override
  set showComments(bool value) {
    _$showCommentsAtom.reportWrite(value, super.showComments, () {
      super.showComments = value;
    });
  }

  late final _$getAllCommentsAsyncAction =
      AsyncAction('VideoPlayerViewModelBase.getAllComments', context: context);

  @override
  Future<void> getAllComments() {
    return _$getAllCommentsAsyncAction.run(() => super.getAllComments());
  }

  late final _$addCommentAsyncAction =
      AsyncAction('VideoPlayerViewModelBase.addComment', context: context);

  @override
  Future<void> addComment() {
    return _$addCommentAsyncAction.run(() => super.addComment());
  }

  late final _$getSubtitlesAsyncAction =
      AsyncAction('VideoPlayerViewModelBase.getSubtitles', context: context);

  @override
  Future<void> getSubtitles() {
    return _$getSubtitlesAsyncAction.run(() => super.getSubtitles());
  }

  late final _$VideoPlayerViewModelBaseActionController =
      ActionController(name: 'VideoPlayerViewModelBase', context: context);

  @override
  void updateSubtitle(String value) {
    final _$actionInfo = _$VideoPlayerViewModelBaseActionController.startAction(
        name: 'VideoPlayerViewModelBase.updateSubtitle');
    try {
      return super.updateSubtitle(value);
    } finally {
      _$VideoPlayerViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleControls() {
    final _$actionInfo = _$VideoPlayerViewModelBaseActionController.startAction(
        name: 'VideoPlayerViewModelBase.toggleControls');
    try {
      return super.toggleControls();
    } finally {
      _$VideoPlayerViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void hideControls() {
    final _$actionInfo = _$VideoPlayerViewModelBaseActionController.startAction(
        name: 'VideoPlayerViewModelBase.hideControls');
    try {
      return super.hideControls();
    } finally {
      _$VideoPlayerViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void openComments() {
    final _$actionInfo = _$VideoPlayerViewModelBaseActionController.startAction(
        name: 'VideoPlayerViewModelBase.openComments');
    try {
      return super.openComments();
    } finally {
      _$VideoPlayerViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void closeComments() {
    final _$actionInfo = _$VideoPlayerViewModelBaseActionController.startAction(
        name: 'VideoPlayerViewModelBase.closeComments');
    try {
      return super.closeComments();
    } finally {
      _$VideoPlayerViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
commentsState: ${commentsState},
addCommentState: ${addCommentState},
subtitlesState: ${subtitlesState},
subtitle: ${subtitle},
showControls: ${showControls},
showComments: ${showComments}
    ''';
  }
}
