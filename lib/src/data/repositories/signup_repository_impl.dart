import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:tech_travel/src/core/errors/already_registered_failure.dart';
import 'package:tech_travel/src/core/errors/api_failure.dart';
import 'package:tech_travel/src/core/errors/failure.dart';
import 'package:tech_travel/src/core/errors/network_failure.dart';
import 'package:tech_travel/src/data/api/api_client.dart';
import 'package:tech_travel/src/data/models/signup_model.dart';
import 'package:tech_travel/src/domain/repositories/signup_repository.dart';

class SignupRepositoryImpl extends SignupRepository {
  final ApiClient api;

  SignupRepositoryImpl(this.api);

  @override
  Future<Either<Failure, bool>> signup(SignupModel model) async {
    try {
      final response = await api.registerUser(model.toJson());

      if (response.response.statusCode == 200 || response.response.statusCode == 201) {
        return const Right(true);
      } else if (response.response.statusCode == 409) {
        // 409 == Already Registered
        return Left(AlreadyRegisteredFailure());
      } else {
        return Left(ApiFailure(message: 'Error code: ${response.response.statusCode} '));
      }
    } on SocketException catch (_) {
      return Left(NetworkFailure());
    } catch (_) {
      return Left(ApiFailure());
    }
  }
}
