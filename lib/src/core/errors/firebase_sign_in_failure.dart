import 'package:tech_travel/src/core/errors/failure.dart';

class FirebaseSignInFailure extends Failure {
  FirebaseSignInFailure({super.message = 'Sign-in error, invalid credentials or account not exists'});
}
