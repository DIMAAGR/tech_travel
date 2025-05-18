import 'package:tech_travel/src/core/errors/failure.dart';

class CameraAccessFailure extends Failure {
  CameraAccessFailure({super.message = 'An error occurred while accessing the camera'});
}
