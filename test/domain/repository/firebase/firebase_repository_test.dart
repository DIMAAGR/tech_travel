import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import 'package:tech_travel/src/core/services/firebase_services.dart';
import 'package:tech_travel/src/data/repositories/login_repository_impl.dart';
import 'package:tech_travel/src/core/errors/firebase_sign_in_failure.dart';
import 'package:tech_travel/src/core/errors/network_failure.dart';

// Generates a mock for FirebaseAuthService
@GenerateMocks([FirebaseAuthService])
import 'firebase_repository_test.mocks.dart';

void main() {
  late MockFirebaseAuthService mockAuthService;
  late LoginRepositoryImpl repository;

  setUp(() {
    mockAuthService = MockFirebaseAuthService();
    repository = LoginRepositoryImpl(mockAuthService);
  });

  group('signInWithGoogle', () {
    test('should return Right(null) when loginWithGoogle succeeds', () async {
      when(mockAuthService.loginWithGoogle()).thenAnswer((_) async => true);

      final result = await repository.signInWithGoogle();

      expect(result, const Right(null));
      verify(mockAuthService.loginWithGoogle()).called(1);
    });

    test('should return Left(FirebaseSignInFailure) when a FirebaseException is thrown', () async {
      when(mockAuthService.loginWithGoogle()).thenThrow(FirebaseException(plugin: 'auth', code: 'error'));

      final result = await repository.signInWithGoogle();

      expect(result.isLeft(), isTrue);
      result.fold(
        (l) => expect(l, isA<FirebaseSignInFailure>()),
        (_) => fail('Expected Left'),
      );
    });

    test('should return Left(FirebaseSignInFailure) when a SignInWithAppleAuthorizationException is thrown', () async {
      when(mockAuthService.loginWithGoogle()).thenThrow(const SignInWithAppleAuthorizationException(
        code: AuthorizationErrorCode.unknown,
        message: 'Unauthorized',
      ));

      final result = await repository.signInWithGoogle();

      expect(result.isLeft(), isTrue);
      result.fold(
        (l) => expect(l, isA<FirebaseSignInFailure>()),
        (_) => fail('Expected Left'),
      );
    });

    test('should return Left(NetworkFailure) when a SocketException is thrown', () async {
      when(mockAuthService.loginWithGoogle()).thenThrow(const SocketException('No connection'));

      final result = await repository.signInWithGoogle();

      expect(result.isLeft(), isTrue);
      result.fold(
        (l) => expect(l, isA<NetworkFailure>()),
        (_) => fail('Expected Left'),
      );
    });
  });

  group('signInWithApple', () {
    test('should return Right(null) when loginWithApple succeeds', () async {
      when(mockAuthService.loginWithApple()).thenAnswer((_) async => true);

      final result = await repository.signInWithApple();

      expect(result, const Right(null));
      verify(mockAuthService.loginWithApple()).called(1);
    });

    test('should return Left(FirebaseSignInFailure) when a FirebaseException is thrown', () async {
      when(mockAuthService.loginWithApple()).thenThrow(FirebaseException(plugin: 'auth', code: 'error'));

      final result = await repository.signInWithApple();

      expect(result.isLeft(), isTrue);
      result.fold(
        (l) => expect(l, isA<FirebaseSignInFailure>()),
        (_) => fail('Expected Left'),
      );
    });

    test('should return Left(FirebaseSignInFailure) when a SignInWithAppleAuthorizationException is thrown', () async {
      when(mockAuthService.loginWithApple()).thenThrow(const SignInWithAppleAuthorizationException(
        code: AuthorizationErrorCode.canceled,
        message: 'Apple sign-in canceled',
      ));

      final result = await repository.signInWithApple();

      expect(result.isLeft(), isTrue);
      result.fold(
        (l) => expect(l, isA<FirebaseSignInFailure>()),
        (_) => fail('Expected Left'),
      );
    });

    test('should return Left(NetworkFailure) when a SocketException is thrown', () async {
      when(mockAuthService.loginWithApple()).thenThrow(const SocketException('No connection'));

      final result = await repository.signInWithApple();

      expect(result.isLeft(), isTrue);
      result.fold(
        (l) => expect(l, isA<NetworkFailure>()),
        (_) => fail('Expected Left'),
      );
    });
  });

  group('signInWithEmail', () {
    const email = 'test@example.com';
    const password = 'password123';

    test('should return Right(null) when loginWithEmail succeeds', () async {
      when(mockAuthService.loginWithEmail(email, password)).thenAnswer((_) async => true);

      final result = await repository.signInWithEmail(email, password);

      expect(result, const Right(null));
      verify(mockAuthService.loginWithEmail(email, password)).called(1);
    });

    test('should return Left(FirebaseSignInFailure) when a FirebaseException is thrown', () async {
      when(mockAuthService.loginWithEmail(email, password)).thenThrow(FirebaseException(plugin: 'auth', code: 'error'));

      final result = await repository.signInWithEmail(email, password);

      expect(result.isLeft(), isTrue);
      result.fold(
        (l) => expect(l, isA<FirebaseSignInFailure>()),
        (_) => fail('Expected Left'),
      );
    });

    test('should return Left(FirebaseSignInFailure) when a SignInWithAppleAuthorizationException is thrown', () async {
      when(mockAuthService.loginWithEmail(email, password)).thenThrow(const SignInWithAppleAuthorizationException(
        code: AuthorizationErrorCode.unknown,
        message: 'Unauthorized',
      ));

      final result = await repository.signInWithEmail(email, password);

      expect(result.isLeft(), isTrue);
      result.fold(
        (l) => expect(l, isA<FirebaseSignInFailure>()),
        (_) => fail('Expected Left'),
      );
    });

    test('should return Left(NetworkFailure) when a SocketException is thrown', () async {
      when(mockAuthService.loginWithEmail(email, password)).thenThrow(const SocketException('No connection'));

      final result = await repository.signInWithEmail(email, password);

      expect(result.isLeft(), isTrue);
      result.fold(
        (l) => expect(l, isA<NetworkFailure>()),
        (_) => fail('Expected Left'),
      );
    });
  });
}
