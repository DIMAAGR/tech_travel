import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:tech_travel/src/core/errors/api_failure.dart';
import 'package:tech_travel/src/core/errors/failure.dart';
import 'package:tech_travel/src/core/errors/network_failure.dart';
import 'package:tech_travel/src/data/api/api_client.dart';
import 'package:tech_travel/src/data/models/update_me_model.dart';
import 'package:tech_travel/src/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final ApiClient api;

  UserRepositoryImpl(this.api);

  @override
  Future<Either<Failure, bool>> updateUser(UpdateMeModel model) async {
    try {
      final response = await api.updateMe(model.toJson());

      final statusCode = response.response.statusCode;
      if (statusCode == 200 || statusCode == 201) {
        return const Right(true);
      } else if (statusCode == 400) {
        return Left(ApiFailure(message: 'Invalid update data'));
      } else {
        return Left(ApiFailure(message: 'Error code: $statusCode'));
      }
    } on SocketException {
      return Left(NetworkFailure());
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
