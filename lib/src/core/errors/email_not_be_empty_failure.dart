import 'package:tech_travel/src/core/errors/failure.dart';

class EmailNotBeEmptyFailure extends Failure {
  EmailNotBeEmptyFailure({super.message = 'Email cannot be empty'});
}
