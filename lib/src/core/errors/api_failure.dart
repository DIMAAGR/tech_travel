import 'package:tech_travel/src/core/errors/failure.dart';

class ApiFailure extends Failure {
  ApiFailure({super.message = 'Unexpected status code'});
}
