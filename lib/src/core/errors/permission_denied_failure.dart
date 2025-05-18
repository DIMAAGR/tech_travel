import 'package:tech_travel/src/core/errors/failure.dart';

class PermissionDeniedFailure extends Failure {
  PermissionDeniedFailure({super.message = 'Permission was not granted'});
}
