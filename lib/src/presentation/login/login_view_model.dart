import 'package:mobx/mobx.dart';

part 'login_view_model.g.dart';

class LoginViewModel = LoginViewModelBase with _$LoginViewModel;

abstract class LoginViewModelBase with Store {
  String email = '';
  String password = '';

  void setEmail(String value) => email = value;
  void setPassword(String value) => password = value;
}
