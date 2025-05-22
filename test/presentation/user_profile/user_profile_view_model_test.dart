import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:fake_async/fake_async.dart';

import 'package:tech_travel/src/core/errors/empty_password_failure.dart';
import 'package:tech_travel/src/core/errors/not_match_failure.dart';
import 'package:tech_travel/src/core/errors/username_required_failure.dart';
import 'package:tech_travel/src/core/errors/failure.dart';
import 'package:tech_travel/src/core/state/view_model_state.dart';
import 'package:tech_travel/src/data/models/update_me_model.dart';
import 'package:tech_travel/src/data/services/user_service.dart';
import 'package:tech_travel/src/domain/usecases/update_user_use_case.dart';
import 'package:tech_travel/src/domain/usecases/user_use_case.dart';
import 'package:tech_travel/src/presentation/user_profile/user_profile_view_model.dart';

import 'user_profile_view_model_test.mocks.dart';

@GenerateMocks([
  LogoutUseCase,
  DeleteAccountUseCase,
  UpdateUserUseCase,
  UserService,
])
void main() {
  late MockLogoutUseCase mockLogoutUseCase;
  late MockDeleteAccountUseCase mockDeleteAccountUseCase;
  late MockUpdateUserUseCase mockUpdateUserUseCase;
  late MockUserService mockUserService;
  late UserProfileViewModel viewModel;

  const testUsername = 'new_username';
  const userId = 'user-123';

  setUp(() {
    mockLogoutUseCase = MockLogoutUseCase();
    mockDeleteAccountUseCase = MockDeleteAccountUseCase();
    mockUpdateUserUseCase = MockUpdateUserUseCase();
    mockUserService = MockUserService();

    // stub uid getter

    when(mockUserService.uid).thenReturn(userId);

    viewModel = UserProfileViewModel(
      updateUserUseCase: mockUpdateUserUseCase,
      deleteAccountUseCase: mockDeleteAccountUseCase,
      userService: mockUserService,
      logoutUseCase: mockLogoutUseCase,
    );
  });

  group('logout', () {
    test('should go from InitialState → LoadingState → SuccessState and clear data on success', () async {
      when(mockLogoutUseCase.call()).thenAnswer((_) async => Right(true));

      expect(viewModel.exitableState, isA<InitialState>());

      final future = viewModel.logout();
      // immediately after calling
      expect(viewModel.exitableState, isA<LoadingState<Failure, bool>>());

      await future;
      expect(viewModel.exitableState, isA<SuccessState<Failure, bool>>());
      verify(mockUserService.clearUserData()).called(1);
    });

    test('should go to ErrorState and not clear data on failure', () async {
      final failure = UsernameRequiredFailure();
      when(mockLogoutUseCase.call()).thenAnswer((_) async => Left(failure));

      final future = viewModel.logout();
      expect(viewModel.exitableState, isA<LoadingState<Failure, bool>>());

      await future;
      expect(viewModel.exitableState, isA<ErrorState<Failure, bool>>());
      expect((viewModel.exitableState as ErrorState).error, failure);
      verifyNever(mockUserService.clearUserData());
    });
  });

  group('updateName', () {
    test('should emit ErrorState(UsernameRequiredFailure) if username is empty', () async {
      viewModel.username = '';
      await viewModel.updateName();
      expect(viewModel.userProfileState, isA<ErrorState<Failure, bool>>());
      expect((viewModel.userProfileState as ErrorState).error, isA<UsernameRequiredFailure>());
    });

    test('should go InitialState → LoadingState → SuccessState and update data on success', () async {
      viewModel.username = testUsername;
      when(mockUpdateUserUseCase.call(UpdateMeModel(username: testUsername))).thenAnswer((_) async => Right(true));

      expect(viewModel.userProfileState, isA<InitialState>());

      final future = viewModel.updateName();
      expect(viewModel.userProfileState, isA<LoadingState<Failure, bool>>());

      await future;
      expect(viewModel.userProfileState, isA<SuccessState<Failure, bool>>());
      verify(mockUserService.updateUserData(username: testUsername)).called(1);
    });

    test('should go to ErrorState on update failure', () async {
      viewModel.username = testUsername;
      final failure = UsernameRequiredFailure();
      when(mockUpdateUserUseCase.call(UpdateMeModel(username: testUsername))).thenAnswer((_) async => Left(failure));

      final future = viewModel.updateName();
      expect(viewModel.userProfileState, isA<LoadingState<Failure, bool>>());

      await future;
      expect(viewModel.userProfileState, isA<ErrorState<Failure, bool>>());
      expect((viewModel.userProfileState as ErrorState).error, failure);
      verifyNever(mockUserService.updateUserData(username: anyNamed('username')));
    });
  });

  group('updatePassword', () {
    test('should emit ErrorState(EmptyPasswordFailure) if any field is empty', () async {
      viewModel.password = '';
      viewModel.newPassword = 'new';
      viewModel.confirmNewPassword = 'new';

      await viewModel.updatePassword();
      expect(viewModel.userProfileState, isA<ErrorState<Failure, bool>>());
      expect((viewModel.userProfileState as ErrorState).error, isA<EmptyPasswordFailure>());
    });

    test('should emit ErrorState(NotMatchFailure) if newPassword ≠ confirmNewPassword', () async {
      viewModel.password = 'old';
      viewModel.newPassword = 'one';
      viewModel.confirmNewPassword = 'two';

      await viewModel.updatePassword();
      expect(viewModel.userProfileState, isA<ErrorState<Failure, bool>>());
      expect((viewModel.userProfileState as ErrorState).error, isA<NotMatchFailure>());
    });

    test('should go InitialState → LoadingState → SuccessState after delay when inputs valid', () {
      viewModel.password = 'old';
      viewModel.newPassword = 'new';
      viewModel.confirmNewPassword = 'new';

      fakeAsync((async) {
        expect(viewModel.userProfileState, isA<InitialState>());

        viewModel.updatePassword();
        expect(viewModel.userProfileState, isA<LoadingState<Failure, bool>>());

        async.elapse(const Duration(seconds: 2));
        expect(viewModel.userProfileState, isA<SuccessState<Failure, bool>>());
      });
    });
  });

  group('deleteAccount', () {
    test('should go InitialState → LoadingState → SuccessState and clear data on success', () async {
      when(mockDeleteAccountUseCase.call(userId)).thenAnswer((_) async => Right(true));

      expect(viewModel.exitableState, isA<InitialState>());

      final future = viewModel.deleteAccount();
      expect(viewModel.exitableState, isA<LoadingState<Failure, bool>>());

      await future;
      expect(viewModel.exitableState, isA<SuccessState<Failure, bool>>());
      verify(mockUserService.clearUserData()).called(1);
    });

    test('should go to ErrorState on failure and not clear data', () async {
      final failure = UsernameRequiredFailure();
      when(mockDeleteAccountUseCase.call(userId)).thenAnswer((_) async => Left(failure));

      final future = viewModel.deleteAccount();
      expect(viewModel.exitableState, isA<LoadingState<Failure, bool>>());

      await future;
      expect(viewModel.exitableState, isA<ErrorState<Failure, bool>>());
      expect((viewModel.exitableState as ErrorState).error, failure);
      verifyNever(mockUserService.clearUserData());
    });
  });

  group('terminateSubscriptionPlan', () {
    test('should go InitialState → LoadingState → SuccessState after delay', () {
      fakeAsync((async) {
        expect(viewModel.userProfileState, isA<InitialState>());

        viewModel.terminateSubscriptionPlan();
        expect(viewModel.userProfileState, isA<LoadingState<Failure, bool>>());

        async.elapse(const Duration(seconds: 2));
        expect(viewModel.userProfileState, isA<SuccessState<Failure, bool>>());
      });
    });
  });
}
