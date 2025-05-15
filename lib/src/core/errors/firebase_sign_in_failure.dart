import 'package:tech_travel/src/core/errors/failure.dart';

class FirebaseSignInFailure extends Failure {
  FirebaseSignInFailure({message = 'Sign-in error, invalid credentials or account not exists'});
}
