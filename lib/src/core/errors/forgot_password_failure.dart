import 'package:tech_travel/src/core/errors/failure.dart';

class ForgotPasswordFailure extends Failure {
  ForgotPasswordFailure({super.message = 'Failed to send password reset email'});
}
