import 'package:dartz/dartz.dart';
import 'package:tech_travel/src/core/errors/failure.dart';
import 'package:tech_travel/src/domain/entities/movie_entity.dart';
import 'package:tech_travel/src/domain/repositories/get_movie_repository.dart';

class GetMovieUseCase {
  final GetMovieRepository _repository;

  GetMovieUseCase(this._repository);

  Future<Either<Failure, MovieEntity>> call() {
    return _repository.getMovies();
  }
}
