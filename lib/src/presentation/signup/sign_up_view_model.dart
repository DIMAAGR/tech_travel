import 'package:mobx/mobx.dart';
import 'package:tech_travel/src/core/errors/failure.dart';
import 'package:tech_travel/src/core/errors/not_match_failure.dart';
import 'package:tech_travel/src/core/errors/weak_password_failure.dart';
import 'package:tech_travel/src/core/state/view_model_state.dart';

part 'sign_up_view_model.g.dart';

class SignupViewModel = SignUpViewModelBase with _$SignupViewModel;

abstract class SignUpViewModelBase with Store {
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
  }
}
