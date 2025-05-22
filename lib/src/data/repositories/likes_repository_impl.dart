import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tech_travel/src/core/errors/api_failure.dart';
import 'package:tech_travel/src/core/errors/failure.dart';
import 'package:tech_travel/src/core/errors/network_failure.dart';
import 'package:tech_travel/src/data/api/api_client.dart';
import 'package:tech_travel/src/data/models/add_like_model.dart';
import 'package:tech_travel/src/data/models/likes_model.dart';
import 'package:tech_travel/src/domain/repositories/likes_repository.dart';

class LikesRepositoryImpl implements LikesRepository {
  final ApiClient api;
  LikesRepositoryImpl(this.api);

  @override
  Future<Either<Failure, LikesModel>> getLikes() async {
    try {
      final response = await api.getLikes();
      return Right(response);
    } on SocketException {
      return Left(NetworkFailure());
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      return Left(ApiFailure(message: 'Error code: $statusCode'));
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> likePost(AddLikeModel likeModel) async {
    try {
      await api.postLike(likeModel.toJson());
      return const Right(null);
    } on SocketException {
      return Left(NetworkFailure());
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      return Left(ApiFailure(message: 'Error code: $statusCode'));
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> unlikePost(String likeId) async {
    try {
      await api.deleteLike(likeId);
      return const Right(null);
    } on SocketException {
      return Left(NetworkFailure());
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      return Left(ApiFailure(message: 'Error code: $statusCode'));
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
