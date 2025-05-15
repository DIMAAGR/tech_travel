import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:tech_travel/src/core/errors/failure.dart';
import 'package:tech_travel/src/core/errors/firebase_sign_in_failure.dart';
import 'package:tech_travel/src/core/errors/network_failure.dart';
import 'package:tech_travel/src/core/services/firebase_services.dart';
import 'package:tech_travel/src/domain/repositories/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final FirebaseAuthService _authService;

  LoginRepositoryImpl(this._authService);

  @override
  Future<Either<Failure, void>> signInWithApple() async {
    try {
      await _authService.loginWithApple();
      return const Right(null);
    } on FirebaseException catch (_) {
      return Left(FirebaseSignInFailure());
    } on SignInWithAppleAuthorizationException catch (_) {
      return Left(FirebaseSignInFailure(message: 'Apple sign-in not authorized'));
    } on SocketException catch (_) {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, void>> signInWithEmail(String email, String password) async {
    try {
      await _authService.loginWithEmail(email, password);
      return const Right(null);
    } on FirebaseException catch (_) {
      return Left(FirebaseSignInFailure());
    } on SignInWithAppleAuthorizationException catch (_) {
      return Left(FirebaseSignInFailure(message: 'Apple sign-in not authorized'));
    } on SocketException catch (_) {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, void>> signInWithGoogle() async {
    try {
      await _authService.loginWithGoogle();
      return const Right(null);
    } on FirebaseException catch (_) {
      return Left(FirebaseSignInFailure());
    } on SignInWithAppleAuthorizationException catch (_) {
      return Left(FirebaseSignInFailure(message: 'Google sign-in not authorized'));
    } on SocketException catch (_) {
      return Left(NetworkFailure());
    }
  }
}
