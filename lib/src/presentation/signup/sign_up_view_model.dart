import 'package:mobx/mobx.dart';
import 'package:tech_travel/src/core/errors/already_registered_failure.dart';
import 'package:tech_travel/src/core/errors/email_not_be_empty_failure.dart';
import 'package:tech_travel/src/core/errors/email_not_valid_failure.dart';
import 'package:tech_travel/src/core/errors/failure.dart';
import 'package:tech_travel/src/core/errors/login_canceled_failure.dart';
import 'package:tech_travel/src/core/errors/not_match_failure.dart';
import 'package:tech_travel/src/core/errors/weak_password_failure.dart';
import 'package:tech_travel/src/core/state/view_model_state.dart';
import 'package:tech_travel/src/core/validation/regex_validation.dart';
import 'package:tech_travel/src/data/models/signup_model.dart';
import 'package:tech_travel/src/data/services/user_service.dart';
import 'package:tech_travel/src/domain/usecases/sign_in_use_case.dart';
import 'package:tech_travel/src/domain/usecases/sign_up_use_case.dart';
import 'package:tech_travel/src/domain/usecases/user_use_case.dart';
import 'package:uuid/uuid.dart';

part 'sign_up_view_model.g.dart';

enum RequestType { signup, login }

class SignupViewModel = SignUpViewModelBase with _$SignupViewModel;

abstract class SignUpViewModelBase with Store {
  SignInWithGoogleUseCase withGoogleUseCase;
  SignUpWithEmailUseCase withEmailUseCase;
  SignInWithAppleUseCase withAppleUseCase;
  GetUserDataUseCase getUserDataUseCase;
  SignUpUseCase signUpUseCase;

  UserService userService;

  SignUpViewModelBase({
    required this.getUserDataUseCase,
    required this.withAppleUseCase,
    required this.withEmailUseCase,
    required this.withGoogleUseCase,
    required this.signUpUseCase,
    required this.userService,
  });

  String email = '';
  String password = '';
  String confirmPassword = '';

  void setEmail(String value) => email = value;
  void setPassword(String value) => password = value;
  void setConfirmPassword(String value) => confirmPassword = value;

  bool get isLoggedIn => userService.isLoggedIn;

  @observable
  ViewModelState<Failure, RequestType> signupState = InitialState();

  @action
  Future<void> signupWithEmail() async {
    signupState = LoadingState();
    if (password != confirmPassword) {
      signupState = ErrorState(NotMatchFailure());
      return;
    }
    if (password.length < 8 || confirmPassword.length < 8) {
      signupState = ErrorState(WeakPasswordFailure());
      return;
    }
    if (email.isEmpty) {
      signupState = ErrorState(EmailNotBeEmptyFailure());
      return;
    }
    if (!RegexValidation.isEmailValid(email)) {
      signupState = ErrorState(EmailNotValidFailure());
      return;
    }

    (await withEmailUseCase(email, password)).fold(
      (e) {
        signupState = ErrorState(e);
      },
      (s) => signup(),
    );
  }

  @action
  Future<void> signupWithGoogle() async {
    signupState = LoadingState();

    (await withGoogleUseCase()).fold(
      (e) => signupState = ErrorState(e),
      (s) => s ? signup() : signupState = ErrorState(LoginCanceledFailure()),
    );
  }

  Future<void> signupWithApple() async {
    signupState = LoadingState();

    (await withAppleUseCase()).fold(
      (e) => signupState = ErrorState(e),
      (s) => signup(),
    );
  }

  Future<void> signup() async {
    if (!userService.isLoggedIn) {
      return;
    }

    final data = SignupModel(
      email: userService.email!,
      firebaseUid: userService.uid!,
      password: password.isNotEmpty ? password : const Uuid().v4(),
      username: userService.userName ?? 'username${DateTime.now().millisecondsSinceEpoch}',
    );

    (await signUpUseCase(data)).fold(
      (e) {
        if (e is AlreadyRegisteredFailure) {
          getUserData();
        } else {
          signupState = ErrorState(e);
        }
      },
      (s) => signupState = SuccessState(RequestType.signup),
    );
  }

  @action
  Future<void> getUserData() async {
    final result = await getUserDataUseCase();
    result.fold(
      (failure) => signupState = ErrorState(failure),
      (user) {
        userService.setUserData(user);
        signupState = SuccessState(RequestType.login);
      },
    );
  }
}
