import 'package:firebase_auth/firebase_auth.dart';
import 'package:tech_travel/src/domain/services/user_service.dart';

class UserServicesImpl implements UserService {
  final FirebaseAuth _auth;
  UserServicesImpl(this._auth);

  @override
  String? get uid => _auth.currentUser?.uid;
  @override
  String? get email => _auth.currentUser?.email;

  @override
  String? get userName => _auth.currentUser?.displayName;

  @override
  bool get isLoggedIn => _auth.currentUser != null;
}
