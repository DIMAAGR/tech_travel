import 'package:dartz/dartz.dart';
import 'package:tech_travel/src/core/errors/failure.dart';
import 'package:tech_travel/src/data/models/add_like_model.dart';
import 'package:tech_travel/src/data/models/likes_model.dart';

abstract class LikesRepository {
  Future<Either<Failure, void>> likePost(AddLikeModel likeModel);
  Future<Either<Failure, void>> unlikePost(String likeId);
  Future<Either<Failure, LikesModel>> getLikes();
}
