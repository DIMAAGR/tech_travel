import 'package:dartz/dartz.dart';
import 'package:tech_travel/src/core/errors/failure.dart';
import 'package:tech_travel/src/data/models/add_like_model.dart';
import 'package:tech_travel/src/data/models/likes_model.dart';
import 'package:tech_travel/src/domain/repositories/likes_repository.dart';

class LikeUseCase {
  final LikesRepository _repository;

  LikeUseCase(this._repository);

  Future<Either<Failure, void>> call(AddLikeModel model) {
    return _repository.likePost(model);
  }
}

class UnlikeUseCase {
  final LikesRepository _repository;

  UnlikeUseCase(this._repository);

  Future<Either<Failure, void>> call(String likeId) {
    return _repository.unlikePost(likeId);
  }
}

class GetAllLikesUseCase {
  final LikesRepository _repository;

  GetAllLikesUseCase(this._repository);

  Future<Either<Failure, LikesModel>> call() {
    return _repository.getLikes();
  }
}
