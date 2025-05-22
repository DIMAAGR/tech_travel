import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tech_travel/src/core/errors/api_failure.dart';
import 'package:tech_travel/src/core/errors/failure.dart';
import 'package:tech_travel/src/core/errors/network_failure.dart';
import 'package:tech_travel/src/data/api/api_client.dart';
import 'package:tech_travel/src/domain/entities/movie_entity.dart';
import 'package:tech_travel/src/domain/repositories/get_movie_repository.dart';

class GetMovieRepositoryImpl implements GetMovieRepository {
  final ApiClient api;

  GetMovieRepositoryImpl(this.api);
  @override
  Future<Either<Failure, MovieEntity>> getMovies() async {
    try {
      final response = await api.getMovies();
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
}
