import 'package:tech_travel/src/core/errors/failure.dart';

class EmailNotValidFailure extends Failure {
  EmailNotValidFailure({super.message = 'Email is not valid'});
}
