// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$OnboardingViewModel on OnboardingViewModelBase, Store {
  late final _$imageStateAtom =
      Atom(name: 'OnboardingViewModelBase.imageState', context: context);

  @override
  ViewModelState<Failure, File> get imageState {
    _$imageStateAtom.reportRead();
    return super.imageState;
  }

  @override
  set imageState(ViewModelState<Failure, File> value) {
    _$imageStateAtom.reportWrite(value, super.imageState, () {
      super.imageState = value;
    });
  }

  late final _$getImageFromCameraAsyncAction = AsyncAction(
      'OnboardingViewModelBase.getImageFromCamera',
      context: context);

  @override
  Future<void> getImageFromCamera() {
    return _$getImageFromCameraAsyncAction
        .run(() => super.getImageFromCamera());
  }

  late final _$getImageFromGalleryAsyncAction = AsyncAction(
      'OnboardingViewModelBase.getImageFromGallery',
      context: context);

  @override
  Future<void> getImageFromGallery() {
    return _$getImageFromGalleryAsyncAction
        .run(() => super.getImageFromGallery());
  }

  @override
  String toString() {
    return '''
imageState: ${imageState}
    ''';
  }
}
