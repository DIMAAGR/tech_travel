import 'package:dartz/dartz.dart';
import 'package:tech_travel/src/core/errors/failure.dart';
import 'package:tech_travel/src/data/models/update_me_model.dart';
import 'package:tech_travel/src/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<Either<Failure, bool>> updateUser(UpdateMeModel model);
  Future<Either<Failure, bool>> logout();
  Future<Either<Failure, bool>> deleteAccount(String id);
  Future<Either<Failure, UserEntity>> getUserData();
}
