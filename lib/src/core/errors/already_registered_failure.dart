import 'package:tech_travel/src/core/errors/failure.dart';

class AlreadyRegisteredFailure extends Failure {
  AlreadyRegisteredFailure({super.message = 'User already registered'});
}
