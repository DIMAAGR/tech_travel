import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';
import 'package:tech_travel/src/domain/entities/user_entity.dart';

part 'user_service.g.dart';

class UserService = UserServiceBase with _$UserService;

abstract class UserServiceBase with Store {
  final FirebaseAuth _auth;
  UserServiceBase(this._auth);

  @observable
  UserEntity? _userEntity;

  @computed
  String? get uid => _userEntity?.id?.toString() ?? _auth.currentUser?.uid;
  @computed
  String? get email => _userEntity?.email ?? _auth.currentUser?.email;
  @computed
  String? get userName => _userEntity?.username ?? _auth.currentUser?.displayName;
  @computed
  bool get isLoggedIn => _auth.currentUser != null;
  @computed
  UserEntity? get userEntity => _userEntity;

  @action
  void clearUserData() {
    _userEntity = null;
  }

  @action
  void setUserData(UserEntity userEntity) {
    _userEntity = userEntity;
  }

  void updateUserData({
    String? username,
  }) {
    _userEntity = _userEntity!.copyWith(
      username: username,
    );
  }
}
