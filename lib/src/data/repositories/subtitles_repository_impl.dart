import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tech_travel/src/core/errors/api_failure.dart';
import 'package:tech_travel/src/core/errors/failure.dart';
import 'package:tech_travel/src/core/errors/network_failure.dart';
import 'package:tech_travel/src/data/api/api_client.dart';
import 'package:tech_travel/src/domain/entities/subtitle_entity.dart';
import 'package:tech_travel/src/domain/repositories/subtitles_repository.dart';

class SubtitlesRepositoryImpl implements SubtitlesRepository {
  final ApiClient api;

  SubtitlesRepositoryImpl(this.api);
  @override
  Future<Either<Failure, SubtitlesEntity>> getSubtitles(String movieId) async {
    try {
      final response = await api.getSubtitles(int.parse(movieId));
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
