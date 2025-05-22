import 'package:mobx/mobx.dart';
import 'package:tech_travel/src/core/errors/email_not_be_empty_failure.dart';
import 'package:tech_travel/src/core/errors/email_not_valid_failure.dart';
import 'package:tech_travel/src/core/errors/failure.dart';
import 'package:tech_travel/src/core/state/view_model_state.dart';
import 'package:tech_travel/src/core/validation/regex_validation.dart';
import 'package:tech_travel/src/domain/usecases/forgot_password_use_case.dart';

part 'forgot_password_view_model.g.dart';

class ForgotPasswordViewModel = ForgotPasswordViewModelBase with _$ForgotPasswordViewModel;

abstract class ForgotPasswordViewModelBase with Store {
  final ForgotPasswordUseCase forgotPasswordUseCase;

  ForgotPasswordViewModelBase({
    required this.forgotPasswordUseCase,
  });

  String email = '';

  void setEmail(String value) => email = value;

  @observable
  ViewModelState<Failure, void> forgotPasswordState = InitialState();

  @action
  Future<void> forgotPassword() async {
    forgotPasswordState = LoadingState();

    if (email.isEmpty) {
      forgotPasswordState = ErrorState(EmailNotBeEmptyFailure());
      return;
    } else if (!RegexValidation.isEmailValid(email)) {
      forgotPasswordState = ErrorState(EmailNotValidFailure());
      return;
    }

    final result = await forgotPasswordUseCase(email);
    result.fold(
      (failure) => forgotPasswordState = ErrorState(failure),
      (success) => forgotPasswordState = SuccessState(success),
    );
    forgotPasswordState = SuccessState(null);
  }
}
