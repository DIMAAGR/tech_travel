import 'package:dartz/dartz.dart';
import 'package:tech_travel/src/core/errors/failure.dart';
import 'package:tech_travel/src/data/models/update_me_model.dart';

abstract class UserRepository {
  Future<Either<Failure, bool>> updateUser(UpdateMeModel model);
}
