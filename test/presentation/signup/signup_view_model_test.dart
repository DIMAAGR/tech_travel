// sign_up_view_model_test.dart

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:tech_travel/src/core/errors/failure.dart';
import 'package:tech_travel/src/core/errors/not_match_failure.dart';
import 'package:tech_travel/src/core/errors/weak_password_failure.dart';
import 'package:tech_travel/src/core/state/view_model_state.dart';
import 'package:tech_travel/src/data/services/user_service.dart';
import 'package:tech_travel/src/domain/usecases/sign_in_use_case.dart';
import 'package:tech_travel/src/domain/usecases/sign_up_use_case.dart';
import 'package:tech_travel/src/domain/usecases/user_use_case.dart';
import 'package:tech_travel/src/presentation/signup/sign_up_view_model.dart';

@GenerateMocks([
  SignInWithGoogleUseCase,
  SignUpWithEmailUseCase,
  SignInWithAppleUseCase,
  SignUpUseCase,
  UserService,
  GetUserDataUseCase,
])
import 'signup_view_model_test.mocks.dart';

void main() {
  late SignupViewModel viewModel;
  late MockSignInWithGoogleUseCase mockGoogleUseCase;
  late MockSignUpWithEmailUseCase mockEmailUseCase;
  late MockSignInWithAppleUseCase mockAppleUseCase;
  late MockSignUpUseCase mockSignUpUseCase;
  late MockUserService mockUserService;
  late MockGetUserDataUseCase mockGetUserDataUseCase;

  setUp(() {
    mockGoogleUseCase = MockSignInWithGoogleUseCase();
    mockEmailUseCase = MockSignUpWithEmailUseCase();
    mockAppleUseCase = MockSignInWithAppleUseCase();
    mockSignUpUseCase = MockSignUpUseCase();
    mockUserService = MockUserService();
    mockGetUserDataUseCase = MockGetUserDataUseCase();

    viewModel = SignupViewModel(
      withGoogleUseCase: mockGoogleUseCase,
      withEmailUseCase: mockEmailUseCase,
      withAppleUseCase: mockAppleUseCase,
      signUpUseCase: mockSignUpUseCase,
      userService: mockUserService,
      getUserDataUseCase: mockGetUserDataUseCase,
    );
  });

  group('isLoggedIn', () {
    test('should reflect userService.isLoggedIn', () {
      when(mockUserService.isLoggedIn).thenReturn(true);
      expect(viewModel.isLoggedIn, isTrue);

      when(mockUserService.isLoggedIn).thenReturn(false);
      expect(viewModel.isLoggedIn, isFalse);
    });
  });

  group('signupWithEmail', () {
    test('emits ErrorState NotMatchFailure when passwords do not match', () async {
      viewModel.setEmail('test@example.com');
      viewModel.setPassword('password123');
      viewModel.setConfirmPassword('password321');

      await viewModel.signupWithEmail();

      expect(viewModel.signupState, isA<ErrorState<Failure, void>>());
      expect((viewModel.signupState as ErrorState).error, isA<NotMatchFailure>());
      verifyZeroInteractions(mockEmailUseCase);
    });

    test('emits ErrorState WeakPasswordFailure when password is too short', () async {
      viewModel.setEmail('test@example.com');
      viewModel.setPassword('short');
      viewModel.setConfirmPassword('short');

      await viewModel.signupWithEmail();

      expect(viewModel.signupState, isA<ErrorState<Failure, void>>());
      expect((viewModel.signupState as ErrorState).error, isA<WeakPasswordFailure>());
      verifyZeroInteractions(mockEmailUseCase);
    });

    test('emits ErrorState when email useCase returns failure', () async {
      viewModel.setEmail('test@example.com');
      viewModel.setPassword('validPass1');
      viewModel.setConfirmPassword('validPass1');
      when(mockEmailUseCase('test@example.com', 'validPass1')).thenAnswer((_) async => Left(NotMatchFailure()));

      await viewModel.signupWithEmail();

      expect(viewModel.signupState, isA<ErrorState<Failure, void>>());
      expect((viewModel.signupState as ErrorState).error, isA<NotMatchFailure>());
    });

    test('on success of email useCase, calls signup and emits SuccessState', () async {
      viewModel.setEmail('user@mail.com');
      viewModel.setPassword('strongPass');
      viewModel.setConfirmPassword('strongPass');
      when(mockEmailUseCase(any, any)).thenAnswer((_) async => const Right(null));

      when(mockUserService.isLoggedIn).thenReturn(true);
      when(mockUserService.email).thenReturn('user@mail.com');
      when(mockUserService.uid).thenReturn('uid123');
      when(mockUserService.userName).thenReturn('username');

      when(mockSignUpUseCase(any)).thenAnswer((_) async => const Right(true));

      await viewModel.signupWithEmail();

      expect(viewModel.signupState, isA<SuccessState<Failure, void>>());
    });
  });

  group('signupWithGoogle', () {
    test('emits ErrorState when Google sign-in fails', () async {
      when(mockGoogleUseCase()).thenAnswer((_) async => Left(NotMatchFailure()));

      await viewModel.signupWithGoogle();

      expect(viewModel.signupState, isA<ErrorState<Failure, void>>());
      expect((viewModel.signupState as ErrorState).error, isA<NotMatchFailure>());
    });

    test('on success of Google sign-in, calls signup and emits SuccessState', () async {
      when(mockGoogleUseCase()).thenAnswer((_) async => const Right(true));

      when(mockUserService.isLoggedIn).thenReturn(true);
      when(mockUserService.email).thenReturn('guser@mail.com');
      when(mockUserService.uid).thenReturn('uidGoogle');
      when(mockUserService.userName).thenReturn(null);

      when(mockSignUpUseCase(any)).thenAnswer((_) async => const Right(true));

      await viewModel.signupWithGoogle();

      expect(viewModel.signupState, isA<SuccessState<Failure, void>>());
    });
  });

  group('signupWithApple', () {
    test('emits ErrorState when Apple sign-in fails', () async {
      when(mockAppleUseCase()).thenAnswer((_) async => Left(NotMatchFailure()));

      await viewModel.signupWithApple();

      expect(viewModel.signupState, isA<ErrorState<Failure, void>>());
      expect((viewModel.signupState as ErrorState).error, isA<NotMatchFailure>());
    });

    test('on success of Apple sign-in, calls signup and emits SuccessState', () async {
      when(mockAppleUseCase()).thenAnswer((_) async => const Right(null));

      when(mockUserService.isLoggedIn).thenReturn(true);
      when(mockUserService.email).thenReturn('apple@mail.com');
      when(mockUserService.uid).thenReturn('uidApple');
      when(mockUserService.userName).thenReturn('');

      when(mockSignUpUseCase(any)).thenAnswer((_) async => const Right(true));

      await viewModel.signupWithApple();
      await Future.delayed(Duration.zero);

      expect(viewModel.signupState, isA<SuccessState<Failure, void>>());
    });
  });
}
