import 'package:dartz/dartz.dart';
import 'package:tech_travel/src/core/errors/failure.dart';
import 'package:tech_travel/src/data/models/signup_model.dart';

abstract class SignupRepository {
  Future<Either<Failure, bool>> signup(SignupModel model);
}
