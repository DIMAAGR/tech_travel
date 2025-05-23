import 'package:tech_travel/src/core/errors/failure.dart';

class UsernameRequiredFailure extends Failure {
  UsernameRequiredFailure({super.message = 'Please enter a username'});
}
