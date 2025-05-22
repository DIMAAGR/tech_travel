import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tech_travel/src/core/errors/api_failure.dart';
import 'package:tech_travel/src/core/errors/failure.dart';
import 'package:tech_travel/src/core/errors/network_failure.dart';
import 'package:tech_travel/src/core/services/firebase_services.dart';
import 'package:tech_travel/src/data/api/api_client.dart';
import 'package:tech_travel/src/data/models/update_me_model.dart';
import 'package:tech_travel/src/domain/entities/user_entity.dart';
import 'package:tech_travel/src/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final ApiClient api;
  final FirebaseAuthService firebaseAuthService;

  UserRepositoryImpl(this.api, this.firebaseAuthService);

  @override
  Future<Either<Failure, bool>> updateUser(UpdateMeModel model) async {
    try {
      await api.updateMe(model.toJson());
      return const Right(true);
    } on SocketException {
      return Left(NetworkFailure());
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      if (statusCode != null && statusCode == 400) {
        return Left(ApiFailure(message: 'Invalid update data'));
      } else {
        return Left(ApiFailure(message: 'Error code: $statusCode'));
      }
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    try {
      await firebaseAuthService.logout();
      return const Right(true);
    } on SocketException {
      return Left(NetworkFailure());
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteAccount(String id) async {
    try {
      await api.deleteUser(id);
      return const Right(true);
    } on SocketException {
      return Left(NetworkFailure());
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      if (statusCode != null && statusCode == 400) {
        return Left(ApiFailure(message: 'Unable to delete account'));
      } else {
        return Left(ApiFailure(message: 'Error code: $statusCode'));
      }
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getUserData() async {
    try {
      final response = await api.getCurrentUser();
      return Right(response);
    } on SocketException {
      return Left(NetworkFailure());
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      if (statusCode != null && statusCode == 400) {
        return Left(ApiFailure(message: 'Unable to delete account'));
      } else {
        return Left(ApiFailure(message: 'Error code: $statusCode'));
      }
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
