import 'package:mobx/mobx.dart';
import 'package:tech_travel/src/core/errors/email_not_be_empty_failure.dart';
import 'package:tech_travel/src/core/errors/email_not_valid_failure.dart';
import 'package:tech_travel/src/core/errors/empty_password_failure.dart';
import 'package:tech_travel/src/core/errors/failure.dart';
import 'package:tech_travel/src/core/errors/login_canceled_failure.dart';
import 'package:tech_travel/src/core/state/view_model_state.dart';
import 'package:tech_travel/src/core/validation/regex_validation.dart';
import 'package:tech_travel/src/data/services/user_service.dart';
import 'package:tech_travel/src/domain/usecases/sign_in_use_case.dart';
import 'package:tech_travel/src/domain/usecases/user_use_case.dart';

part 'login_view_model.g.dart';

class LoginViewModel = LoginViewModelBase with _$LoginViewModel;

abstract class LoginViewModelBase with Store {
  final SignInWithGoogleUseCase withGoogleUseCase;
  final SignInWithAppleUseCase withAppleUseCase;
  final SignInWithEmailUseCase withEmailUseCase;
  final GetUserDataUseCase getUserDataUseCase;
  final UserService userService;

  LoginViewModelBase({
    required this.userService,
    required this.getUserDataUseCase,
    required this.withAppleUseCase,
    required this.withEmailUseCase,
    required this.withGoogleUseCase,
  });

  String email = '';
  String password = '';

  void setEmail(String value) => email = value;
  void setPassword(String value) => password = value;

  @observable
  ViewModelState<Failure, void> loginState = InitialState();

  @action
  Future<void> loginWithGoogle() async {
    loginState = LoadingState();

    (await withGoogleUseCase()).fold(
      (e) => loginState = ErrorState(e),
      (s) => s ? getUserData() : loginState = ErrorState(LoginCanceledFailure()),
    );
  }

  @action
  Future<void> loginWithApple() async {
    loginState = LoadingState();

    (await withAppleUseCase()).fold(
      (e) => loginState = ErrorState(e),
      (s) => getUserData(),
    );
  }

  @action
  Future<void> loginWithEmail() async {
    if (password.length < 8) {
      loginState = ErrorState(EmptyPasswordFailure());
      return;
    }
    if (email.isEmpty) {
      loginState = ErrorState(EmailNotBeEmptyFailure());
      return;
    }
    if (!RegexValidation.isEmailValid(email)) {
      loginState = ErrorState(EmailNotValidFailure());
      return;
    }
    loginState = LoadingState();

    (await withEmailUseCase(email, password)).fold(
      (e) => loginState = ErrorState(e),
      (s) => getUserData(),
    );
  }

  @action
  Future<void> getUserData() async {
    if (!userService.isLoggedIn) {
      return;
    }
    final result = await getUserDataUseCase();
    result.fold(
      (failure) => loginState = ErrorState(failure),
      (user) {
        userService.setUserData(user);
        loginState = SuccessState(null);
      },
    );
  }
}
