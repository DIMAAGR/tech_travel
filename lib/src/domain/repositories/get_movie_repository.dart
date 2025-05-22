import 'package:dartz/dartz.dart';
import 'package:tech_travel/src/core/errors/failure.dart';
import 'package:tech_travel/src/domain/entities/movie_entity.dart';

abstract class GetMovieRepository {
  Future<Either<Failure, MovieEntity>> getMovies();
}
