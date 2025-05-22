import 'package:dartz/dartz.dart';
import 'package:tech_travel/src/core/errors/failure.dart';

abstract class ForgotPasswordRepository {
  Future<Either<Failure, void>> sendPasswordResetEmail(String email);
}
