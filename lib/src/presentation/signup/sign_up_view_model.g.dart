// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SignupViewModel on SignUpViewModelBase, Store {
  late final _$signupStateAtom =
      Atom(name: 'SignUpViewModelBase.signupState', context: context);

  @override
  ViewModelState<Failure, void> get signupState {
    _$signupStateAtom.reportRead();
    return super.signupState;
  }

  @override
  set signupState(ViewModelState<Failure, void> value) {
    _$signupStateAtom.reportWrite(value, super.signupState, () {
      super.signupState = value;
    });
  }

  late final _$signupWithEmailAsyncAction =
      AsyncAction('SignUpViewModelBase.signupWithEmail', context: context);

  @override
  Future<void> signupWithEmail() {
    return _$signupWithEmailAsyncAction.run(() => super.signupWithEmail());
  }

  @override
  String toString() {
    return '''
signupState: ${signupState}
    ''';
  }
}
