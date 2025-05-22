import 'package:dartz/dartz.dart';
import 'package:tech_travel/src/core/errors/failure.dart';
import 'package:tech_travel/src/domain/entities/user_entity.dart';
import 'package:tech_travel/src/domain/repositories/user_repository.dart';

class LogoutUseCase {
  final UserRepository _repository;

  LogoutUseCase(this._repository);

  Future<Either<Failure, bool>> call() {
    return _repository.logout();
  }
}

class GetUserDataUseCase {
  final UserRepository _repository;

  GetUserDataUseCase(this._repository);

  Future<Either<Failure, UserEntity>> call() {
    return _repository.getUserData();
  }
}

class DeleteAccountUseCase {
  final UserRepository _repository;

  DeleteAccountUseCase(this._repository);

  Future<Either<Failure, bool>> call(String id) {
    return _repository.deleteAccount(id);
  }
}
