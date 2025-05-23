import 'package:dartz/dartz.dart';
import 'package:tech_travel/src/core/errors/failure.dart';
import 'package:tech_travel/src/domain/entities/subtitle_entity.dart';

abstract class SubtitlesRepository {
  Future<Either<Failure, SubtitlesEntity>> getSubtitles(String movieId);
}
