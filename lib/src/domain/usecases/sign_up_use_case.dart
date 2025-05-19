import 'package:dartz/dartz.dart';
import 'package:tech_travel/src/core/errors/failure.dart';
import 'package:tech_travel/src/data/models/signup_model.dart';
import 'package:tech_travel/src/domain/repositories/signup_repository.dart';

class SignUpUseCase {
  final SignupRepository _repository;

  SignUpUseCase(this._repository);

  Future<Either<Failure, bool>> call(SignupModel model) {
    return _repository.signup(model);
  }
}
