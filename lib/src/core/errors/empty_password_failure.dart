import 'package:tech_travel/src/core/errors/failure.dart';

class EmptyPasswordFailure extends Failure {
  EmptyPasswordFailure({super.message = 'Please enter a password'});
}
