import 'package:dartz/dartz.dart';
import 'package:tech_travel/src/core/errors/failure.dart';
import 'package:tech_travel/src/data/models/comments_model.dart';
import 'package:tech_travel/src/domain/entities/comments_entity.dart';
import 'package:tech_travel/src/domain/repositories/comments_repository.dart';

class GetAllCommentsUseCase {
  GetAllCommentsUseCase(this._repository);

  final CommentsRepository _repository;

  Future<Either<Failure, List<CommentsEntity>>> call(String movieId) async {
    return _repository.getComments(movieId);
  }
}

class GetLastCommentUseCase {
  GetLastCommentUseCase(this._repository);

  final CommentsRepository _repository;

  Future<Either<Failure, CommentsEntity>> call(String movieId) async {
    return _repository.getLastComment(movieId);
  }
}

class AddCommentUseCase {
  AddCommentUseCase(this._repository);

  final CommentsRepository _repository;

  Future<Either<Failure, void>> call(CommentsModel model) async {
    return _repository.addComment(model);
  }
}
