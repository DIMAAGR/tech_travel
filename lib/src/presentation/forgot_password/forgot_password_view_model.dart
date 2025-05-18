import 'package:mobx/mobx.dart';

part 'forgot_password_view_model.g.dart';

class ForgotPasswordViewModel = ForgotPasswordViewModelBase with _$ForgotPasswordViewModel;

abstract class ForgotPasswordViewModelBase with Store {
  String email = '';

  void setEmail(String value) => email = value;
}
