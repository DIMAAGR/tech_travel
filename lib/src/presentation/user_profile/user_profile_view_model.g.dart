// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserProfileViewModel on UserProfileViewModelBase, Store {
  late final _$exitableStateAtom =
      Atom(name: 'UserProfileViewModelBase.exitableState', context: context);

  @override
  ViewModelState<Failure, bool> get exitableState {
    _$exitableStateAtom.reportRead();
    return super.exitableState;
  }

  @override
  set exitableState(ViewModelState<Failure, bool> value) {
    _$exitableStateAtom.reportWrite(value, super.exitableState, () {
      super.exitableState = value;
    });
  }

  late final _$userProfileStateAtom =
      Atom(name: 'UserProfileViewModelBase.userProfileState', context: context);

  @override
  ViewModelState<Failure, bool> get userProfileState {
    _$userProfileStateAtom.reportRead();
    return super.userProfileState;
  }

  @override
  set userProfileState(ViewModelState<Failure, bool> value) {
    _$userProfileStateAtom.reportWrite(value, super.userProfileState, () {
      super.userProfileState = value;
    });
  }

  late final _$logoutAsyncAction =
      AsyncAction('UserProfileViewModelBase.logout', context: context);

  @override
  Future<void> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  late final _$updateNameAsyncAction =
      AsyncAction('UserProfileViewModelBase.updateName', context: context);

  @override
  Future<void> updateName() {
    return _$updateNameAsyncAction.run(() => super.updateName());
  }

  @override
  String toString() {
    return '''
exitableState: ${exitableState},
userProfileState: ${userProfileState}
    ''';
  }
}
