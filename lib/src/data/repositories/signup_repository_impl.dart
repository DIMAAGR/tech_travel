import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
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
  @override
  Future<Either<Failure, bool>> signup(SignupModel model) async {
    try {
      await api.registerUser(model.toJson());
      return const Right(true);
    } on SocketException {
      return Left(NetworkFailure());
    } on DioException catch (e) {
      final response = e.response;
      final data = (response?.data as Map<String, dynamic>?) ?? {};
      final errorMsg = data['error'] is Map ? (data['error']!['message'] as String?) : null;

      if (errorMsg == 'Email or Username are already taken') {
        return Left(AlreadyRegisteredFailure());
      }

      final code = response?.statusCode;
      return Left(
        ApiFailure(
          message: code != null ? 'Error code: $code' : 'Unknown API error',
        ),
      );
    } catch (_) {
      return Left(ApiFailure());
    }
  }
}
