import 'package:tech_travel/src/core/errors/failure.dart';

class WeakPasswordFailure extends Failure {
  WeakPasswordFailure({super.message = 'passwordTooShort'});
}
