import 'package:dartz/dartz.dart';
import 'package:tech_travel/src/core/errors/failure.dart';
import 'package:tech_travel/src/data/models/comments_model.dart';
import 'package:tech_travel/src/domain/entities/comments_entity.dart';

abstract class CommentsRepository {
  Future<Either<Failure, List<CommentsEntity>>> getComments(String id);
  Future<Either<Failure, CommentsEntity>> getLastComment(String id);
  Future<Either<Failure, void>> addComment(CommentsModel model);
}
