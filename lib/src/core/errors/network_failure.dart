import 'package:tech_travel/src/core/errors/failure.dart';

class NetworkFailure extends Failure {
  NetworkFailure({super.message = 'noInternetConnection'});
}
