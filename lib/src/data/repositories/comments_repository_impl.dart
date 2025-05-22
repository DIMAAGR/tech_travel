import 'package:dartz/dartz.dart';
import 'package:tech_travel/src/core/errors/comments_failure.dart';
import 'package:tech_travel/src/core/errors/failure.dart';
import 'package:tech_travel/src/core/services/comments_serivce.dart';
import 'package:tech_travel/src/data/models/comments_model.dart';
import 'package:tech_travel/src/domain/entities/comments_entity.dart';
import 'package:tech_travel/src/domain/repositories/comments_repository.dart';

class CommentsRepositoryImpl implements CommentsRepository {
  final CommentService _service;

  CommentsRepositoryImpl(this._service);
  @override
  Future<Either<Failure, List<CommentsEntity>>> getComments(String id) async {
    try {
      final result = await _service.getAllComments(id);
      final comments = result.map((e) => CommentsModel.fromJson(e)).toList();

      return Right(comments);
    } catch (_) {
      return Left(CommentsFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addComment(CommentsModel model) async {
    try {
      await _service.addComment(
        comment: model.comment!,
        movieId: model.movie!,
        user: model.user!.toJson(),
      );
      return const Right(null);
    } catch (_) {
      return Left(CommentsFailure());
    }
  }

  @override
  Future<Either<Failure, CommentsEntity>> getLastComment(String id) async {
    try {
      final result = await _service.getLastComment(id);
      return Right(CommentsModel.fromJson(result ?? {}));
    } catch (_) {
      return Left(CommentsFailure());
    }
  }
}
