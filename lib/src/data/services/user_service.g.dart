// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_service.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserService on UserServiceBase, Store {
  Computed<String?>? _$uidComputed;

  @override
  String? get uid => (_$uidComputed ??=
          Computed<String?>(() => super.uid, name: 'UserServiceBase.uid'))
      .value;
  Computed<String?>? _$emailComputed;

  @override
  String? get email => (_$emailComputed ??=
          Computed<String?>(() => super.email, name: 'UserServiceBase.email'))
      .value;
  Computed<String?>? _$userNameComputed;

  @override
  String? get userName =>
      (_$userNameComputed ??= Computed<String?>(() => super.userName,
              name: 'UserServiceBase.userName'))
          .value;
  Computed<bool>? _$isLoggedInComputed;

  @override
  bool get isLoggedIn =>
      (_$isLoggedInComputed ??= Computed<bool>(() => super.isLoggedIn,
              name: 'UserServiceBase.isLoggedIn'))
          .value;
  Computed<UserEntity?>? _$userEntityComputed;

  @override
  UserEntity? get userEntity =>
      (_$userEntityComputed ??= Computed<UserEntity?>(() => super.userEntity,
              name: 'UserServiceBase.userEntity'))
          .value;

  late final _$_userEntityAtom =
      Atom(name: 'UserServiceBase._userEntity', context: context);

  @override
  UserEntity? get _userEntity {
    _$_userEntityAtom.reportRead();
    return super._userEntity;
  }

  @override
  set _userEntity(UserEntity? value) {
    _$_userEntityAtom.reportWrite(value, super._userEntity, () {
      super._userEntity = value;
    });
  }

  late final _$UserServiceBaseActionController =
      ActionController(name: 'UserServiceBase', context: context);

  @override
  void clearUserData() {
    final _$actionInfo = _$UserServiceBaseActionController.startAction(
        name: 'UserServiceBase.clearUserData');
    try {
      return super.clearUserData();
    } finally {
      _$UserServiceBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setUserData(UserEntity userEntity) {
    final _$actionInfo = _$UserServiceBaseActionController.startAction(
        name: 'UserServiceBase.setUserData');
    try {
      return super.setUserData(userEntity);
    } finally {
      _$UserServiceBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
uid: ${uid},
email: ${email},
userName: ${userName},
isLoggedIn: ${isLoggedIn},
userEntity: ${userEntity}
    ''';
  }
}
