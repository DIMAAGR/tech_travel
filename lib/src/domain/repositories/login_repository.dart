import 'package:dartz/dartz.dart';
import 'package:tech_travel/src/core/errors/failure.dart';

abstract class LoginRepository {
  Future<Either<Failure, void>> signInWithGoogle();
  Future<Either<Failure, void>> signInWithApple();
  Future<Either<Failure, void>> signInWithEmail(String email, String password);
}
