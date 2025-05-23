import 'package:dartz/dartz.dart';
import 'package:tech_travel/src/core/errors/failure.dart';
import 'package:tech_travel/src/domain/entities/subtitle_entity.dart';
import 'package:tech_travel/src/domain/repositories/subtitles_repository.dart';

class SubtitlesUseCase {
  final SubtitlesRepository _repository;

  SubtitlesUseCase(this._repository);

  Future<Either<Failure, SubtitlesEntity>> call(String movieId) {
    return _repository.getSubtitles(movieId);
  }
}
