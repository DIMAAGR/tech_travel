import 'package:tech_travel/src/core/errors/failure.dart';

class NetworkFailure extends Failure {
  NetworkFailure({message = 'Not have internet connection'});
}
