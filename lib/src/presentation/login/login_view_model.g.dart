// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginViewModel on LoginViewModelBase, Store {
  late final _$loginStateAtom =
      Atom(name: 'LoginViewModelBase.loginState', context: context);

  @override
  ViewModelState<Failure, void> get loginState {
    _$loginStateAtom.reportRead();
    return super.loginState;
  }

  @override
  set loginState(ViewModelState<Failure, void> value) {
    _$loginStateAtom.reportWrite(value, super.loginState, () {
      super.loginState = value;
    });
  }

  late final _$loginWithGoogleAsyncAction =
      AsyncAction('LoginViewModelBase.loginWithGoogle', context: context);

  @override
  Future<void> loginWithGoogle() {
    return _$loginWithGoogleAsyncAction.run(() => super.loginWithGoogle());
  }

  late final _$loginWithAppleAsyncAction =
      AsyncAction('LoginViewModelBase.loginWithApple', context: context);

  @override
  Future<void> loginWithApple() {
    return _$loginWithAppleAsyncAction.run(() => super.loginWithApple());
  }

  late final _$loginWithEmailAsyncAction =
      AsyncAction('LoginViewModelBase.loginWithEmail', context: context);

  @override
  Future<void> loginWithEmail() {
    return _$loginWithEmailAsyncAction.run(() => super.loginWithEmail());
  }

  late final _$getUserDataAsyncAction =
      AsyncAction('LoginViewModelBase.getUserData', context: context);

  @override
  Future<void> getUserData() {
    return _$getUserDataAsyncAction.run(() => super.getUserData());
  }

  @override
  String toString() {
    return '''
loginState: ${loginState}
    ''';
  }
}
