import 'package:dartz/dartz.dart';
import 'package:tech_travel/src/core/errors/failure.dart';
import 'package:tech_travel/src/data/models/update_me_model.dart';
import 'package:tech_travel/src/domain/repositories/user_repository.dart';

class UpdateUserUseCase {
  final UserRepository _repository;

  UpdateUserUseCase(this._repository);

  Future<Either<Failure, bool>> call(UpdateMeModel model) {
    return _repository.updateUser(model);
  }
}
