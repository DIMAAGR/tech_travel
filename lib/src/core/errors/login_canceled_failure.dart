import 'package:tech_travel/src/core/errors/failure.dart';

class LoginCanceledFailure extends Failure {
  LoginCanceledFailure({super.message = 'Login was canceled by the user.'});
}
