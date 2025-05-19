import 'package:mobx/mobx.dart';
import 'package:tech_travel/src/core/di/injector.dart';
import 'package:tech_travel/src/core/errors/failure.dart';
import 'package:tech_travel/src/core/errors/not_match_failure.dart';
import 'package:tech_travel/src/core/errors/weak_password_failure.dart';
import 'package:tech_travel/src/core/services/firebase_services.dart';
import 'package:tech_travel/src/core/state/view_model_state.dart';
import 'package:tech_travel/src/data/models/signup_model.dart';
import 'package:tech_travel/src/domain/services/user_service.dart';
import 'package:tech_travel/src/domain/usecases/sign_in_use_case.dart';
import 'package:tech_travel/src/domain/usecases/sign_up_use_case.dart';
import 'package:uuid/uuid.dart';

part 'sign_up_view_model.g.dart';

class SignupViewModel = SignUpViewModelBase with _$SignupViewModel;

abstract class SignUpViewModelBase with Store {
  SignInWithGoogleUseCase withGoogleUseCase;
  SignInWithEmailUseCase withEmailUseCase;
  SignInWithAppleUseCase withAppleUseCase;
  SignUpUseCase signUpUseCase;

  UserService userService;

  SignUpViewModelBase({
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

  @observable
  ViewModelState<Failure, void> signupState = InitialState();

  @action
  Future<void> signupWithEmail() async {
    if (password != confirmPassword) {
      signupState = ErrorState(NotMatchFailure());
      return;
    }
    if (password.length < 8 || confirmPassword.length < 8) {
      signupState = ErrorState(WeakPasswordFailure());
      return;
    }

    (await withEmailUseCase(
      email,
      password,
    ))
        .fold(
      (e) => signupState = ErrorState(e),
      (s) => signup(),
    );
  }

  @action
  Future<void> signupWithGoogle() async {
    signupState = LoadingState();

    (await withGoogleUseCase()).fold(
      (e) => signupState = ErrorState(e),
      (s) => signup(),
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
    final data = SignupModel(
      email: userService.email!,
      firebaseUid: userService.uid!,
      password: const Uuid().v4(),
      username: userService.userName!,
    );

    (await signUpUseCase(data)).fold(
      (e) => signupState = ErrorState(e),
      (s) => signupState = SuccessState(null),
    );
  }
}
