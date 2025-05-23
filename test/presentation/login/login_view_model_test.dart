// ignore_for_file: void_checks

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'package:tech_travel/src/core/errors/empty_password_failure.dart';
import 'package:tech_travel/src/core/errors/email_not_be_empty_failure.dart';
import 'package:tech_travel/src/core/errors/email_not_valid_failure.dart';
import 'package:tech_travel/src/core/errors/failure.dart';
import 'package:tech_travel/src/core/errors/login_canceled_failure.dart';
import 'package:tech_travel/src/core/errors/network_failure.dart';
import 'package:tech_travel/src/core/state/view_model_state.dart';
import 'package:tech_travel/src/data/services/user_service.dart';
import 'package:tech_travel/src/domain/entities/user_entity.dart';
import 'package:tech_travel/src/domain/usecases/sign_in_use_case.dart';
import 'package:tech_travel/src/domain/usecases/user_use_case.dart';
import 'package:tech_travel/src/presentation/login/login_view_model.dart';

import 'login_view_model_test.mocks.dart';

@GenerateMocks([
  SignInWithGoogleUseCase,
  SignInWithAppleUseCase,
  SignInWithEmailUseCase,
  GetUserDataUseCase,
  UserService,
  UserEntity,
])
void main() {
  late MockSignInWithGoogleUseCase mockGoogleUseCase;
  late MockSignInWithAppleUseCase mockAppleUseCase;
  late MockSignInWithEmailUseCase mockEmailUseCase;
  late MockGetUserDataUseCase mockGetUserDataUseCase;
  late MockUserService mockUserService;
  late LoginViewModel viewModel;
  late MockUserEntity fakeUser;

  const testEmail = 'test@example.com';
  const testPassword = 'password123';

  setUp(() {
    mockGoogleUseCase = MockSignInWithGoogleUseCase();
    mockAppleUseCase = MockSignInWithAppleUseCase();
    mockEmailUseCase = MockSignInWithEmailUseCase();
    mockGetUserDataUseCase = MockGetUserDataUseCase();
    mockUserService = MockUserService();
    fakeUser = MockUserEntity();

    viewModel = LoginViewModel(
      userService: mockUserService,
      getUserDataUseCase: mockGetUserDataUseCase,
      withAppleUseCase: mockAppleUseCase,
      withEmailUseCase: mockEmailUseCase,
      withGoogleUseCase: mockGoogleUseCase,
    );
  });

  group('loginWithGoogle', () {
    test('should emit ErrorState when Google sign-in fails', () async {
      final failure = NetworkFailure();
      when(mockGoogleUseCase.call()).thenAnswer((_) async => Left(failure));

      await viewModel.loginWithGoogle();

      expect(viewModel.loginState, isA<ErrorState<Failure, void>>());
      expect((viewModel.loginState as ErrorState).error, failure);
    });

    test('should emit ErrorState(LoginCanceledFailure) when user cancels Google sign-in', () async {
      when(mockGoogleUseCase.call()).thenAnswer((_) async => const Right(false));

      await viewModel.loginWithGoogle();

      expect(viewModel.loginState, isA<ErrorState<Failure, void>>());
      expect((viewModel.loginState as ErrorState).error, isA<LoginCanceledFailure>());
    });

    test('should call getUserData and emit SuccessState on Google sign-in success', () async {
      when(mockGoogleUseCase.call()).thenAnswer((_) async => const Right(true));
      when(mockUserService.isLoggedIn).thenReturn(true);
      when(mockGetUserDataUseCase.call()).thenAnswer((_) async => Right(fakeUser));

      await viewModel.loginWithGoogle();

      expect(viewModel.loginState, isA<SuccessState<Failure, void>>());
      verify(mockUserService.setUserData(fakeUser)).called(1);
    });
  });

  group('loginWithApple', () {
    test('should emit ErrorState when Apple sign-in fails', () async {
      final failure = NetworkFailure();
      when(mockAppleUseCase.call()).thenAnswer((_) async => Left(failure));

      await viewModel.loginWithApple();

      expect(viewModel.loginState, isA<ErrorState<Failure, void>>());
      expect((viewModel.loginState as ErrorState).error, failure);
    });

    test('should call getUserData and emit SuccessState on Apple sign-in success', () async {
      when(mockAppleUseCase.call()).thenAnswer((_) async => const Right(true));
      when(mockUserService.isLoggedIn).thenReturn(true);
      when(mockGetUserDataUseCase.call()).thenAnswer((_) async => Right(fakeUser));

      await viewModel.loginWithApple();

      expect(viewModel.loginState, isA<SuccessState<Failure, void>>());
      verify(mockUserService.setUserData(fakeUser)).called(1);
    });
  });

  group('loginWithEmail', () {
    test('should emit ErrorState(EmptyPasswordFailure) when password is too short', () async {
      viewModel.password = 'short';
      viewModel.email = testEmail;

      await viewModel.loginWithEmail();

      expect(viewModel.loginState, isA<ErrorState<Failure, void>>());
      expect((viewModel.loginState as ErrorState).error, isA<EmptyPasswordFailure>());
    });

    test('should emit ErrorState(EmailNotBeEmptyFailure) when email is empty', () async {
      viewModel.password = testPassword;
      viewModel.email = '';

      await viewModel.loginWithEmail();

      expect(viewModel.loginState, isA<ErrorState<Failure, void>>());
      expect((viewModel.loginState as ErrorState).error, isA<EmailNotBeEmptyFailure>());
    });

    test('should emit ErrorState(EmailNotValidFailure) when email is invalid', () async {
      viewModel.password = testPassword;
      viewModel.email = 'invalid-email';

      await viewModel.loginWithEmail();

      expect(viewModel.loginState, isA<ErrorState<Failure, void>>());
      expect((viewModel.loginState as ErrorState).error, isA<EmailNotValidFailure>());
    });

    test('should emit ErrorState when email sign-in fails', () async {
      viewModel.password = testPassword;
      viewModel.email = testEmail;
      final failure = NetworkFailure();
      when(mockEmailUseCase.call(testEmail, testPassword)).thenAnswer((_) async => Left(failure));

      await viewModel.loginWithEmail();

      expect(viewModel.loginState, isA<ErrorState<Failure, void>>());
      expect((viewModel.loginState as ErrorState).error, failure);
    });

    test('should call getUserData and emit SuccessState on email sign-in success', () async {
      viewModel.password = testPassword;
      viewModel.email = testEmail;
      when(mockEmailUseCase.call(testEmail, testPassword)).thenAnswer((_) async => const Right(true));
      when(mockUserService.isLoggedIn).thenReturn(true);
      when(mockGetUserDataUseCase.call()).thenAnswer((_) async => Right(fakeUser));

      await viewModel.loginWithEmail();

      expect(viewModel.loginState, isA<SuccessState<Failure, void>>());
      verify(mockUserService.setUserData(fakeUser)).called(1);
    });
  });

  group('getUserData', () {
    test('should do nothing when user is not logged in', () async {
      when(mockUserService.isLoggedIn).thenReturn(false);
      viewModel.loginState = InitialState();

      await viewModel.getUserData();

      expect(viewModel.loginState, isA<InitialState>());
      verifyNever(mockGetUserDataUseCase.call());
    });

    test('should emit ErrorState when getting user data fails', () async {
      when(mockUserService.isLoggedIn).thenReturn(true);
      final failure = NetworkFailure();
      when(mockGetUserDataUseCase.call()).thenAnswer((_) async => Left(failure));

      await viewModel.getUserData();

      expect(viewModel.loginState, isA<ErrorState<Failure, void>>());
      expect((viewModel.loginState as ErrorState).error, failure);
    });

    test('should set user data and emit SuccessState on success', () async {
      when(mockUserService.isLoggedIn).thenReturn(true);
      when(mockGetUserDataUseCase.call()).thenAnswer((_) async => Right(fakeUser));

      await viewModel.getUserData();

      expect(viewModel.loginState, isA<SuccessState<Failure, void>>());
      verify(mockUserService.setUserData(fakeUser)).called(1);
    });
  });
}
