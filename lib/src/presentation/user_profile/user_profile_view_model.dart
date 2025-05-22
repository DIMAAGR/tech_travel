import 'package:mobx/mobx.dart';
import 'package:tech_travel/src/core/errors/empty_password_failure.dart';
import 'package:tech_travel/src/core/errors/failure.dart';
import 'package:tech_travel/src/core/errors/not_match_failure.dart';
import 'package:tech_travel/src/core/errors/username_required_failure.dart';
import 'package:tech_travel/src/core/state/view_model_state.dart';
import 'package:tech_travel/src/data/models/update_me_model.dart';
import 'package:tech_travel/src/data/services/user_service.dart';
import 'package:tech_travel/src/domain/usecases/update_user_use_case.dart';
import 'package:tech_travel/src/domain/usecases/user_use_case.dart';

part 'user_profile_view_model.g.dart';

class UserProfileViewModel = UserProfileViewModelBase with _$UserProfileViewModel;

abstract class UserProfileViewModelBase with Store {
  final LogoutUseCase logoutUseCase;
  final DeleteAccountUseCase deleteAccountUseCase;
  final UpdateUserUseCase updateUserUseCase;
  final UserService userService;

  UserProfileViewModelBase({
    required this.updateUserUseCase,
    required this.deleteAccountUseCase,
    required this.userService,
    required this.logoutUseCase,
  });

  final String profilePhotoURL = 'https://i.pinimg.com/736x/ac/33/56/ac33563b6de9253a779883dca00a5692.jpg';

  String username = '';
  String password = '';
  String newPassword = '';
  String confirmNewPassword = '';

  @observable
  ViewModelState<Failure, bool> exitableState = InitialState();

  @observable
  ViewModelState<Failure, bool> userProfileState = InitialState();

  void setName(String value) => username = value;
  void setPassword(String value) => password = value;
  void setNewPassword(String value) => newPassword = value;
  void setConfirmNewPassword(String value) => confirmNewPassword = value;

  @action
  Future<void> logout() async {
    exitableState = LoadingState();
    final result = await logoutUseCase.call();
    result.fold(
      (failure) => exitableState = ErrorState(failure),
      (success) {
        userService.clearUserData();
        exitableState = SuccessState(success);
      },
    );
  }

  @action
  Future<void> updateName() async {
    if (username.isEmpty) {
      userProfileState = ErrorState(UsernameRequiredFailure());
      return;
    }

    userProfileState = LoadingState();
    final result = await updateUserUseCase.call(UpdateMeModel(username: username));
    result.fold(
      (failure) => userProfileState = ErrorState(failure),
      (success) {
        userService.updateUserData(username: username);
        userProfileState = SuccessState(success);
      },
    );
  }

  Future<void> updatePassword() async {
    if (password.isEmpty || newPassword.isEmpty || confirmNewPassword.isEmpty) {
      userProfileState = ErrorState(EmptyPasswordFailure());
      return;
    }
    if (newPassword != confirmNewPassword) {
      userProfileState = ErrorState(NotMatchFailure());
      return;
    }

    userProfileState = LoadingState();
    // Example of how to call the update password use case
    // final result = await updatePasswordUseCase.call(UpdatePasswordModel(password: newPassword));
    // result.fold(
    //   (failure) => userProfileState = ErrorState(failure),
    //   (success) {
    //     userService.updateUserData(password: newPassword);
    //     userProfileState = SuccessState(success);
    //   },
    // );

    // Notes: It would not be possible to change the password since there
    // is no endpoint that returns information on whether the password
    // the user entered as the current one is actually the valid password.

    // Simulating a successful password update
    await Future.delayed(const Duration(seconds: 2));

    userProfileState = SuccessState(true);
  }

  Future<void> deleteAccount() async {
    exitableState = LoadingState();
    final result = await deleteAccountUseCase.call(userService.uid!);
    result.fold(
      (failure) => exitableState = ErrorState(failure),
      (success) async {
        userService.clearUserData();
        exitableState = SuccessState(success);
      },
    );
  }

  Future<void> terminateSubscriptionPlan() async {
    // Implement the logic to terminate the subscription plan
    // This could involve calling an API or performing some other action
    // For now, we'll just simulate a successful termination
    userProfileState = LoadingState();
    await Future.delayed(const Duration(seconds: 2));
    userProfileState = SuccessState(true);
  }
}
