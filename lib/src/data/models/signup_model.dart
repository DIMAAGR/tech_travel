import 'package:equatable/equatable.dart';

class SignupModel extends Equatable {
  final String username;
  final String email;
  final String password;
  final String firebaseUid;

  const SignupModel({
    required this.username,
    required this.email,
    required this.password,
    required this.firebaseUid,
  });

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "email": email,
      "password": password,
      "firebase_UID": firebaseUid,
    };
  }

  @override
  List<Object?> get props => [
        username,
        email,
        password,
        firebaseUid,
      ];
}
